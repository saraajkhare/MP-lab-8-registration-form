import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  // Fetch all users as a list of maps with their document ID
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final snapshot = await _usersCollection.get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['uid'] = doc.id; // Add UID for reference (useful for deletion)
      return data;
    }).toList();
  }

  // Delete user by UID
  Future<void> deleteUser(String uid) async {
    await _usersCollection.doc(uid).delete();
  }
}
