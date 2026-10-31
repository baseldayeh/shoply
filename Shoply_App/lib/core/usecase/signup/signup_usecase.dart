import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_app/core/model/signup/request_signup.dart';
import 'package:shoply_app/core/service/upload_image_service.dart';

class SignupUsecase {
  Future<Either<String, bool>> signup({
    required String password,
    required RequestSignup requestSignup,
    required File? image,
  }) async {
    try {
      final snapshot = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: requestSignup.email ?? '',
            password: password,
          );
      final imageUrl = await _uploadImage(image: image);
      final saved = await _saveUserDate(
        requestSignup: RequestSignup(
          email: requestSignup.email,
          fullName: requestSignup.fullName,
          userName: requestSignup.userName,
          address: requestSignup.address,
          uid: snapshot.user?.uid,
          profileImage: imageUrl,
        ),
      );
      final saveError = saved.fold<String?>((error) => error, (_) => null);
      if (saveError != null) return Left(saveError);
      await snapshot.user?.sendEmailVerification();
      return Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<String?> _uploadImage({required File? image}) async {
    if (image != null) {
      final imageUrl = await UploadImageService.uplaodImage(imageFile: image);
      return imageUrl;
    } else {
      return null;
    }
  }

  Future<Either<String, bool>> _saveUserDate({
    required RequestSignup requestSignup,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(requestSignup.uid)
          .set(requestSignup.toJson());
      return Right(true);
    } on FirebaseException catch (e) {
      log(e.message ?? '');
      return Left(e.message ?? '');
    }
  }
}
