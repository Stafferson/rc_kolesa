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
import 'package:rc_kolesa/pages/HomePages/ProfileScreen.dart';
import 'package:rc_kolesa/pages/HomeScreen.dart';
import 'package:rc_kolesa/pages/LoginScreen.dart';
import 'package:rc_kolesa/utilities/Database_Manager.dart';
import 'package:rc_kolesa/widgets/ApartmentWidget.dart';

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
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 20,
            ),
            ApartmentList_builder(user!.email.toString()),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
   }

  Widget ApartmentList_builder(String email) {
    return SizedBox(
      height: 330.w,
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
                      String subtitle = snapshot.data![index]['location'].toString();
                      String title = snapshot.data![index]['name'].toString();
                      String photoUrl = snapshot.data![index]['photoUrl'].toString();

                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ApartmentWidget(
                          title: "$title",
                          subtitle: "$subtitle",
                          photo: CachedNetworkImage(
                            imageUrl: photoUrl,
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
                              color: Colors.white,
                              size: 50.0,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          onTap: () => ApartmentOnTap(),
                      ),
                      );
                  },);
            } else {
              /*_child = PageView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                  padding: const EdgeInsets.all(14.0),
                    child: ApartmentShimmerWidget(
                    onTap: () => {}
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: ApartmentShimmerWidget(
                        onTap: () => {}
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: ApartmentShimmerWidget(
                        onTap: () => {}
                    ),
                  ),
                ],
              );*/
              _child = Center(
                  child: Container(
                    child: SpinKitDoubleBounce(
                      color: Color(0xff260ecc),
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
    );
  }

  void ApartmentOnTap() {
    print("TAPPED");
    Get.to(() => HomeScreen());
  }

  void AddApartmentOnTap() {
    print("TAPPED");
    Get.to(() => AddApartmentScreen(),
        transition: Transition.downToUp);
  }

  Widget ApartmentMenu_builder () {
    return Container();
  }

  AppBar appbar_builder() {
    return AppBar(
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
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
