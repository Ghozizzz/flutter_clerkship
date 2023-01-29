import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/scientific_event/components/item_event_lecture.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

class EditScientificEventReviewScreen extends StatelessWidget {
  const EditScientificEventReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Kembali'),
          Text(
            'Ubah',
            style: Themes().blackBold20,
          ).addMarginOnly(
            top: 12,
            left: 20.w,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                ItemEventLecture(showCheckbox: false),
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
