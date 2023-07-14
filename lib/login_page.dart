// login_page.dart

import 'package:flutter/material.dart';
import 'auth.dart';
// Firebase core, needed for all Firebase features
import 'package:firebase_core/firebase_core.dart';

// Firebase Authentication package
import 'package:firebase_auth/firebase_auth.dart';

// Google Sign In package
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: Text('Login with Google'),
          onPressed: () async {
            final user = await _authService.signInWithGoogle();
            if (user != null) {
              Navigator.of(context).pushReplacementNamed('/home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed')),
              );
            }
          },
        ),
      ),
    );
  }
}
