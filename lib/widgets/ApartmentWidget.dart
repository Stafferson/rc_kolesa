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

class ApartmentWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? photo;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final bool? is_loaded;

  const ApartmentWidget(
      {Key? key,
      this.title,
      this.subtitle,
      this.photo,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.onTap,
      this.is_loaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap!(),
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [
                gradientStartColor ?? Color(0xff441DFC),
                gradientEndColor ?? Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            height: 300.w,
            child: Stack(
              children: [
                vectorBottom ??
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: SvgAsset(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          assetName: AssetName.vectorBottom),
                    ),
                vectorTop ??
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
                        Container(
                          height: 200.w,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: photo ??
                              Padding(
                                padding: EdgeInsets.only(left: 22, right: 22, top: 22),
                                child: SvgAsset(
                                  assetName: AssetName.city,
                                  color: Colors.white,
                                  height: 170.w,
                                  width: 252.w
                                ),
                              ),
                        ),
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
