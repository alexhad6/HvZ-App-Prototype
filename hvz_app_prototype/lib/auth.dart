import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Maybe make into a class, like this:
// class Auth {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   User getCurrentUser() {
//     return FirebaseAuth.instance.currentUser;
//   }
// }

FirebaseAuth _auth = FirebaseAuth.instance;

void initializeAuth() {
  _auth.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

void createAccount(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
