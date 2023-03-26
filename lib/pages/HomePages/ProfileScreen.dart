import 'package:animate_icons/animate_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:rc_kolesa/pages/Detail_Pages/MyRequestsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

AnimateIconController _controller = AnimateIconController();
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
Map<String, ProfileInfoItem> profileInfoItems = {};

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ProfileInfoRowState> _key = GlobalKey<ProfileInfoRowState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appbar_builder(),
      body: SafeArea(
        child: AnimationLimiter(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(0.1),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 40),
                      const _TopPortion(),
                      const SizedBox(height: 15),
                      Center(
                        child: AutoSizeText(
                          "${user!.displayName}",
                          stepGranularity: 1.sp,
                          minFontSize: 22.sp,
                          style: primaryTextStyle(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: AutoSizeText(
                          "${user!.email}",
                          stepGranularity: 1.sp,
                          minFontSize: 18.sp,
                          style: secondaryTextStyle(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(width: 30, child: ProfileInfoRow(key: _key)),
                      const SizedBox(height: 20),
                      profileButtonsBuilder(),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column profileButtonsBuilder() {
    return Column(
      children: [
        FloatingActionButton.extended(
          heroTag: "123",
          onPressed: () => copyEmail(),
          backgroundColor: Color(0xff5a43f3),
          label: AutoSizeText(
            "Copy email",
            stepGranularity: 1.sp,
            minFontSize: 16.sp,
          ),
          icon: const Icon(Icons.local_post_office_rounded),
        ),
        const SizedBox(
          height: 16,
        ),
        FloatingActionButton.extended(
          heroTag: "1234",
          onPressed: () => Get.to(() => MyRequestsScreen(), transition: Transition.downToUp),
          backgroundColor: Color(0xff5a43f3),
          label: AutoSizeText(
            "My requests",
            stepGranularity: 1.sp,
            minFontSize: 16.sp,
          ),
          icon: const Icon(Icons.local_post_office_rounded),
        ),
      ],
    );
  }

  void copyEmail() {
    Clipboard.setData(ClipboardData(text: user!.email.toString()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Copied to the Clipboard!"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));
  }

  void copyProfilePhotoUrl() {
    Clipboard.setData(ClipboardData(
        text: user!.photoURL!.replaceAll("s96-c", "s360-c").toString()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Copied to the Clipboard!"),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      duration: Duration(milliseconds: 500),
    ));
  }

  AppBar appbar_builder() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 50.w,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14,
          top: 16,
        ),
        child: Text("Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatefulWidget {
  const ProfileInfoRow({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileInfoRow> createState() => ProfileInfoRowState();
}

class ProfileInfoRowState extends State<ProfileInfoRow> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children_ = [];
    for (var i in profileInfoItems.values) {
      children_.add(itemWidget(context, i));
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: children_);
  }

  Widget itemWidget(BuildContext context, ProfileInfoItem item) => Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: item.value,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: AutoSizeText(
                      snapshot.data.toString(),
                      stepGranularity: 1.sp,
                      minFontSize: 22.sp,
                      style: primaryTextStyle(),
                    ),
                  );
                }
                return profileInfoShimmer();
              }),
        ),
        Center(
          child: AutoSizeText(
            item.title,
            stepGranularity: 1.sp,
            minFontSize: 16.sp,
            style: secondaryTextStyle(),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}

class ProfileInfoItem {
  final String title;
  final Future<String> value;

  ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(user!.photoURL!
                          .replaceAll("s96-c", "s360-c")
                          .toString())),
                ),
              ),
              CachedNetworkImage(
                imageUrl:
                user!.photoURL!.replaceAll("s96-c", "s360-c").toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                ),
              )
            ],
          ),
        ),
        //   )
        // ],
      );
  }
}

void showScaffoldMessage(var context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    duration: const Duration(milliseconds: 2500),
  ));
}

Material profileInfoShimmer() {
  return Material(
    color: Colors.transparent,
    child: SizedBox(
      height: 28.w,
      width: 80.w,
      child: Container(
        child: const SpinKitThreeBounce(
          color: Colors.black,
          size: 25.0,
        ),
      ),
    ),
  );
}

TextStyle primaryTextStyle() {
  return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold
  );
}

TextStyle secondaryTextStyle() {
  return const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w300,
  );
}
