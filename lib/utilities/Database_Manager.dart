import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'User.dart';

class DatabaseManager {
  CollectionReference? ref;
  FirebaseFirestore? db;

  DatabaseManager() {
    db = FirebaseFirestore.instance;
    ref = db?.collection("users").withConverter<User_RC>(
        fromFirestore: (snapshot, _) => User_RC.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson());
  }

  void addUser(User_RC user) {
    ref?.doc(user.getEmail()).set(user);
  }

  static Future<List<DocumentSnapshot>> getUserApartmentList(String email) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<DocumentSnapshot> ans = [];
    final arr1 = db.collectionGroup("apartments").where("email", isEqualTo: "tairka.mail@gmail.com").get();
    late final arr2;
    await arr1.then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          arr2 = docSnapshot.data()['ids'];
          print('${docSnapshot.id} => ${docSnapshot.data()['ids']}' + '\n');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    print("Apartment List");
    print(arr2);
    for (int i = 0; i < arr2.length; i++) {
      final arr3 = db.collection("Residential Complex").doc("${arr2[i].toString().removeAllWhitespace}").get();
      await arr3.then(
            (DocumentSnapshot doc) {
              print("doc:: ${doc.data()}");
          ans.add(doc);
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
    print("yes");
    return ans;
  }

  static Future<bool> checkApartmentID(String id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<DocumentSnapshot> ans = [];
    final arr1 = db.collection("Residential Complex").doc(id).get();
    return arr1.then(
          (DocumentSnapshot doc) {
            print("SUCK MY DICK");
            print(doc.exists);
            return doc.exists;
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}