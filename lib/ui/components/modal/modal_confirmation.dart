import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/tertiary_button.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

enum ConfirmationType {
  horizontalButton,
  verticalButton,
  withField,
}

class ModalConfirmation extends StatelessWidget {
  final String title;
  final String message;
  final String positiveText;
  final String negativeText;
  final String? labelField;
  final String? hintField;
  final bool optionalField;
  final VoidCallback? onPositiveTap;
  final Function(String fieldValue)? onPositiveTapWithField;
  final VoidCallback? onNegativeTap;
  final ConfirmationType type;

  final fieldController = TextEditingController();

  ModalConfirmation({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.labelField,
    this.hintField,
    this.optionalField = true,
    this.positiveText = 'Ok',
    this.negativeText = 'Batal',
    this.onPositiveTap,
    this.onNegativeTap,
    this.onPositiveTapWithField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
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
                  if (type == ConfirmationType.withField)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              labelField ?? '',
                              style: Themes().blackBold12,
                            ),
                            Text(
                              optionalField ? ' (opsional)' : ' (wajib isi)',
                              style: Themes()
                                  .black12
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ).addMarginBottom(8),
                        TextArea(
                          controller: fieldController,
                          hint: hintField,
                        ),
                      ],
                    ).addMarginTop(32),
                  if (type == ConfirmationType.verticalButton)
                    Column(
                      children: [
                        PrimaryButton(
                          onTap: () {
                            onPositiveButton(context);
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
                  else if (type == ConfirmationType.horizontalButton ||
                      type == ConfirmationType.withField)
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
                        ValueListenableBuilder(
                          valueListenable: fieldController,
                          builder: (context, value, _) {
                            return PrimaryButton(
                              enable: optionalField
                                  ? true
                                  : fieldController.text.isNotEmpty,
                              onTap: () {
                                onPositiveButton(context);
                              },
                              text: positiveText,
                            ).addExpanded;
                          },
                        ),
                      ],
                    ).addMarginTop(32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPositiveButton(BuildContext context) {
    if (onPositiveTap != null || onPositiveTapWithField != null) {
      if (type == ConfirmationType.withField) {
        onPositiveTapWithField?.call(fieldController.text);
      } else {
        onPositiveTap?.call();
      }
    } else {
      Navigator.pop(context);
    }
  }
}
