// Here we basically import the necessary packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Firebase core, needed for all Firebase features
import 'package:firebase_core/firebase_core.dart';

// Firebase Authentication package
import 'package:firebase_auth/firebase_auth.dart';

// Google Sign In package
import 'package:google_sign_in/google_sign_in.dart';

//Here we create class for the authentication service
class AuthService {
  // Here we create instance variables for Firebase Auth and Google Sign-In
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Create a getter to access the auth state changes stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //This getter creates a stream of Firebase User objects, which will update whenever the user's
  //authentication state changes.

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    // This line signs the user out of their Google account.

    await _firebaseAuth.signOut();
    // This line signs the user out of their Firebase account.
  }

  Future<User?> signInWithGoogle() async {
    //This line opens the Google Sign-In flow and waits for the user to select an account. Once the user has selected an account
    // it returns an instance of GoogleSignInAccount
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Checks if a Google account was successfully selected.
    if (googleUser != null) {
      //This line retrieves the authenticatoin details from the Google account that was selected.
      //It includes an ID token and access token, which are needed to authenticate with Firebase.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      //Here the ID Token and Access Token are then packagrs into a credential object using the GoogleAuthProvider.crediential method.
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      //The credential object is used to sign in with Firebase. This line communicates with Firebase to authenticate the user, and returns a UserCredential object if sucessful.

      return userCredential.user;
      //The user object contained in the UserCredentyial is returned.
    }
    return null;
    // If a Google account was not succesffully selected, the function returns null.
  }
}
