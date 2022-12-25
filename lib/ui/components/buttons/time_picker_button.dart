import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../commons/time_picker_view.dart';
import 'ripple_button.dart';

class TimePickerController extends ValueNotifier<TimeOfDay?> {
  TimeOfDay? selected;
  TimePickerController({TimeOfDay? selected}) : super(selected);

  void setValue(TimeOfDay value) {
    selected = value;
    notifyListeners();
  }
}

class TimePickerButton extends StatelessWidget {
  final TimePickerController controller;

  const TimePickerButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () async {
        showTimePickerModal(context);
      },
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16,
      ),
      border: Border.all(color: Themes.stroke),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, _, __) {
              return Text(
                controller.selected != null
                    ? controller.selected!.format(context)
                    : 'Pilih Jam',
                style: Themes().black14?.withColor(
                      controller.selected != null ? Themes.text : Themes.hint,
                    ),
              );
            },
          ),
          SvgPicture.asset(
            AssetIcons.icTime,
          ),
        ],
      ),
    );
  }

  void showTimePickerModal(BuildContext context) async {
    final time = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Themes.transparent,
      builder: (context) {
        return TimePickerView(
          selectedTime: controller.selected,
        );
      },
    );
    if (time != null) controller.setValue(time);
  }
}
