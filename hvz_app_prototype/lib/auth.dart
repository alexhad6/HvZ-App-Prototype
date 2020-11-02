/// Authentication and Registration Component
///
/// Team: HvZ App
///
/// Members: Santiago Rodriguez, Alex Hadley, Matthew Waddell, Kyra Clark
///
/// Project 3C — Component Design: Authentication and Registration
///   Design: https://github.com/alexhad6/HvZ-app/blob/master/Administrative/Phase%203/design_3c_AH.dart
///   Primary author: Alex
///
/// This is a design document for the authentication and registration component
/// for the HvZ app. Currently the following is just an outline of the instance
/// variables and the public and private methods for this component. The
/// implementation is outlined using pseudo-code.
///
/// This component contains a main singleton class [Auth], with a simpler
/// class [AuthMessage] to return the success status and error messages from
/// sign in and registration operations.
library auth;

// Import firebase_auth library
import 'package:firebase_auth/firebase_auth.dart';

// Import google_sign_in library
import 'package:google_sign_in/google_sign_in.dart';

// Import tuple library
import 'package:tuple/tuple.dart';

// Checks for a internet connection.
import 'package:connectivity/connectivity.dart';

// Allows us to catch TimeoutException errors to test for internet connection.
import 'dart:async';

// The database component. Used to register new users with the database.
import 'database.dart';

/// Manages authentication and keeps track of the current user.
///
/// Relies on [Firebase] core being initialized. Before using the class, you
/// must call [Auth.initialize()]. This class is a singleton, so calling the
/// constructor [Auth()] should always return the same instance.
class Auth {
  /// Private record of singleton instance of [Auth].
  static Auth _instance;

  /// Reference to the [FirebaseAuth] instance.
  FirebaseAuth _firebaseAuth;

  /// Reference to a [GoogleSignIn] instance.
  GoogleSignIn _googleSignIn;

  /// Reference to the singleton instance of [Connectivity].
  Connectivity _connectivity;

  /// Reference the database component
  Database _database;

  /// The [User] that is currently signed in.
  User _user;

  /// The maximum [Duration] to wait for an operation involve internet to
  /// complete.
  final Duration _maxWaitTime = Duration(seconds: 5);

  /// The valid Claremont colleges email domains. Users are only allowed to
  /// register or sign in using an email from one of these domains.
  final Set<String> _claremontDomains = {
    'hmc.edu',
    'pitzer.edu',
    'pomona.edu',
    'cmc.edu',
    'scrippscollege.edu',
    'kgi.edu',
    'cgu.edu'
  };

  /// A list of the possible characters that can make up a feed code.
  final String _validChars = 'ACELNOPSTWXZ';

  /// The length of feed codes
  final int _feedCodeLength = 5;

