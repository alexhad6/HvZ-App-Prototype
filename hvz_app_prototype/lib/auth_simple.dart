import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  /// The [User] that is currently signed in.
  User _user;

  /// Private constructor (disables public constructor).
  Auth._() {
    _auth = FirebaseAuth.instance;
  }

  /// Returns the singleton [Auth] instance.
  factory Auth() {
    if (_instance == null) {
      _instance = Auth._();
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
  Future<void> initialize() async {
    // Retrieve the userChanges stream from FirebaseAuth
    Stream<User> _userChangesStream = _auth.userChanges();

    // Add listener to save user data when the user changes
    _userChangesStream.listen((User user) {
      _user = user;
      print('Recieved update!');
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
    await _auth.signOut();
  }

  Future<AuthMessage> registerWithEmail(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return AuthMessage(true, '');
  }

  Future<AuthMessage> signInWithEmail(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return AuthMessage(true, '');
  }

  Future<AuthMessage> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

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

    return AuthMessage(true, '');
  }
}

class AuthMessage {
  /// Whether the auth operation was successful.
  bool success;

  /// The error code.
  String errorCode;

  AuthMessage(this.success, this.errorCode);
}
