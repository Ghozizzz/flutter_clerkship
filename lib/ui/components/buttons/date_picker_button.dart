import 'package:clerkship/config/themes.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/calendar_view.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';

class DatePickerController extends ValueNotifier<DateTime?> {
  DateTime? selected;
  DatePickerController({DateTime? selected}) : super(selected);

  void setValue(DateTime value) {
    selected = value;
    notifyListeners();
  }
}

class DatePickerButton extends StatelessWidget {
  final DatePickerController controller;

  const DatePickerButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () {
        showDatePickerModal(context);
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
                    ? controller.selected!.formatDate('dd MMMM yyyy')
                    : 'Pilih Tanggal',
                style: Themes().black14?.withColor(
                      controller.selected != null ? Themes.text : Themes.hint,
                    ),
              );
            },
          ),
          SvgPicture.asset(
            AssetIcons.icCalendar,
          ),
        ],
      ),
    );
  }

  void showDatePickerModal(BuildContext context) async {
    final date = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Themes.transparent,
      builder: (context) {
        return const CalendarView();
      },
    );
    if (date != null) controller.setValue(date);
  }
}
