import 'package:flutter/material.dart';

import '../../../../config/themes.dart';

class LabelText extends StatelessWidget {
  final bool mandatory;
  final String text;

  const LabelText({
    super.key,
    this.mandatory = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Themes().blackBold12,
        ),
        if (mandatory)
          Text(
            '*',
            style: Themes().blackBold12?.withColor(Themes.red),
          ),
      ],
    );
  }
}
