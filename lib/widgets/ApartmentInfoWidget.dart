import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/icons.dart';
import '../utilities/svg_asset.dart';

class ApartmentInfoWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final double? borderRadius;
  final Widget? icon;
  final Function()? onTap;
  const ApartmentInfoWidget (
      {Key? key,
        this.title,
        this.subtitle,
        this.gradientStartColor,
        this.gradientEndColor,
        this.height,
        this.width,
        this.vectorBottom,
        this.vectorTop,
        this.borderRadius,
        this.icon,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 87.h,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => onTap!(),
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
                      "Read online",
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
    );
  }
}
