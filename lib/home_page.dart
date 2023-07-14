// home_page.dart

import 'package:flutter/material.dart';
import 'auth.dart';
// Firebase core, needed for all Firebase features
import 'package:firebase_core/firebase_core.dart';

// Firebase Authentication package
import 'package:firebase_auth/firebase_auth.dart';

// Google Sign In package
import 'package:google_sign_in/google_sign_in.dart';


class HomePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authService.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to Home Page!'),
      ),
    );
  }
}
