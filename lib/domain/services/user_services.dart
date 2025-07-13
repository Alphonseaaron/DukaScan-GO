import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:restaurant/data/local_secure/secure_storage.dart';
import 'package:restaurant/domain/models/response/address_one_response.dart';
import 'package:restaurant/domain/models/response/addresses_response.dart';
import 'package:restaurant/domain/models/response/response_default.dart';
import 'package:restaurant/domain/models/response/response_login.dart';
import 'package:restaurant/domain/models/response/user_updated_response.dart';
import 'package:restaurant/main.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<User> getUserById() async {
    final user = _auth.currentUser;
    final response = await _firestore.collection('users').doc(user!.uid).get();
    return User.fromJson(response.data()!);
  }

  Future<ResponseDefault> editProfile(
      String name, String lastname, String phone) async {
    final user = _auth.currentUser;
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .update({'firstname': name, 'lastname': lastname, 'phone': phone});
    return ResponseDefault(resp: true, msg: 'Profile updated successfully');
  }

  Future<UserUpdated> getUserUpdated() async {
    final user = _auth.currentUser;
    final response = await _firestore.collection('users').doc(user!.uid).get();
    return UserUpdated.fromJson(response.data()!);
  }

  Future<ResponseDefault> changePassword(
      String currentPassword, String newPassword) async {
    final user = _auth.currentUser;
    final cred = auth.EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);
    await user.reauthenticateWithCredential(cred);
    await user.updatePassword(newPassword);
    return ResponseDefault(resp: true, msg: 'Password updated successfully');
  }

  Future<ResponseDefault> changeImageProfile(String image) async {
    // Implement with Firebase Storage
    return ResponseDefault(resp: false, msg: 'Not implemented');
  }

  Future<ResponseDefault> registerDelivery(String name, String lastname,
      String phone, String email, String password, String image, String nToken) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    await _firestore.collection('users').doc(user!.uid).set({
      'firstname': name,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'rolId': '2', // Delivery role
      'notification_token': nToken,
    });
    return ResponseDefault(resp: true, msg: 'Delivery registered successfully');
  }

  Future<ResponseDefault> registerClient(String name, String lastname,
      String phone, String image, String email, String password, String nToken) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    await _firestore.collection('users').doc(user!.uid).set({
      'firstname': name,
      'lastname': lastname,
      'phone': phone,
      'email': email,
      'rolId': '3', // Client role
      'notification_token': nToken,
    });
    return ResponseDefault(resp: true, msg: 'Client registered successfully');
  }

  Future<List<ListAddress>> getAddresses() async {
    final user = _auth.currentUser;
    final response = await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('addresses')
        .get();
    return response.docs
        .map((doc) => ListAddress.fromJson(doc.data()))
        .toList();
  }

  Future<ResponseDefault> deleteStreetAddress(String idAddress) async {
    final user = _auth.currentUser;
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('addresses')
        .doc(idAddress)
        .delete();
    return ResponseDefault(resp: true, msg: 'Address deleted successfully');
  }

  Future<ResponseDefault> addNewAddressLocation(
      String street, String reference, String latitude, String longitude) async {
    final user = _auth.currentUser;
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('addresses')
        .add({
      'street': street,
      'reference': reference,
      'latitude': latitude,
      'longitude': longitude
    });
    return ResponseDefault(resp: true, msg: 'Address added successfully');
  }

  Future<AddressOneResponse> getAddressOne() async {
    final user = _auth.currentUser;
    final response = await _firestore
        .collection('users')
        .doc(user!.uid)
        .collection('addresses')
        .limit(1)
        .get();
    return AddressOneResponse.fromJson(response.docs.first.data());
  }

  Future<ResponseDefault> updateNotificationToken() async {
    final user = _auth.currentUser;
    final nToken = await pushNotification.getNotificationToken();
    await _firestore
        .collection('users')
        .doc(user!.uid)
        .update({'notification_token': nToken});
    return ResponseDefault(resp: true, msg: 'Token updated successfully');
  }

  Future<List<String>> getAdminsNotificationToken() async {
    final response = await _firestore
        .collection('users')
        .where('rolId', isEqualTo: '1')
        .get();
    return response.docs
        .map((doc) => doc.data()['notification_token'] as String)
        .toList();
  }

  Future<ResponseDefault> updateDeliveryToClient(String idPerson) async {
    await _firestore
        .collection('users')
        .doc(idPerson)
        .update({'rolId': '3'}); // Client role
    return ResponseDefault(resp: true, msg: 'User updated successfully');
  }
}

final userServices = UserServices();