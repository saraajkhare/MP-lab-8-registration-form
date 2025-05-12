import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class AuthService {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance

  // Create User and Store Data in Firestore
  Future<User?> createUserWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user data in Firestore
      await _firestore.collection('users').doc(cred.user?.uid).set({
        'name': name,
        'email': email,
        'password':
            password, // Store securely, don't expose plain passwords in production
      });

      return cred.user;
    } catch (e) {
      log("Signup Error: $e");
    }
    return null;
  }

  // Login User
  Future<User?> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } catch (e) {
      log("Login Error: $e");
    }
    return null;
  }

  // Signout User
  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Signout Error: $e");
    }
  }

  // Fetch all users
  Future<List<DocumentSnapshot>> fetchUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs;
    } catch (e) {
      log("Fetch Users Error: $e");
      return [];
    }
  }

  // Delete User from Firestore
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      log("Delete User Error: $e");
    }
  }
}
