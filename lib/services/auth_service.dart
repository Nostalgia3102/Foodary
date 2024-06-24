import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  User? get user {
    return _user;
  }

  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChangesStreamListener);
  }

  Future<bool> login(String email, String password) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user != null) {
        _user = credentials.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> register(String email, String password) async {
    try {
      final registerCreds = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (registerCreds.user != null) {
        _user = registerCreds.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signUpWithGoogle() async {
    try {
      print("INSIDE SIGN UP OPTION");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        print(googleAuth.toString());

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        print(credential.toString());

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        if (userCredential.additionalUserInfo!.isNewUser) {
          _user = userCredential.user;
          return true;
        }
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> logInWithGoogle() async {
    /// TO BE IMPLEMENTED FOR LOGIN VS SIGNUP FLOW:
    /// TEMPORARY SOLUTION -> 2 API Call kardo jab tak FireStore nahi banta

    try {
      print("INSIDE LOGIN WITH GOOGLE");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      print(googleUser.toString());

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        print(credential.toString());

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        print(userCredential.toString());

        bool ans = userCredential.additionalUserInfo!.isNewUser;
        print("THE ANS --> $ans");

        if (!userCredential.additionalUserInfo!.isNewUser) {
          _user = userCredential.user;
          return true;
        } else {
          await FirebaseAuth.instance.currentUser!.delete();
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final OAuthCredential facebookOAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookOAuthCredential);
      if (!userCredential.additionalUserInfo!.isNewUser) {
        _user = userCredential.user;
        return true;
      } else {
        await FirebaseAuth.instance.currentUser!.delete();
      }
      return false;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> signUpWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final OAuthCredential facebookOAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookOAuthCredential);
      if (userCredential.additionalUserInfo!.isNewUser) {
        _user = userCredential.user;
        return true;
      }
      return false; //either user is already registered or an exception has occurred.
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void authStateChangesStreamListener(User? user) {
    user != null ? _user = user : _user = null;
  }
}
