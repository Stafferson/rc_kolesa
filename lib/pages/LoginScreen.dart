import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rc_kolesa/pages/HomeScreen.dart';
import 'package:rc_kolesa/utilities/User.dart';

import '../main.dart';
import '../utilities/Database_Manager.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomeScreen();
    }
    else {
      return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: appbar_builder(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  DatabaseManager dat = DatabaseManager();
                  try {
                    UserCredential? credential = await signInWithGoogle();
                    if (credential == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text(
                            "Error. Try again later",
                            style: TextStyle(color: Colors.black)),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        elevation: 10,
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ));
                      GoogleSignIn().signOut();
                      return;
                    }
                    User? us = credential.user;
                    if (us == null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content:
                        Text(
                            "Error. Clear cache and try again",
                            style: TextStyle(color: Colors.black)),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        elevation: 10,
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ));
                      GoogleSignIn().signOut();
                      return;
                    }
                    User_RC user = User_RC();
                    user.setEmail(us.email);
                    user.setName(us.displayName);
                    user.setPhotoURL(us.photoURL);
                    user.setUID(us.uid);
                    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa");
                    print("UID: " + user.getUID().toString());
                    print("Name: " + user.getName().toString());
                    print("Email: " + user.getEmail().toString());
                    print("PhotoURL: " + user.getPhotoURL().toString());
                    print("FCM Token: " + user.getFcmToken().toString());
                    await prefs?.setString('user_uid', user.getUID().toString());
                    await prefs?.setString('user_name', user.getName().toString());
                    await prefs?.setString('user_email', user.getEmail().toString());
                    await prefs?.setString('user_photo_url', user.getPhotoURL().toString());
                    await prefs?.setString('user_fcm_tolem', user.getFcmToken().toString());

                    final fcmT = await FirebaseMessaging.instance.getToken();
                    user.setFcmToken(fcmT);
                    dat.addUser(user);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(
                      content: Text(
                          "Success",
                          style: TextStyle(color: Colors.black)),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                      elevation: 10,
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ));
                    Get.to(() => HomeScreen());
                  } catch (e) {
                    e.printError();
                    GoogleSignIn().signOut();
                  }
                },
                child: Text('Login with Google'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff5a43f3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                )
              ),
            ],
          ),
        ),
      );
    }
  }

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 50.w,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          top: 16,
        ),
        child: Text("PropMate",
            style: TextStyle(
                color: Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      GoogleSignIn().signOut();
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    googleUser.clearAuthCache();
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void register() async {
    DatabaseManager dat = DatabaseManager();
    UserCredential? credential = await signInWithGoogle();
    if (credential == null) return;
    User? us = credential.user;
    if (us == null) return;
    User_RC user = User_RC();
    user.setEmail(us.email);
    user.setName(us.displayName);
    user.setPhotoURL(us.photoURL);
    final fcmT = await FirebaseMessaging.instance.getToken();
    user.setFcmToken(fcmT);
    dat.addUser(user);
    Get.to(() => HomeScreen());
  }

  void go_main() {
    //Get.to(()=> DiscoverPage());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.to(() => HomeScreen());
    });
  }
}
