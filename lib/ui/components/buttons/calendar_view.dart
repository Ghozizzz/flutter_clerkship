import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive/responsive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../commons/flat_card.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime selectedDate = DateTime.now();
  DateTime pageDate = DateTime.now();

  bool isDateInclude(DateTime date, List<DateTime> events) {
    for (DateTime event in events) {
      if (event.day == date.day &&
          event.month == date.month &&
          event.year == date.year) {
        return true;
      }
    }

    return false;
  }

  bool isSameDate(DateTime firstDate, DateTime lastDate) {
    return firstDate.day == lastDate.day &&
        firstDate.month == lastDate.month &&
        firstDate.year == lastDate.year;
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
          child: TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 356 * 150)),
            lastDay: DateTime.now().add(const Duration(days: 356 * 150)),
            selectedDayPredicate: (day) => isSameDate(selectedDate, day),
            focusedDay: pageDate,
            onDaySelected: (selectedDay, focusedDay) {
              setSelectedDate(selectedDay);
              setPageDate(selectedDay);
            },
            onPageChanged: (focusedDay) => setPageDate(focusedDay),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              leftChevronVisible: false,
              rightChevronVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RippleButton(
                          padding: const EdgeInsets.all(10),
                          onTap: () {
                            setSelectedDate(DateTime(
                              selectedDate.year,
                              selectedDate.month - 1,
                              1,
                            ));
                            setPageDate(DateTime(
                              selectedDate.year,
                              selectedDate.month - 1,
                              1,
                            ));
                          },
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            color: Themes.hint,
                            size: 32,
                          ),
                        ),
                        Text(
                          day.formatDate('MMMM yyyy'),
                          style: Themes().primaryBold14,
                        ).addAllPadding(12.w),
                        RippleButton(
                          padding: const EdgeInsets.all(10),
                          onTap: () {
                            setSelectedDate(DateTime(
                              selectedDate.year,
                              selectedDate.month + 1,
                              1,
                            ));
                            setPageDate(DateTime(
                              selectedDate.year,
                              selectedDate.month + 1,
                              1,
                            ));
                          },
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            color: Themes.hint,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    const FlatCard(
                      width: double.infinity,
                      height: 1,
                      color: Themes.stroke,
                    ).addMarginBottom(20),
                  ],
                );
              },
              todayBuilder: (context, day, focusedDay) {
                final text = DateFormat.d().format(day);

                return Center(
                  child: Text(
                    text,
                    style: Themes().black12,
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                final text = DateFormat.d().format(day);

                return Center(
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: Themes.darkPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: Themes().white14,
                    ),
                  ),
                );
              },
              defaultBuilder: (context, day, focusedDay) {
                final text = DateFormat.d().format(day);
                final isSunday = DateFormat.E().format(day) == 'Sun';

                return Center(
                  child: Text(
                    text,
                    style: Themes().black14?.withColor(
                          isSunday ? Themes.hint : Themes.text,
                        ),
                  ),
                );
              },
              dowBuilder: (context, day) {
                final text = day.formatDate('E');

                if (day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(
                      text.substring(0, 1),
                      style: Themes().blackBold14?.withColor(Themes.hint),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      text.substring(0, 1),
                      style: Themes().blackBold14,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Container(
          color: Themes.white,
          padding: EdgeInsets.all(20.w),
          child: PrimaryButton(
            onTap: () {
              Navigator.pop(context, selectedDate);
            },
            text: 'Pilih',
          ),
        ),
      ],
    );
  }

  void setPageDate(DateTime date) {
    pageDate = date;
    setState(() {});
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    setState(() {});
  }
}
