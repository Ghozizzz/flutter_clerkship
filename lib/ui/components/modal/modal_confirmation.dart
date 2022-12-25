import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/tertiary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

enum ConfirmationType {
  horizontalButton,
  verticalButton,
}

class ModalConfirmation extends StatelessWidget {
  final String title;
  final String message;
  final String positiveText;
  final String negativeText;
  final VoidCallback? onPositiveTap;
  final VoidCallback? onNegativeTap;
  final ConfirmationType type;

  const ModalConfirmation({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.positiveText = 'Ok',
    this.negativeText = 'Batal',
    this.onPositiveTap,
    this.onNegativeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(color: Themes.transparent).onTap(() {
          Navigator.pop(context);
        }).addExpanded,
        Container(
          width: double.infinity,
          color: Themes.white,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                if (type == ConfirmationType.verticalButton)
                  SvgPicture.asset(
                    AssetIcons.icAlert,
                    width: 40.w,
                  ).addMarginBottom(20),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Themes().blackBold14?.withColor(Themes.content),
                ).addMarginBottom(
                  type == ConfirmationType.verticalButton ? 20 : 32,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Themes(withLineHeight: true).black14,
                ),
                if (type == ConfirmationType.verticalButton)
                  Column(
                    children: [
                      PrimaryButton(
                        onTap: onPositiveTap ??
                            () {
                              Navigator.pop(context);
                            },
                        text: positiveText,
                      ).addMarginOnly(
                        top: 20,
                        bottom: 12,
                      ),
                      TertiaryButton(
                        onTap: onNegativeTap ??
                            () {
                              Navigator.pop(context);
                            },
                        text: negativeText,
                      ),
                    ],
                  )
                else if (type == ConfirmationType.horizontalButton)
                  Row(
                    children: [
                      TertiaryButton(
                        onTap: onNegativeTap ??
                            () {
                              Navigator.pop(context);
                            },
                        text: negativeText,
                      ).addExpanded,
                      Container(width: 12),
                      PrimaryButton(
                        onTap: onPositiveTap ??
                            () {
                              Navigator.pop(context);
                            },
                        text: positiveText,
                      ).addExpanded,
                    ],
                  ).addMarginTop(32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
