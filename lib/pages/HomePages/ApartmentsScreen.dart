import 'dart:ffi';

import 'package:animate_icons/animate_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:rc_kolesa/pages/HomePages/ProfileScreen.dart';
import 'package:rc_kolesa/utilities/Database_Manager.dart';
import 'package:rc_kolesa/widgets/ApartmentWidget.dart';

class ApartmentScreen extends StatefulWidget {
  const ApartmentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

AnimateIconController _controller = AnimateIconController();

class _ApartmentScreenState extends State<ApartmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      //appBar: appbar_builder(),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 50.w,
              title: Padding(
                padding: EdgeInsets.only(
                  left: 14,
                  top: 16,
                ),
                child: Text("Apartments",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold)),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 16.h,
                  ),
                  child: Icon(Icons.search_rounded, color: Colors.black, size: 34,),
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ];
        },
        body: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              ApartmentList_builder(user!.email.toString()),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
   }

  Widget ApartmentList_builder(String email) {
    return SizedBox(
      height: 400.w,
      child: FutureBuilder<List<DocumentSnapshot>>(
          future: DatabaseManager.getUserApartmentList(email),
          builder: (context, snapshot) {
            Widget _child;
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              //var aas = snapshot.data![0]['apartments'];
              _child = PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                      String subtitle = snapshot.data![index]['name'].toString();
                      String title = snapshot.data![index]['location'].toString();
                      String photoUrl = snapshot.data![index]['photoUrl'].toString();

                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ApartmentWidget(
                          title: "$title",
                          subtitle: "$subtitle",
                          photoUrl: "$photoUrl",
                          onTap: () => {}
                        ),
                      );
                  },);
            } else {
              _child = ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Container(
                    width: 3,
                    color: Colors.black,
                  ),
                  Container(
                    width: 3,
                    color: Colors.black,
                  ),
                  Container(
                    width: 3,
                    color: Colors.black,
                  ),
                  Container(
                    width: 3,
                    color: Colors.black,
                  ),
                ],
              );
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _child,
            );
          }),
    );
  }
}
