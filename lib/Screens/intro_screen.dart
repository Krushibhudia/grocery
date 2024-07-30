import 'package:grocery/Screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  final PageController _controller = PageController();

  IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set screen background color to white
      body: PageView(
        controller: _controller,
        children: [
          const IntroPage(
            title: 'Welcome to Grocery App',
            description: 'Discover fresh groceries delivered to your door. Enjoy a wide variety of products and seamless shopping experience.',
            imagePath: 'https://i.pinimg.com/originals/e9/99/92/e999929793729cbd656581bca1caf427.gif', // Network image
          ),
          const IntroPage(
            title: 'Easy Shopping',
            description: 'Shop for your favorite groceries with ease. Browse through categories, add items to your cart, and checkout effortlessly.',
            imagePath: 'https://i.pinimg.com/originals/dd/f7/62/ddf7620b1a1af96d24f1413bb336f096.gif', // Network image
          ),
          const IntroPage(
            title: 'Fast Delivery',
            description: 'Get your groceries delivered fast and fresh. Our reliable delivery service ensures your items reach you on time and in perfect condition.',
            imagePath: 'https://cdn.dribbble.com/users/221637/screenshots/12282529/rider.gif', // Network image
          ),
          IntroPage(
            title: 'Get Started',
            description: 'Let\'s start shopping! Sign up now and enjoy exclusive offers and personalized recommendations.',
            imagePath: 'https://static.dribbble.com/users/58362/screenshots/2892945/groceries.gif', // Network image
            isLastPage: true,
            onGetStarted: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PhoneNumberInputScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;
  final VoidCallback? onGetStarted;

  const IntroPage({super.key, 
    required this.title,
    required this.description,
    required this.imagePath,
    this.isLastPage = false,
    this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Network image outside the card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0), // Horizontal spacing
          child: Image.network(
            imagePath,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        // Card with rounded corners and teal background
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20.0), // Horizontal spacing
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
          elevation: 5, // Shadow for card
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal, // Teal background color
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            padding: const EdgeInsets.all(20.0), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 28, // Increased font size for title
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 18, // Increased font size for description
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        if (isLastPage)
          ElevatedButton(
            onPressed: onGetStarted,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              textStyle: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 20, // Increased font size for button
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: const Text('Get Started', style: TextStyle(color: Colors.white)),
          ),
      ],
    );
  }
}
