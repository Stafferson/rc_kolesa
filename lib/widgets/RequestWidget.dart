import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';

import '../main.dart';
import '../utilities/icons.dart';
import '../utilities/svg_asset.dart';

class RequestWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? place;
  final String? email;
  final String? docID;
  final bool? isPublic;
  final String? status;
  final DateTime? timeStamp;

  const RequestWidget(
      {Key? key,
        this.title,
        this.subtitle,
        this.place,
        this.email,
        this.docID,
        this.isPublic,
        this.status,
        this.timeStamp,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [
                Color(0xff441DFC),
                Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            height: 200.w,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: SvgAsset(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      assetName: AssetName.vectorBottom),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: SvgAsset(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      assetName: AssetName.vectorTop),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 22, right: 22, top: 22, bottom: 12,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      child: Text(
                                        title!,
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      child: Text(
                                        subtitle!,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.apartment_rounded, color: Colors.white,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
