import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rc_kolesa/pages/HomePages/ProfileScreen.dart';

import '../../utilities/Database_Manager.dart';
import '../../widgets/RequestWidget.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  _MyRequestsScreenState createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              toolbarHeight: 50.w,
              leading: Padding(
                padding: EdgeInsets.only(
                  top: 16,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(
                  left: 14,
                  top: 16,
                ),
                child: Text("My Requests",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold)),
              ),
              backgroundColor: Colors.white,
            ),
          ];
        },
        body: FutureBuilder<List<DocumentSnapshot>>(
            future: DatabaseManager.getMyRequests(user!.email.toString()),
            builder: (context, snapshot) {
              Widget _child;
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                _child = ListView.separated(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 16,
                    right: 16,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return RequestWidget(
                      title: snapshot.data![index].get("title"),
                      subtitle: snapshot.data![index].get("description"),
                      timeStamp: snapshot.data![index].get("timeStamp").toDate(),
                      place: snapshot.data![index].get("place"),
                      status: snapshot.data![index].get("status"),
                      docID: snapshot.data![index].id,
                      isPublic: snapshot.data![index].get("isPublic"),
                      email: snapshot.data![index].get("email"),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 28)
                );
              } else {
                _child = Center(
                  child: Container(
                    child: SpinKitDoubleBounce(
                      color: Colors.black,
                      size: 50.0,
                    ),
                  ),
                );
              }

              return AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: _child,
              );
            }),
      )
    );
  }
}
