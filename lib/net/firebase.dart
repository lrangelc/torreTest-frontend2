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

Future<void> updateUser(String displayName, String mobile) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();

  DocumentReference users =
      FirebaseFirestore.instance.collection('users').doc(uid);
  users.update({
    'displayName': displayName,
    'mobile': mobile,
  });
  return;
}

Future<void> applyJob(String jobID, String objective, String type) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();

  DocumentReference appliedJobs =
      FirebaseFirestore.instance.collection('appliedJobs').doc();
  appliedJobs.set({
    'userID': uid,
    'jobID': jobID,
    'objective': objective,
    'type': type,
    'createdBy': uid,
    'createdAt': FieldValue.serverTimestamp(),
    'status': 'ACTIVE'
  });
  return;
}

// applyJob(userID: string, jobID: string, jobData: any): Promise<any> {
//     try {
//       const data = {
//         ...jobData,
//         userID,
//         jobID,
//         createdBy: userID,
//         createdAt: firebase.firestore.FieldValue.serverTimestamp(),
//         status: 'ACTIVE',
//       };

//       return new Promise<any>((resolve, reject) => {
//         this.angularFirestore
//           .collection('appliedJobs')
//           .add(data)
//           .then(
//             (res) => {},
//             (err) => reject(err)
//           );
//       });
//     } catch (err) {
//       handleHttpResponseError(err);
//     }
//   }
