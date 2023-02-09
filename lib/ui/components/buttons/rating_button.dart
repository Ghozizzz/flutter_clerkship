import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class RatingController extends ValueNotifier {
  int? rating;
  RatingController({int? rating}) : super(rating);

  void setRating(int rating) {
    this.rating = rating;
    notifyListeners();
  }
}

class RatingButton extends StatelessWidget {
  final RatingController controller;
  final String title;

  const RatingButton({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Themes().blackBold12,
        ).addMarginBottom(8),
        ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, _, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                10,
                (index) {
                  final selected = (index + 1) == controller.rating;

                  return SizedBox(
                    width: 28.w,
                    height: 28.w,
                    child: RippleButton(
                      onTap: () {
                        controller.setRating(index + 1);
                      },
                      border: Border.all(
                        color: selected ? Themes.primary : Themes.stroke,
                      ),
                      borderRadius: BorderRadius.circular(15.w),
                      padding: EdgeInsets.zero,
                      text: '${index + 1}',
                      textColor: selected ? Themes.primary : Themes.grey,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
