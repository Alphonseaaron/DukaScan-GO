import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukascan_go/data/env/environment.dart';
import 'package:dukascan_go/data/local_secure/secure_storage.dart';
import 'package:dukascan_go/domain/models/response/response_default.dart';
import 'package:dukascan_go/domain/models/response/user_updated_response.dart';
import 'package:dukascan_go/domain/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> getUserById() async {
    final token = await secureStorage.readToken();
    final response = await http.get(
        Uri.parse('${Environment.endpointApi}/get-user-by-id'),
        headers: {'Accept': 'application/json', 'xx-token': token!});
    return UserUpdatedResponse.fromJson(jsonDecode(response.body)).user;
  }

  Future<ResponseDefault> updatePictureProfile(String image) async {
    final token = await secureStorage.readToken();
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${Environment.endpointApi}/update-picture-profile'))
      ..headers['Accept'] = 'application/json'
      ..headers['xx-token'] = token!;
    request.files.add(await http.MultipartFile.fromPath('image', image));
    final response = await request.send();
    var data = await http.Response.fromStream(response);
    return ResponseDefault.fromJson(jsonDecode(data.body));
  }

  Future<ResponseDefault> updateInformationUser(
      String name, String last, String phone) async {
    final token = await secureStorage.readToken();
    final response = await http.put(
        Uri.parse('${Environment.endpointApi}/update-information-user'),
        headers: {'Accept': 'application/json', 'xx-token': token!},
        body: {'firstname': name, 'lastname': last, 'phone': phone});
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<ResponseDefault> changePassword(
      String currentPassword, String newPassword) async {
    final token = await secureStorage.readToken();
    final response = await http.put(
        Uri.parse('${Environment.endpointApi}/change-password'),
        headers: {'Accept': 'application/json', 'xx-token': token!},
        body: {
          'currentPassword': currentPassword,
          'newPassword': newPassword
        });
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<List<User>> getAllUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
  }
}

final userServices = UserService();