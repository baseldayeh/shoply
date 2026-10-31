import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Stream<String?> get userIds;
  Stream<bool> watchAdmin(String uid);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._db);
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  @override
  Stream<String?> get userIds =>
      _auth.authStateChanges().map((user) => user?.uid);
  @override
  Stream<bool> watchAdmin(String uid) =>
      _db.collection('admins').doc(uid).snapshots().map((doc) => doc.exists);
  @override
  Future<void> signIn(String email, String password) async =>
      _auth.signInWithEmailAndPassword(email: email, password: password);
  @override
  Future<void> signOut() => _auth.signOut();
}
