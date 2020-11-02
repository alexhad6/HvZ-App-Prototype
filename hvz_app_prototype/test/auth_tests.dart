/// Authentication and Registration Component Tests
///
/// Team: HvZ App
///
/// Members: Santiago Rodriguez, Alex Hadley, Matthew Waddell, Kyra Clark
///
/// Project 3C — Component Test Plan: Authentication and Registration
///   Design: https://github.com/alexhad6/HvZ-app/blob/master/Administrative/Phase%203/test_3c_AH.dart
///   Primary author: Alex
///
/// Tests can be run using Dart's test package. Instead of actually using the
/// dependencies of the authentication component, we can mock them using the
/// Mockito package for Dart (https://pub.dev/packages/mockito). This allows
/// us to truly test the authentication component in isolation. Additionally,
/// mocking gives us full control over the behavior of external components.
/// For example, we can simulate a bad internet connection or an aborted
/// Google Sign-In. Finally, we do not actually have to connect to Firebase
/// servers, which would slow down these tests. Also, we would actually have to
/// create and log into sample accounts, which is not ideal. Mocking solves
/// these problems and allows us to write automatic unit tests.
///
/// To the best of my knowledge at this point, the following tests span the
/// functionality of the authentication component and would give me high
/// confidence that it is implemented correctly. However, that said, additional
/// tests may still arise as the design is actually implemented. I expect that
/// some aspects of the design might change when they are implemented, so the
/// tests may have to change or be added to accordingly.
///
/// Some tests simply test that the correct type was returned or that no errors
/// occur. For example, the Auth constructor test does this. This may be simple,
/// but they are not low value. I tried to only include them in cases, such as
/// the case of the constructor, where some sort of initialization might occur
/// that could potentially cause an error. Mocking helps make more complicated
/// tests which use Authentication and the Database very efficient, fast, and
/// reliable.

// Import dart testing library
import 'package:test/test.dart';

// Import mockito library
import 'package:mockito/mockito.dart';

// Import authentication component
import 'package:hvz_app_prototype/auth.dart';

// Import dependencies mocked using Mockito
import 'auth_dependency_mocks.dart';

