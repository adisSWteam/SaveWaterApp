import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser(
    String uid, Map<String, String> userDetails, CollectionReference users) {
  return users.doc(uid).set(userDetails);
}

Future<void> updateUser(String uid, Map<String, Object?> updatedDetails,
    CollectionReference users) {
  return users.doc(uid).update(updatedDetails);
}

Future<void> deleteUser(String uid, CollectionReference users) {
  return users.doc(uid).delete();
}

Future<void> deleteField(String uid, String field, CollectionReference users) {
  return users.doc(uid).update({field: FieldValue.delete()});
}
