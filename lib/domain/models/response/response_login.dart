import 'package:firebase_auth/firebase_auth.dart' as firebase;

class ResponseLogin {

  final bool resp;
  final String msg;
  final firebase.User? user;

  ResponseLogin({
    required this.resp,
    required this.msg,
    this.user,
  });

}

class User {
    
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? image;
  final String? email;
  final String? phone;
  final int? rolId;
  final String? notificationToken;

  User({
    required this.uid,
    this.firstName,
    this.lastName,
    this.phone,
    this.image,
    this.email,
    this.rolId,
    this.notificationToken
  });

  factory User.fromFirebase(firebase.User user) => User(
    uid: user.uid,
    firstName: user.displayName,
    email: user.email,
    image: user.photoURL,
  );

}