void main() {
  /// Blackbox tests, based only on specifications of public data and methods
  group('[Blackbox]', () {
    group('(Auth constructor)', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // and Database.

      test('Auth constructor returns an instance of Auth', () {
        // Justification: This tests that the public Auth constructor works.

        // Auth() will be called and assigned to a variable of type Auth. The
        // test passes if no errors occur.
      });

      test('Calling Auth() twice returns the same object', () {
        // Justification: Auth is a singleton class.

        // Auth() will be called twice and assigned to two variables. The test
        // passes if the two variables refer to the same object.
      });
    });

    group('(initialize)', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. Create an Auth() instance.

      test('A user state change listener is set up when initialized', () {
        // Justification: A listener should be set up when initialize is called.

        // Check if the mock function for creating a listener was called.
      });
    });

    group('(User attributes — signed in)', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. Create an Auth() instance. Call Auth.initialize().
      // A mock user (with known attributes) will be signed in using
      // signInWithEmail.

      test('After a user signs in, signedIn is true', () {
        // Justification: signedIn should be true if a user is signed in.

        // The test passes if signedIn is true.
      });

      test('If a user is signed in, uid is correct', () {
        // Justification: uid should return the user's ID.

        // The test passes if uid matches the mock user's ID.
      });

      test('If a user is signed in, name is correct', () {
        // Justification: name should return the user's name.

        // The test passes if name matches the mock user's name.
      });

      test('If a user\'s name changes, name updates to the new name', () {
        // Justification: name should update when the name changes.

        // The user's name is changed using setName(). The test passes if the
        // user's name matches the new name.
      });

      test('If a user is signed in, email is a nonempty string', () {
        // Justification: email should return the user's email.

        // The test passes if email matches the mock user's email.
      });

      test('If a user is signed in, emailVerified is correct', () {
        // Justification: emailVerified should return the user's email
        // verfication status.

        // The test passes if emailVerified matches the mock user's email
        // verification status.
      });

      test('If a user is signed in, signedIn is false after signOut()', () {
        // Justification: signOut() should sign the user out.

        // The user is signed out using signOut(). The test passes if signedIn
        // is false.
      });
    });

    group('(User attributes — signed out)', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. Create an Auth() instance. Call Auth.initialize().
      // A mock user will be signed in using signInWithEmail and then signed out
      // using signOut().

      test('After a user signs out, signedIn is false', () {
        // Justification: signedIn should be false if no user is signed in.

        // The test passes if signedIn is false.
      });

      test('If no user is signed in, uid is null', () {
        // Justification: uid should be null if no user is signed in.

        // The test passes if uid is null.
      });

      test('If no user is signed in, name is null', () {
        // Justification: name should be null if no user is signed in.

        // The test passes if name is null.
      });

      test('If no user is signed in, name is null after setting name', () {
        // Justification: setName should do nothing if user is not signed in.

        // setName is called on a new name. The test passes if name is still
        // null.
      });

      test('If no user is signed in, email is null', () {
        // Justification: email should be null if no user is signed in.

        // The test passes if email is null.
      });

      test('If no user is signed in, emailVerified is null', () {
        // Justification: emailVerified should be null if no user is signed in.

        // The test passes if emailVerified is null.
      });

      test('If no user is signed in, signedIn is false after signOut()', () {
        // Justification: signOut should do nothing if the user is already
        // signed out.

        // signOut() is called. The test passes if no errors occur and signedIn
        // is still false.
      });
    });

    group('(Sign in)', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. Create an Auth() instance. Call Auth.initialize().

      test('Valid email and password signs in correctly', () {
        // Justification: a user should be able to sign in with their correct
        // password.

        // Sign out any previously signed in user. Sign in with valid
        // credentials for a mock user. Test passes if the returned AuthMessage
        // has success true.
      });

      test('Check that user is signed in after successful sign in', () {
        // Justification: a user should be signedIn after a successful sign in.

        // Sign out any previously signed in user. Sign in with valid
        // credentials for a mock user. Test passes if signedIn is true.
      });

      test('Sign in correctly handles non-7C email', () {
        // Justification: a user cannot sign in with a non-7C email.

        // Sign out any previously signed in user. Sign in with a non-7C email
        // as the email. Test passes if the AuthMessage returned has success
        // false and errorMessage 'Use a Claremont Colleges email address'.
      });

      test('Sign in correclty handles badly formatted email', () {
        // Justification: a user cannot sign in with a non-7C email.

        // Sign out any previously signed in user. Sign in with a badly formed
        // email. Test passes if the AuthMessage returned has success false and
        // errorMessage 'Invalid email address'.
      });

      test('Sign in correctly handles no matching user error', () {
        // Justification: a user must sign in with an existing account.

        // Sign out any previously signed in user. Sign in with an 7C email
        // corresponding to no existing mock user. Test passes if the
        // AuthMessage returned has success false and errorMessage 'Email
        // address doesn't match an existing account'.
      });

      test('Incorrect password returns correct error message', () {
        // Justification: a user must sign in with the correct password.

        // Sign out any previously signed in user. Sign in with a valid email
        // but an incorrect password for a mock user. Test passes if the
        // AuthMessage returned has success false and errorMessage 'Incorrect
        // password'.
      });

      test('Disabled account returns correct error message', () {
        // Justification: a user cannot sign in with a disabled account.

        // Sign out any previously signed in user. Sign in with a disabled
        // mock user account. Test passes if the AuthMessage returned has
        // success false and errorMessage 'Your account is disabled'.
      });

      test('Valid Google credentials signs in correctly', () {
        // Justification: a user should be able to sign in with their correct
        // Google credentials.

        // Sign out any previously signed in user. Sign in with valid Google
        // credentials for a mock user. Test passes if the returned AuthMessage
        // has success true.
      });

      test('Check that user is signed in after successful Google sign in', () {
        // Justification: a user should be signed in after signing in with
        // Google.

        // Sign out any previously signed in user. Sign in with valid Google
        // credentials for a mock user. Test passes if signedIn is true.
      });

      test('If Google sign-in is aborted, returns correct error message', () {
        // Justification: if Google sign-in is aborted, this should be handled.

        // Sign out any previously signed in user. Start the mock Google sign-in
        // process but then abort it. Test passes if returned AuthMessage has
        // success false and errorMessage 'Google Sign-In was aborted'.
      });

      test('Disabled Google account returns correct error message', () {
        // Justification: a user cannot sign in with a disabled account.

        // Sign out any previously signed in user. Sign in with Google
        // credentials for a disabled mock user account. Test passes if the
        // AuthMessage returned has success false and errorMessage 'Your account
        // is disabled'.
      });
    });

    group('(Registration', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. Create an Auth() instance. Call Auth.initialize().

      test('Registering user with valid email and password succeeds', () {
        // Justification: users can be registered using their username and
        // password.

        // Sign out any previously signed in user. A user is registered with a
        // Claremont email address using registerWithEmail. The test passes if
        // the AuthMessage returned has success true.
      });

      test('Newly registered user is automatically signed in', () {
        // Justification: new users should be automatically signed in.

        // Sign out any previously signed in user. A user is registered with a
        // Claremont email address using registerWithEmail. The test passes if
        // signed in is true.
      });

      test('Registering with any 7C email is successful', () {
        // Justification: students from all Claremont colleges should be able
        // to register.

        // Sign out any previously signed in user. Register seven users with
        // the email domains hmc.edu, pitzer.edu, pomona.edu, cmc.edu,
        // scrippscollege.edu, kgi.edu, and cgu.edu. The test passes if the
        // AuthMessages all have success true.
      });

      test('Registration correclty handles non-Claremont emails', () {
        // Justification: no one except 7C students are allowed to register.

        // Sign out any previously signed in user. Register a user with a
        // non Claremont email. The test passes if the AuthMessage has success
        // false and errorMessage 'Use a Claremont Colleges email address'.
      });

      test('Registration correctly handles badly formatted email address', () {
        // Justification: cannot register without an email address.

        // Sign out any previously signed in user. Register a user with a badly
        // formed email address. Test passes if AuthMessage returned has success
        // false and successMessage 'Invalid email address'.
      });

      test('Registration correctly handles already existing account', () {
        // Justification: cannot register two users with the same email.

        // Sign out any previously signed in user. Register a user with an email
        // address for an existing account. Test passes if AuthMessage returned
        // has success false and successMessage 'Account for this email address
        // already exists'.
      });

      test('Registration correctly handles short password', () {
        // Justification: password must be at least 6 characters long (enforced
        // by Firebase).

        // Sign out any previously signed in user. Register a user with a
        // password shorter than 6 characters. Test passes if AuthMessage
        // returned has success false and successMessage 'Password must have at
        // least 6 characters'.
      });

      test('Registration sends valid feed code to database', () {
        // Justification: registration should send a feed code string to the
        // database.

        // Sign out any previously signed in user. Register a user using a valid
        // email and password. Check if the mock database was given a nonempty
        // feedcode string. Test passes if it was.
      });

      test('Registration sends correct email to database', () {
        // Justification: registration should send the user's email to the
        // database.

        // Sign out any previously signed in user. Register a user using a valid
        // email and password. Check if the mock database was given the correct
        // email. The test passes if it was.
      });

      test('Registration sends correct uid to database', () {
        // Justification: registration should send the user's uid to the
        // database.

        // Sign out any previously signed in user. Register a user using a valid
        // email and password. Check if the mock database was given the correct
        // uid. The test passes if it was.
      });

      test('Registration sends verification email', () {
        // Justification: registration should send a verification email.

        // Sign out any previously signed in user. Register a user using a valid
        // email and password. Check if the mock user has been called on to send
        // a verification email.
      });

      test('Google registration sends valid feed code to database', () {
        // Justification: Google registration should send a feed code string to
        // the database.

        // Sign out any previously signed in user. Register a user using mock
        // Google credentials. Check if the mock database was given a nonempty
        // feedcode string. Test passes if it was.
      });

      test('Google registration sends correct email to database', () {
        // Justification: Google registration should send the user's email to the
        // database.

        // Sign out any previously signed in user. Register a user using mock
        // Google credentials. Check if the mock database was given the correct
        // email. The test passes if it was.
      });

      test('Google registration sends correct uid to database', () {
        // Justification: Google registration should send the user's uid to the
        // database.

        // Sign out any previously signed in user. Register a user using mock
        // Google credentials. Check if the mock database was given the correct
        // uid. The test passes if it was.
      });
    });

    group('(no internet)', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. In this case, the mock Connectivity will return
      // none. Create an Auth() instance. Call Auth.initialize().

      test('Email sign in correctly handles no internet connection', () {
        // Justification: a user cannot sign in with no internet connection.

        // Sign out any previously signed in user. Sign in with a valid email
        // and password for a mock user. Test passes if the AuthMessage returned
        // has success false and errorMessage 'No internet connection'.
      });

      test('Google Sign-In correctly handles no internet connection', () {
        // Justification: a user cannot sign in with no internet connection.

        // Sign out any previously signed in user. Sign in with valid Google
        // credentials for a mock user. Test passes if the returned AuthMessage
        // has success false and errorMessage 'No internet connection'.
      });

      test('Registration correctly handles no internet connection', () {
        // Justification: a user cannot register with no internet connection.

        // Sign out any previously signed in user. Register a user with a valid
        // email and password. The test passes if the returned AuthMessage has
        // success false and errorMessage 'No internet connection'.
      });
    });

    group('slow internet', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. In this case, the mock FirebaseAuth will run
      // forever when asked to do an internet operation.

      test('Email sign in correctly handles poor internet connection ', () {
        // Justification: a user cannot sign in with poor internet connection.

        // Sign out any previously signed in user. Sign in with a valid email
        // and password for a mock user. Test passes if the AuthMessage returned
        // has success false and errorMessage 'Poor internet connection'.
      });

      test('Google Sign-In correctly handles poor internet connection ', () {
        // Justification: a user cannot sign in with poor internet connection.

        // Sign out any previously signed in user. Sign in with valid Google
        // credentials for a mock user. Test passes if the returned AuthMessage
        // has success false and errorMessage 'Poor internet connection'.
      });

      test('Registration correctly handles poor internet connection ', () {
        // Justification: a user cannot register with poor internet connection.

        // Sign out any previously signed in user. Register a user with a valid
        // email and password. The test passes if the returned AuthMessage has
        // success false and errorMessage 'Poor internet connection'.
      });
    });
  });

  /// Whitebox tests, based on code
  ///
  /// Because the various error handling behavior was heavily specified for
  /// public methods in the specifications and design, the black box tests
  /// actually cover a large range of behaviors. The ability to mock things
  /// allows us to examine that some behavior explained in the specifications
  /// is actually happening. So there does not need to be a lot of whitebox
  /// tests.
  ///
  /// However, the full range of behavior of some private methods, such as
  /// _generateFeedCode, cannot be easily tested without thinking more about
  /// the implementation of the code.
  group('[Whitebox]', () {
    group('(Feed code generation)', () {
      // Setup: Initialize mocks for FirebaseAuth, GoogleSignIn, Connectivity,
      // Database, and User. In this case, the mock Database will be able to
      // give custom numbers of users to the private _generateFeedCode function,
      // which will in turn pass the feed code to the mock Database so that we
      // can see it. We will also need to implement the following parameters for
      // feed codes from the Auth class:
      final String _validChars = 'ACELNOPSTWXZ';
      final int _feedCodeLength = 5;

      test('Feed code generator rejects values out of allowable range', () {
        // Justification: There should be an assertion error if the number given
        // to _generateFeedCode is beyond the allowable range.

        // Sign out any previously signed in user. Initialize a number beyond
        // the allowable range. Make the mock Database return this number when
        // the number of registered players is requested. Register a new mock
        // user with a valid email and password. Test passes if an assertion
        // error occurs.
      });

      test('Feed code is correct', () {
        // Justification: Feed codes should be generated correctly according to
        // the algorithm outlined in _generateFeedCode.

        // Sign out any previously signed in user. Initialize a number and its
        // known corresponding feed code. Make the mock Database return this
        // number when the number of registered players is requested. Register a
        // new mock user with a valid email and password. Retrieve the feed code
        // that is passed to the mock database. Test passes if this feed code
        // matches the expected one.
      });
    });
  });
}
