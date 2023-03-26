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
    DocumentSnapshot arr1 = await db.collection("Residential Complex").doc(id).get();
    print(arr1.exists);
    return arr1.exists;
  }

  static void addApartmentToUser(String id, String email) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final arr1 = db.collectionGroup('apartments').where('email', isEqualTo: email).get();
    arr1.then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          List<dynamic> arr2 = docSnapshot.data()['ids'];
          arr2.add(id);
          db.collection('users').doc(email).collection('apartments').doc(docSnapshot.id).update({'ids': arr2});
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  static void sendRequest(String aptID, String email, String title, String description, String place, bool isPublic) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('requests').add({
      'aptID': aptID,
      'email': email,
      'title': title,
      'description': description,
      'place': place,
      'isPublic': isPublic,
      'timeStamp': DateTime.now(),
      'status': 'pending',// |[ pending ]| => |[ in review ]| => either |[ in progress => approved ]| or |[ rejected ]|
    });
  }

  static Future<List<DocumentSnapshot>> getMyRequests(String email) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final arr1 = db.collection('requests').where('email', isEqualTo: email).orderBy("timeStamp", descending: true).get();
    List<DocumentSnapshot> arr2 = [];
    await arr1.then(
          (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          arr2.add(docSnapshot);
          print('${docSnapshot.id} => ${docSnapshot.data().toString()}' + '\n');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    //DateTime ar = arr2[0]['timeStamp'].toDate();
    //print(ar.toString());
    //print(arr2[0]['timeStamp'].toString());
    //print(arr2[0].data().toString());
    //print(arr2[0].id);
    //print('nigger');
    return arr2;
  }
}