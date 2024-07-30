import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/edit_profile.dart';
import '../authentication/login_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _isDarkMode = false;
  String _phoneNumber = '';
  String _displayName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _phoneNumber = user.phoneNumber ?? 'No phone number available';
        _displayName = user.displayName ?? 'No display name available';
        _email = user.email ?? 'No email available';
      });
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const PhoneNumberInputScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to change profile picture
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://cdn4.iconfinder.com/data/icons/green-shopper/1068/user.png',
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _phoneNumber,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Navigate to notifications
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Edit Profile Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        displayName: _displayName,
                        email: _email,
                      ),
                    ),
                  ).then((_) => _fetchUserDetails()); // Refresh user details after editing
                },
                child: const Text('Edit Profile'),
              ),
            ),
            const SizedBox(height: 16),

            // Profile Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Settings Options
                  _buildSettingsOption(Icons.person, 'Edit Profile'),
                  _buildSettingsOption(Icons.security, 'Change Password'),
                  _buildSettingsOption(Icons.location_on, 'Manage Addresses'),
                  _buildSettingsOption(Icons.payment, 'Payment Methods'),
                  _buildSettingsOption(Icons.notifications, 'Notification Settings'),
                  _buildSettingsOption(Icons.info, 'About Us'),
                  _buildSettingsOption(Icons.exit_to_app, 'Logout', isLogout: true),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Dark Mode Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                      // Implement dark mode functionality
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(IconData icon, String title, {bool isLogout = false}) {
    return GestureDetector(
      onTap: () {
        if (isLogout) {
          _logout();
        } else {
          // Handle navigation for other settings
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: Icon(icon, color: Colors.teal),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
        ),
      ),
    );
  }
}
