import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addUser(String displayName, UserCredential user) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();

  DocumentReference users =
      FirebaseFirestore.instance.collection('users').doc(uid);
  users.set({
    'displayName': displayName,
    'uid': uid,
    'email': auth.currentUser.email
  });
  return;
}

Future<DocumentSnapshot> getUser() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  DocumentSnapshot user =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return user;
}

Future<void> updateUser(String displayName) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();

  DocumentReference users =
      FirebaseFirestore.instance.collection('users').doc(uid);
  users.update({
    'displayName': displayName,
  });
  return;
}
