import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tuple/tuple.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async' show TimeoutException;

/// Manages authentication and keeps track of the current user.
///
/// Relies on [Firebase] core being initialized. Before using the class, you
/// must call [Auth.initialize()]. This class is a singleton, and its
/// properties and methods are accessed via [Auth.instance].
class Auth {
  /// The singleton instance of [Auth].
  static Auth _instance;

  /// Reference to the [FirebaseAuth] instance.
  FirebaseAuth _auth;

  /// Reference to the singleton instance of [Connectivity].
  Connectivity _connectivity;

  /// The [User] that is currently signed in.
  User _user;

  final Duration _maxWaitTime = Duration(seconds: 5);

  /// Private constructor (disables public constructor).
  Auth._init() {
    if (_auth == null) {
      _auth = FirebaseAuth.instance;
    }
    if (_connectivity == null) {
      _connectivity = Connectivity();
    }
  }

  /// Returns the singleton [Auth] instance.
  static Auth get instance {
    if (_instance == null) {
      _instance = Auth._init();
    }
    return _instance;
  }

  /// Returns whether a user is currently signed in.
  bool get signedIn {
    return _user != null;
  }

  /// The current user's unique ID.
  String get uid {
    if (signedIn) {
      return _user.uid;
    } else {
      return null;
    }
  }

  /// The current user's name.
  String get name {
    if (signedIn) {
      return _user.displayName;
    } else {
      return null;
    }
  }

  /// The current user's email address.
  String get email {
    if (signedIn) {
      return _user.email;
    } else {
      return null;
    }
  }

  /// Returns whether the current user has verified their email address.
  bool get emailVerified {
    if (signedIn) {
      return _user.emailVerified;
    } else {
      return null;
    }
  }

  /// Initializes [Auth] by setting up a listener to update information on the
  /// current user.
  static Future<void> initialize() async {
    // Retrieve the userChanges stream from FirebaseAuth
    Stream<User> _userChangesStream = instance._auth.userChanges();

    // Add listener to save user data when the user changes
    _userChangesStream.listen((User user) {
      instance._user = user;
      print('Recieved update!!!');
    });

    // Wait for first value from stream so that everything is initialized
    await _userChangesStream.first;
  }

  /// Updates the current user's name.
  Future<void> setName(String name) async {
    if (signedIn) {
      await _user.updateProfile(displayName: name);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> registerWithEmail(String email, String password) async {
    ConnectivityResult connection = await _connectivity.checkConnectivity();
    print(connection);
    if (connection == ConnectivityResult.none) {
      return AuthMessage(false, 'no-connection');
    } else {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .timeout(_maxWaitTime);
      } on FirebaseAuthException catch (e) {
        return AuthMessage(false, e.code);
      } on TimeoutException {
        return AuthMessage(false, 'timeout');
      }
    }
  }

  Future<Tuple2<bool, String>> signInWithEmail(
      String email, String password) async {
    if (_claremontEmail(email)) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return Tuple2<bool, String>(true, '');
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'There was an error.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }
        return Tuple2<bool, String>(false, errorMessage);
      }
    } else {
      return Tuple2<bool, String>(
          false, 'Please use a Claremont Colleges email address.');
    }
  }

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // The user aborted Google sign in
      return false;
    } else {
      if (_claremontEmail(googleUser.email)) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        /// Sign in with the [GoogleAuthCredential]
        await _auth.signInWithCredential(credential);

        return true;
      } else {
        return false;
      }
    }
  }

  bool _claremontEmail(String email) {
    // parse string to @ symbol
    return true;
  }
}

class AuthMessage {
  /// Possible error messages for each error code.
  static const Map _messages = {
    'email-not-claremont': 'Use a Claremont Colleges email address',
    'no-connection': 'No internet connection',
    'timeout': 'Poor internet connection',
    'invalid-email': 'Invalid email address',
    'email-already-in-use': 'Account for this email address already exists',
    'weak-password': 'Password must have at least 6 characters',
    'google-sign-in-aborted': 'Google sign in was aborted'
  };

  /// Whether the auth operation was successful.
  bool success;

  /// The error message.
  String message;

  /// The error code.
  String _errorCode;

  AuthMessage(this.success, this._errorCode) {
    if (success) {
      message = '';
    } else if (_messages.containsKey(_errorCode)) {
      message = _messages[_errorCode];
    } else {
      message = 'An error occurred with code $_errorCode';
    }
  }
}
