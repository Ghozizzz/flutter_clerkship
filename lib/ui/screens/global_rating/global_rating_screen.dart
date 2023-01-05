import 'package:clerkship/ui/components/commons/primary_appbar.dart';
import 'package:clerkship/ui/screens/global_rating/components/global_rating_header.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import 'components/item_answer_group.dart';

class GlobalRatingScreen extends StatelessWidget {
  const GlobalRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Kembali'),
          const GlobalRatingHeader(),
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 4,
            itemBuilder: (context, index) {
              return const ItemAnswerGroup().addMarginTop(20);
            },
          ).addExpanded,
        ],
      ),
    );
  }
}
