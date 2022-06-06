// ignore_for_file: constant_identifier_names, camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diabetes_assistant/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserPreferences extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  UserModel? _user;
  UserModel? get user => _user;

  void getUserData(User authUser) {
    _firestore.collection('users').doc(authUser.uid).get().then((snapshot) {
      _user = UserModel.fromMap(snapshot.data());
      notifyListeners();
    });
  }

  updateUser(Map<String, Object> changes) {
    User? _authUser = _auth.currentUser;
    if (_authUser != null) {
      _firestore
          .collection('users')
          .doc(_authUser.uid)
          .update(changes)
          .then((value) => getUserData(_authUser));
    }
  }
}
