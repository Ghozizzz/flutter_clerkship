import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);

  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          padding: EdgeInsets.all(20.w),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title ?? '', style: Themes().blackBold18),
              Container(
                margin: EdgeInsets.only(top: 18.h),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 18.w),
                        child: Text(
                          message ?? '',
                          style: Themes(withLineHeight: true).black14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
