import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../buttons/primary_button.dart';
import 'flat_card.dart';

class TimePickerView extends StatefulWidget {
  final TimeOfDay? selectedTime;

  const TimePickerView({
    super.key,
    this.selectedTime,
  });

  @override
  State<TimePickerView> createState() => _TimePickerViewState();
}

class _TimePickerViewState extends State<TimePickerView> {
  final ValueNotifier<int> hour = ValueNotifier(0);
  final ValueNotifier<int> minutes = ValueNotifier(0);
  final hourScrollController = FixedExtentScrollController();
  final minuteScrollController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      if (widget.selectedTime != null) {
        hour.value = widget.selectedTime!.hour;
        minutes.value = widget.selectedTime!.minute;

        hourScrollController.jumpTo(hour.value * 100);
        minuteScrollController.jumpTo(minutes.value * 100);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Themes.transparent,
        ).onTap(() {
          Navigator.pop(context);
        }).addExpanded,
        FlatCard(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          shadow: Themes.dropShadow,
          width: double.infinity,
          borderRadius: BorderRadius.zero,
          height: 50.hp,
          child: Column(
            children: [
              Text(
                'Pilih Jam',
                style: Themes().blackBold14,
              ).addAllPadding(14.w),
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: hour,
                    builder: (context, _, __) {
                      return ListWheelScrollView(
                        controller: hourScrollController,
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 100,
                        children: List.generate(
                          24,
                          (value) => Text(
                            '$value'.length == 1 ? '0$value' : '$value',
                            style: Themes().black10?.withSize(56).withColor(
                                hour.value == value
                                    ? Themes.primary
                                    : Themes.hint),
                          ).addMarginTop(20),
                        ),
                        onSelectedItemChanged: (value) {
                          hour.value = value;
                        },
                      ).addExpanded;
                    },
                  ),
                  Text(
                    ':',
                    style: Themes().primary12?.withSize(56),
                  ),
                  ValueListenableBuilder(
                    valueListenable: minutes,
                    builder: (context, _, __) {
                      return ListWheelScrollView(
                        controller: minuteScrollController,
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 100,
                        children: List.generate(
                          60,
                          (value) => Text(
                            '$value'.length == 1 ? '0$value' : '$value',
                            style: Themes().black10?.withSize(56).withColor(
                                minutes.value == value
                                    ? Themes.primary
                                    : Themes.hint),
                          ).addMarginTop(20),
                        ),
                        onSelectedItemChanged: (value) {
                          minutes.value = value;
                        },
                      ).addExpanded;
                    },
                  ),
                ],
              ).addExpanded,
            ],
          ),
        ),
        Container(
          color: Themes.white,
          padding: EdgeInsets.all(20.w),
          child: PrimaryButton(
            onTap: () {
              Navigator.pop(
                context,
                TimeOfDay(hour: hour.value, minute: minutes.value),
              );
            },
            text: 'Pilih',
          ),
        ),
      ],
    );
  }
}