  /// [Auth] constructor
  ///
  /// Returns a singleton instance of [Auth]. The first time this is called, it
  /// initializes the variables _firebaseAuth, _googleSignIn, and _connectivity.
  /// Usually, these can just be set to their usual values. Setting to custom
  /// values is mainly used for testing.
  ///
  /// Parameters:
  /// * `FirebaseAuth firebaseAuth` (optional, named)
  /// * `GoogleSignIn googleSignin` (optional, named)
  /// * `Connectivity connectivity` (optional, named)
  factory Auth(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      Connectivity connectivity,
      Database database}) {
    // If _instance has not been initialized (it is currently null):
    //   Create a new instance of Auth using private constructor Auth._().
    //   Set _instance to this new instance.

    // If _firebaseAuth is null:
    //   If parameter firebaseAuth is not null, set _firebaseAuth to it
    //   Otherwise, set _firebaseAuth to the default FirebaseAuth instance

    // If _googleSignIn is null:
    //   If parameter googleSignIn is not null, set _googleSignIn to it
    //   Otherwise, set _googleSignIn to a new GoogleSignIn()

    // If _database is null:
    //   If parameter database is not null, set _database to it
    //   Otherwise, set _database to a new Database()

    // If _connectivity is null:
    //   If parameter connectivity is not null, set _connectivity to it
    //   Otherwise, set _connectivity to the singleton instance Connectivity()

    return _instance;
  }

  /// Whether a user is currently signed in.
  bool get signedIn {
    // If _user is not null, then return true.

    return false;
  }

  /// The current user's unique ID; `null` if no user is signed in.
  String get uid {
    // If a user is signed in, return the user ID from _user.

    return null;
  }

  /// The current user's name; `null` if no user is signed in.
  String get name {
    // If a user is signed in, return the name from _user.

    return null;
  }

  /// The current user's email address; `null` if no user is signed in.
  String get email {
    // If a user is signed in, return the email from _user.

    return null;
  }

  /// Returns whether the current user has verified their email address; `null`
  /// if no user is signed in.
  bool get emailVerified {
    // If the user is signed in, return their verification status from _user.

    return null;
  }

  /// Initializes [Auth] by setting up a listener to update information on the
  /// current user.
  static Future<void> initialize() async {
    // Retrieve the userChanges stream from FirebaseAuth
    //   (This stream gives the current User whenever an action to update the
    //   user occurs.)

    // Add listener to the userChanges stream to save the User in _user whenever
    // an update occurs.

    // Wait for first value from stream so that everything is initialized.
    //   (FirebaseAuth automatically persists the currently logged in user
    //   between app sessions. When the app starts up, the userChanges stream is
    //   passed the current user. Here we wait for this first update to occur
    //   so that user info is accurate when the app continues to start up.)
  }

  /// Updates the current user's name.
  ///
  /// If no user is signed in, this function will do nothing.
  ///
  /// Parameters
  /// * `String name`: the new name to update to.
  Future<void> setName(String name) async {
    // If a user is signed in, update their name using _user.
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    // If a user is signed in, sign them out using the FirebaseAuth instance.
  }

  /// Creates a new user account with the provided email and password.
  ///
  /// If the account is created successfully, the user is automatically logged
  /// in. A verification email is sent to the user for them to verify their
  /// email. A unique feed code is generated. The user's feedcode, name, email,
  /// and user ID are added to the database.
  ///
  /// Parameters:
  /// * `String email`: the user's email address.
  /// * `String password`: the user's password.
  ///
  /// Returns:
  /// * `AuthMessage`
  ///   * `bool success`: whether the sign in was successful.
  ///   * `String errorMessage`: possible messages are below.
  ///     * (Empty string if success is true)
  ///     * Use a Claremont Colleges email address
  ///     * No internet connection
  ///     * Poor internet connection
  //      * Invalid email address
  ///     * Account for this email address already exists
  ///     * Password must have at least 6 characters
  Future<AuthMessage> registerWithEmail(String email, String password) async {
    // Whether the registration was successfull.
    bool success;

    // The appropriate errorMessage.
    String errorMessage;

    // If not _connected() (there is no internet connection):
    //   Set success to false
    //   Set errorMessage to 'no-connection'

    // Otherwise, if not _claremontColleges(email) (email not from 7Cs):
    //   Set success to false
    //   Set errorMessage to 'email-not-claremont'

    // Otherwise:

    //   Try:
    //     Create user with email and password using the FirebaseAuth instance.
    //       Set timeout to _maxWaitTime.
    //     Set success to true.
    //     Send verification email to the new user.
    //       Set timeout to _maxWaitTime.
    //     Call _registerUser().

    //   Catch FirebaseAuthException errors:
    //     Set success to false.
    //     Set error code to the code property of FirebaseAuthException
    //        (In this case, the possibilities are 'invalid-email',
    //        'email-already-in-use', or 'weak-password'.)

    //   Catch TimeoutException errors:
    //     Set success to false
    //     Set errorMessage to 'Poor internet connection'

    return AuthMessage._(success, errorMessage);
  }

  /// Signs in a user using the provided email and password.
  ///
  /// Parameters:
  /// * `String email`: the user's email address.
  /// * `String password`: the user's password.
  ///
  /// Returns:
  /// * `AuthMessage`
  ///   * `bool success`: whether the sign in was successful.
  ///   * `String errorMessage`: possible messages are below.
  ///     * (Empty string if success is true)
  ///     * Use a Claremont Colleges email address
  ///     * No internet connection
  ///     * Poor internet connection
  ///     * Invalid email address
  ///     * Email address doesn't match an existing account
  ///     * Incorrect password
  ///     * Your account is disabled
  Future<AuthMessage> signInWithEmail(String email, String password) async {
    // Whether the sign in was successfull.
    bool success;

    // The appropriate errorMessage.
    String errorMessage;

    // If not _connected() (there is no internet connection):
    //   Set success to false
    //   Set errorMessage to 'no-connection'

    // Otherwise, if not _claremontColleges(email) (email not from 7Cs):
    //   Set success to false
    //   Set errorMessage to 'email-not-claremont'

    // Otherwise:

    //   Try:
    //     Sign in user with email and password using the FirebaseAuth instance.
    //       Set timeout to _maxWaitTime.
    //     Set success to true.

    //   Catch FirebaseAuthException errors:
    //     Set success to false.
    //     Set error code to the code property of FirebaseAuthException
    //        (In this case, the possibilities are 'invalid-email',
    //        'user-not-found', 'wrong-password', or 'user-disabled'.)

    //   Catch TimeoutException errors:
    //     Set success to false
    //     Set errorMessage to 'Poor internet connection'

    return AuthMessage._(success, errorMessage);
  }

  /// Signs in or registers a user using Google authentication.
  ///
  /// If the user is new, their account is created and they are logged in. A
  /// unique feed code is generated. The user's feedcode, name, email,
  /// and user ID are added to the database.
  ///
  /// Returns:
  /// * `AuthMessage`
  ///   * `bool success`: whether the sign in was successful.
  ///   * `String errorMessage`: possible messages are below.
  ///     * (Empty string if success is true)
  ///     * Use a Claremont Colleges email address
  ///     * No internet connection
  ///     * Poor internet connection
  ///     * Google Sign-In was aborted
  ///     * Your account is disabled
  Future<AuthMessage> signInWithGoogle() async {
    // Whether the sign in was successfull.
    bool success;

    // The appropriate errorMessage.
    String errorMessage;

    // If not _connected() (there is no internet connection):
    //   Set success to false
    //   Set errorMessage to 'no-connection'

    // Otherwise:

    //   Try:

    //     Launch interactive Google Sign-In process using GoogleSignIn
    //     Save the GoogleSignInAccount that is returned

    //     If the Google sign in process was aborted:
    //       Set success to false
    //       Set errorCode to 'google-sign-in-aborted'

    //     Otherwise, if the user's email is not from the 7Cs:
    //       Set success to false
    //       Set errorMessage to 'email-not-claremont'

    //     Otherwise:
    //       Retrieve the GoogleSignInAuthentication details.
    //         Set timeout to _maxWaitTime.
    //       Create GoogleAuthCredential using the authentication details.
    //       Sign in user with Google credentials using FirebaseAuth instance.
    //         Set timeout to _maxWaitTime.
    //       Set success to true.
    //       If this is a new user:
    //         Send verification email to the new user.
    //           Set timeout to _maxWaitTime.
    //         Call _registerUser().

    //   Catch FirebaseAuthException errors:
    //     Set success to false.
    //     Set error code to the code property of FirebaseAuthException
    //        (In this case, this could be 'user-disabled'.)

    //   Catch TimeoutException errors:
    //     Set success to false
    //     Set errorMessage to 'Poor internet connection'

    return AuthMessage._(success, errorMessage);
  }

  /// Private constructor that initializes the [FirebaseAuth] instance.
  Auth._();

  /// Uses [Connectivity] to determine whether there is an internet connection.
  bool _connected() {
    // Get a ConnectivityResult

    // Return true if the ConnectivityResult is not none

    return false;
  }

  bool _claremontEmail(String email) {
    // If email does not contain an '@', return false

    // Otherwise, retrieve everything after the first '@'

    // If everything after the first '@' is in the set claremontDomains (see
    // above) then return true.

    return false;
  }

  /// Register a new user by generating a feed code for them and adding them
  /// to the database.
  Future<void> _registerUser() async {
    // Retrieve the total number of users who have registered from the database

    // Call _generateFeedCode on the total number of registered users plus 1

    // Save feedcode as a String

    // Call _addUser from the database with the following information:
    //   feedcode
    //   name
    //   email
    //   uid
  }

  /// Generates a unique feed code based on a integer. Feed codes are strings
  /// that can containt the characters in [validChars] and have length
  /// [feedCodeLength]. Thus, there are `pow(validChars.length,feedCodeLength)`
  /// possible combinations.
  ///
  /// Parameters:
  /// * `int number`: an integer from 0 to `pow(validChars.length,feedCodeLength) - 1`.
  String _generateFeedCode(int number) {
    // Assert that number is between 0 and pow(validChars.length,feedCodeLength)-1

    // Set numChars to the length of validChars

    // Get the digits of the number in base numChars (using the modulo operator
    // and integer division).
    //   (For example, if number was 200,000, numChars was 12, and
    //   feedCodeLength was 5, then the leftmost number would be
    //   200,000 ~/ pow(12, 5-1) = 9).

    // Set each character in the feed code to character in validChars
    // corresponding to the digit in base numChars.
    //   (For example, in base 12 200,000 becomes 9-7-8-10-8, which corrsponds
    //   to 'WSTXT'.)

    // Return the feed code.

    return null;
  }
}

