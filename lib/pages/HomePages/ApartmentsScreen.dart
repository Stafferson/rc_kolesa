import 'dart:ffi';

import 'package:animate_icons/animate_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:rc_kolesa/pages/Detail_Pages/AddApartmentScreen.dart';
import 'package:rc_kolesa/pages/Detail_Pages/ApartmentDetailScreen.dart';
import 'package:rc_kolesa/pages/HomePages/ProfileScreen.dart';
import 'package:rc_kolesa/pages/HomeScreen.dart';
import 'package:rc_kolesa/pages/LoginScreen.dart';
import 'package:rc_kolesa/utilities/Database_Manager.dart';
import 'package:rc_kolesa/widgets/ApartmentWidget.dart';

import '../../widgets/ApartmentInfoWidget.dart';
import '../../widgets/ApartmentShimmerWidget.dart';

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
      appBar: appbar_builder(),
      body: SafeArea(
        child: ApartmentList_builder(user!.email.toString()),
      ),
      backgroundColor: Colors.white,
    );
   }

  Widget ApartmentList_builder(String email) {
    return ListView(
      scrollDirection: Axis.vertical,

      physics: BouncingScrollPhysics(),
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 700.w,
          child: FutureBuilder<List<DocumentSnapshot>>(
              future: DatabaseManager.getUserApartmentList(email),
              builder: (context, snapshot) {
                Widget _child;
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  _child = ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length + 2,
                      itemBuilder: (context, index) {
                        if (index == snapshot.data!.length) {
                          return Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: ApartmentWidget(
                              title: "Add new apartment",
                              subtitle: "Somewhere far away...",
                              onTap: () => AddApartmentOnTap(),
                            ),
                          );
                        }
                        if (index == snapshot.data!.length + 1) {
                          return SizedBox(height: 20);
                        }
                          String subtitle = snapshot.data![index]['location'].toString();
                          String title = snapshot.data![index]['name'].toString();
                          List<dynamic> photoUrl = snapshot.data![index]['photoUrl'].toList();
                          List<dynamic> contacts_name = snapshot.data![index]['contacts_name'].toList();
                          List<dynamic> contacts_number = snapshot.data![index]['contacts_number'].toList();
                          String aptID = snapshot.data![index].id;
                          String desctiption = snapshot.data![index]['description'].toString();

                          return Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: ApartmentWidget(
                              title: "$title",
                              subtitle: "$subtitle",
                              photo: CachedNetworkImage(
                                imageUrl: photoUrl[0],
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                const SpinKitDoubleBounce(
                                  color: Colors.black,
                                  size: 50.0,
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              onTap: () => ApartmentOnTap(title, photoUrl, contacts_name, contacts_number, aptID, desctiption),
                            ),
                          );
                      },
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
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void ApartmentOnTap(String name, List<dynamic> photoUrl, List<dynamic> contacts_name, List<dynamic> contacts_number, String aptID, String description) {
    print("TAPPED");
    Get.to(() => ApartmentDetailScreen(name: name, photoUrl: photoUrl, contacts_name: contacts_name, contacts_number: contacts_number, aptID: aptID, description: description),
    transition: Transition.downToUp);
  }

  void AddApartmentOnTap() {
    print("TAPPED");
    Get.to(() => AddApartmentScreen(),
        transition: Transition.downToUp);
  }

  AppBar appbar_builder() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 50.w,
      title: Padding(
        padding: const EdgeInsets.only(
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
          padding: const EdgeInsets.only(
            top: 16,
            right: 14,
          ),
          child: AnimateIcons(
            startIcon: Icons.refresh_rounded,
            endIcon: Icons.refresh_rounded,
            size: 28.0,
            // add this tooltip for the start icon
            startTooltip: 'Icons.add_circle',
            // add this tooltip for the end icon
            endTooltip: 'Icons.add_circle_outline',
            controller: _controller,
            onStartIconPress: () {
              setState(() {});
              return true;
            },
            onEndIconPress: () {
              setState(() {});
              return true;
            },
            startIconColor: Colors.black,
            endIconColor: Colors.black,
            duration: Duration(milliseconds: 500),
            clockwise: true,
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
