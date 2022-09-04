import 'dart:async';

import 'package:booking_services/core/errors/exceptions.dart';
import 'package:booking_services/features/authentication/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<UserModel> createUseWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String phoneNum});

  Future<void> addNewUser({required UserModel userModel});

  Future<UserModel> getUser({required String email});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final token = await credential.user?.getIdToken();
      return UserModel.fromUserCredential(credential, token ?? '');
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    }
  }

  @override
  Future<void> addNewUser({required UserModel userModel}) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .add(userModel.toJson());
  }

  @override
  Future<UserModel> getUser({required String email}) async {
    var query = await FirebaseFirestore.instance
        .collection("Users")
        .where("Email", isEqualTo: email)
        .get();
    return UserModel.fromUserJson(query.docs.first.data());
  }

  @override
  Future<UserModel> createUseWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String phoneNum}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final token = await credential.user?.getIdToken();
      await addNewUser(
          userModel: UserModel(
              name: username,
              email: email,
              phoneNum: phoneNum,
              imageUrl: '',
              emailVerified: credential.user?.emailVerified ?? false,
              userId: credential.user?.uid ?? '',
              token: token ?? ''));
      return await getUser(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthenticationException(message: e.code);
    }
  }
}
