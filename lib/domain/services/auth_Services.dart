import 'package:firebase_auth/firebase_auth.dart';
import 'package:dukascan_go/domain/models/response/response_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<ResponseLogin> loginController( String email, String password ) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        return ResponseLogin(resp: true, msg: 'Login successful', user: user);
      } else {
        return ResponseLogin(resp: false, msg: 'Login failed');
      }
    } on FirebaseAuthException catch (e) {
      return ResponseLogin(resp: false, msg: e.message ?? 'An error occurred');
    }
  }

  Future<ResponseLogin> renewLoginController() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      return ResponseLogin(resp: true, msg: 'Token renewed', user: user);
    } else {
      return ResponseLogin(resp: false, msg: 'Not logged in');
    }
  }

  Future<ResponseLogin> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        return ResponseLogin(resp: true, msg: 'Google login successful', user: user);
      } else {
        return ResponseLogin(resp: false, msg: 'Google login failed');
      }
    } catch (e) {
      return ResponseLogin(resp: false, msg: e.toString());
    }
  }

  Future<ResponseLogin> facebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (user != null) {
          return ResponseLogin(resp: true, msg: 'Facebook login successful', user: user);
        } else {
          return ResponseLogin(resp: false, msg: 'Facebook login failed');
        }
      } else {
        return ResponseLogin(resp: false, msg: 'Facebook login failed');
      }
    } catch (e) {
      return ResponseLogin(resp: false, msg: e.toString());
    }
  }
}

final authServices = AuthServices();