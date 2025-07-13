import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/data/local_secure/secure_storage.dart';
import 'package:restaurant/domain/models/response/response_login.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ResponseLogin> loginController(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        final String? token = await user.getIdToken();
        await secureStorage.persistenToken(token!);
        return ResponseLogin(resp: true, msg: 'Login successful');
      } else {
        return ResponseLogin(resp: false, msg: 'Login failed');
      }
    } on FirebaseAuthException catch (e) {
      return ResponseLogin(resp: false, msg: e.message!);
    }
  }

  Future<ResponseLogin> renewLoginController() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String? token = await user.getIdToken(true);
      await secureStorage.persistenToken(token!);
      return ResponseLogin(resp: true, msg: 'Token renewed');
    } else {
      return ResponseLogin(resp: false, msg: 'User not logged in');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await secureStorage.deleteSecureStorage();
  }
}

final authServices = AuthServices();