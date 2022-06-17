import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// Create a CollectionReference called users that references the firestore collection
// CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser(
    String uid, Map<String, String> userDetails, CollectionReference users) {
  // Call the user's CollectionReference to add a new user
  return users.doc(uid).set(userDetails);
}

// Update values
Future<void> updateUser(String uid, Map<String, Object?> updatedDetails,
    CollectionReference users) {
  return users.doc(uid).update(updatedDetails);
}

// Delete document (user)
Future<void> deleteUser(String uid, CollectionReference users) {
  return users.doc(uid).delete();
}

// Delete a specific field of the user
Future<void> deleteField(String uid, String field, CollectionReference users) {
  return users.doc(uid).update({field: FieldValue.delete()});
}
