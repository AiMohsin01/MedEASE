import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medease/repository/screens/bottomnav/bottomnavscreen.dart';
import 'package:medease/repository/screens/login/loginscreen.dart';
import 'package:medease/repository/utils/local_auth_storage.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? _isLoggedInLocally;

  @override
  void initState() {
    super.initState();
    _loadLocalLoginFlag();
  }

  Future<void> _loadLocalLoginFlag() async {
    final bool flag = await LocalAuthStorage.readIsLoggedIn();
    if (!mounted) return;
    setState(() {
      _isLoggedInLocally = flag;
    });
  }

  @override
  Widget build(BuildContext context) {
    // While we don't know the local flag yet, show a simple splash/loading
    if (_isLoggedInLocally == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If local flag says logged in, show main app regardless of Firebase state
    if (_isLoggedInLocally == true) {
      return const BottomNavScreen();
    }

    // Otherwise fallback to Firebase auth state
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // User is signed in, show the main app screen
        return const BottomNavScreen();
      },
    );
  }
}
