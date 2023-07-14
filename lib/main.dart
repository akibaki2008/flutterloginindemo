import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginindemo/login_page.dart';
import 'auth.dart'; // your auth script
import 'firebase_options.dart';
import 'home_page.dart'; // your home page script

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("Error");
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}",
                    textDirection: TextDirection.ltr),
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print("GOOD");
          return Directionality(
            textDirection: TextDirection.ltr,
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final User? user = snapshot.data;
                  if (user == null) {
                    return LoginPage();
                  } else {
                    return HomePage();
                  }
                }
                return CircularProgressIndicator();
              },
            ),
          );
        }
        print("AlsoGood");
        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