/// Stores whether an auth operation was successful, and if not, the appropriate
/// error message for the app to display to the user.
///
/// Properties:
/// * `bool success`: whether the auth operation was successful.
/// * `String errorMessage`: the appropriate message to display.
///   * Possible messages:
///     * (Empty string if success is true)
///     * Use a Claremont Colleges email address
///     * No internet connection
///     * Poor internet connection
///     * Google Sign-In was aborted
///     * Invalid email address
///     * Account for this email address already exists
///     * Password must have at least 6 characters
///     * Email address doesn't match an existing account
///     * Incorrect password
///     * Your account is disabled
class AuthMessage {
  /// Possible error messages for each error code.
  static const Map<String, String> _errorMessages = {
    'email-not-claremont': 'Use a Claremont Colleges email address',
    'no-connection': 'No internet connection',
    'timeout': 'Poor internet connection',
    'google-sign-in-aborted': 'Google Sign-In was aborted',
    'invalid-email': 'Invalid email address',
    'email-already-in-use': 'Account for this email address already exists',
    'weak-password': 'Password must have at least 6 characters',
    'user-not-found': 'Email address doesn\'t match an existing account',
    'wrong-password': 'Incorrect password',
    'user-disabled': 'Your account is disabled',
  };

  /// Whether the auth operation was successful.
  bool success;

  /// The error message.
  String errorMessage;

  /// The error code.
  String _errorCode;

  /// Creates a new AuthMessage based on a success boolean and an error code.
  ///
  /// Parameters:
  /// * `bool success`: whether the auth operation was successful.
  /// * `String errorCode`: the code corresponding to the error that occurred.
  AuthMessage._(this.success, this._errorCode) {
    // If success is true, then set errorMessage to ''

    // Otherwise, if _errorMessages contains the _errorCode as a key:
    //   Set errorMessage to the corresponding value for the _errorCode

    // Otherwise:
    //   Throw an error (this accounts for [FirebaseAuthException]s that are
    //   caught by the try/catch but are expected to occur).
  }
}
