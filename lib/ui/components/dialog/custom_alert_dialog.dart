import 'package:clerkship/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';

enum AlertType {
  sucecss,
  error,
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    this.title,
    this.message,
    this.onConfirm,
    this.buttonText = 'OK',
    this.alertType = AlertType.sucecss,
  }) : super(key: key);

  final String? title;
  final String? message;
  final VoidCallback? onConfirm;
  final String buttonText;
  final AlertType alertType;

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
          padding: EdgeInsets.all(32.w),
          width: 74.wp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (alertType == AlertType.sucecss)
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: Themes.primary,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AssetIcons.icCheck,
                    width: 24.w,
                    height: 24.w,
                    color: Themes.white,
                  ),
                ),
              if (title != null)
                Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: Themes().blackBold20,
                ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  message ?? '',
                  style: Themes(withLineHeight: true).black14,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
