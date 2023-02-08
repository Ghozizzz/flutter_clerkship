import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../../../utils/extensions.dart';
import '../commons/calendar_view.dart';
import 'ripple_button.dart';

class DatePickerController extends ValueNotifier<DateTime?> {
  DateTime? selected;
  DatePickerController({DateTime? selected}) : super(selected);

  void resetValue() {
    selected = null;
    notifyListeners();
  }

  void setValue(DateTime value) {
    selected = value;
    notifyListeners();
  }
}

class DatePickerButton extends StatelessWidget {
  final DatePickerController controller;
  final String? hint;
  final String? dateFormat;
  final Widget? icon;
  final TextStyle? textStyle;
  final Function(DateTime date)? onDatePicked;
  final VoidCallback? onRemoved;
  final bool withReset;

  const DatePickerButton({
    super.key,
    required this.controller,
    this.dateFormat,
    this.hint,
    this.icon,
    this.textStyle,
    this.onDatePicked,
    this.onRemoved,
    this.withReset = false,
  });

  Widget rightIcon(BuildContext context) {
    if (!withReset || controller.selected == null) {
      return icon ??
          SvgPicture.asset(
            AssetIcons.icCalendar,
          );
    } else if (withReset && controller.selected != null) {
      return RippleButton(
        onTap: () {
          controller.resetValue();
          onRemoved?.call();
        },
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(
          AssetIcons.icClose,
        ),
      );
    }

    return Container();
  }

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
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, _, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                controller.selected != null
                    ? controller.selected!
                        .formatDate(dateFormat ?? 'dd MMMM yyyy')
                    : (hint ?? 'Pilih Tanggal'),
                style: (textStyle ?? Themes().black14)?.withColor(
                  controller.selected != null ? Themes.text : Themes.hint,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).addFlexible,
              rightIcon(context),
            ],
          );
        },
      ),
    );
  }

  void showDatePickerModal(BuildContext context) async {
    final date = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Themes.transparent,
      builder: (context) {
        return CalendarView(
          selectedDate: controller.selected,
        );
      },
    );
    if (date != null) {
      controller.setValue(date);
      onDatePicked?.call(date);
    }
  }
}
