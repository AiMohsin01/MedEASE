import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:medease/repository/screens/bottomnav/bottomnavscreen.dart';
import 'package:medease/repository/screens/login/email_login_screen.dart';
import 'package:medease/repository/screens/login/signup_screen.dart';
import 'package:medease/repository/widgets/uihelper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null && context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavScreen()), // Navigate to main screen
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to sign in with Google: ${e.message}")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.65,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  // Replaced the broken URL with a valid, high-quality image link that matches the theme.
                  image: NetworkImage("https://images.pexels.com/photos/6749778/pexels-photo-6749778.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // White Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.55,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiHelper.CustomImage(
                    img: "logoandtag.png",
                    width: 180,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  _buildLoginButton(
                    context: context,
                    text: "Login with Google",
                    icon: const Text("G", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                    onTap: () => _signInWithGoogle(context),
                  ),
                  const SizedBox(height: 15),
                  _buildLoginButton(
                    context: context,
                    text: "Login with Email",
                    icon: const Icon(Icons.email_outlined, color: Colors.black, size: 24),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EmailLoginScreen()), 
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildLoginButton(
                    context: context,
                    text: "Signup",
                    icon: const Icon(Icons.person_add_alt_1_outlined, color: Colors.black, size: 24),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignupScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable button widget
  Widget _buildLoginButton({
    required BuildContext context,
    required String text,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24, width: 24, child: Center(child: icon)),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
