import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/Screens/mainHomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationid;
  const OtpVerificationScreen({super.key, required this.phoneNumber, required this.verificationid});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onSendOtpPressed() async {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationid,
          smsCode: otp,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainHomeScreen()),
              (Route<dynamic> route) => false,
        );
      } catch (ex) {
        log(ex.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete OTP.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/logo.png", height: 150.h, width: 150.w),
            Text(
              'An OTP has been sent to ${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildOtpInput(),
            SizedBox(height: 30.h),
            SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: _onSendOtpPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Verify OTP', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
            width: 50.w,
            height: 70.h,
            child: TextField(
              focusNode: _focusNodes[index],
              controller: _otpControllers[index],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14.0.h),
                counterText: '', // Hide the counter text
              ),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  if (index < 5) {
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  }
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
