import 'package:animate_icons/animate_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class ApartmentDetailScreen extends StatefulWidget {
  final String? name;
  final List<dynamic> photoUrl;
  final List<dynamic> contacts_name;
  final List<dynamic> contacts_number;
  final String? aptID;
  final String? description;
  const ApartmentDetailScreen (
      {Key? key,
        required this.name, required this.photoUrl, required this.aptID, required this.description, required this.contacts_name, required this.contacts_number,
      }) : super(key: key);

  @override
  _ApartmentDetailScreenState createState() => _ApartmentDetailScreenState();
}

AnimateIconController _controller = AnimateIconController();

class _ApartmentDetailScreenState extends State<ApartmentDetailScreen> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
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
                    child: Text("Apartment",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 34.sp,
                            fontWeight: FontWeight.bold)),
                  ),
                  backgroundColor: Colors.white,
                ),
              ];
            },
            body: Stack(
              children: [
                NotificationListener<UserScrollNotification>(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          height: 280.w,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: widget.photoUrl.length + 2,
                              itemBuilder: (context, index) {
                                if (index == 0 || index == widget.photoUrl.length + 1) {
                                  return SizedBox(
                                    width: 28.w,
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () =>
                                    {
                                      _imageDialog(context,
                                          widget.photoUrl[index - 1].toString()),
                                    },
                                    child: Container(
                                      height: 280.w,
                                      width: 280.w,
                                      child: CachedNetworkImage(
                                        imageUrl: widget.photoUrl[index - 1].toString(),
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: imageProvider,
                                            ),
                                          ),
                                        ),
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        const SpinKitThreeBounce(
                                          color: Colors.black,
                                          size: 25.0,
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                }
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  width: 20.w,
                                );
                              }
                          ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.only(left: 18.w, right: 18.w),
                        child: Material(
                            color: Colors.transparent,
                            child: Material(
                              color: Colors.transparent,
                              child:  DefaultTextStyle(child: Text(widget.name.toString()),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 16),
                        child: Linkify(
                            text: widget.description.toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp),
                            options: LinkifyOptions(humanize: true),
                        ),
                    ),
                      for(int i = 0; i < widget.contacts_name.length; i++)
                        Padding(
                          padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 16),
                          child: SelectableText.rich(
                            TextSpan(
                              text: widget.contacts_name[i].toString() + ' ',
                              style: TextStyle(fontSize: 18.sp),
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.contacts_number[i].toString(),
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff5a43f3)
                                    )),
                                // can add more TextSpans here...
                              ],
                            ),
                          )
                        ),
                    ],
                  ),
                ),
                send_request()
              ],
            ),
          )
      ),
    );
  }

  void onBackIconTapped() {
    Get.back();
  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }

  Widget send_request() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120.w,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: requestOnTap,
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xff4A80F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  height: 56.h,
                  width: 319.w,
                  child: Center(
                      child: Text(
                        "Send Request",
                        style: TextStyle(
                            fontSize: 16.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void requestOnTap() {
  }

  void _imageDialog(context, url) async {
    await showDialog(
      context: context,
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.9,
          child: Hero(
            tag: "${widget.name}image",
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.contain,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
