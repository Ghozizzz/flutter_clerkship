import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:clerkship/data/shared_providers/survey_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';
import 'package:provider/provider.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../final_assessment/components/item_assessment.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyList = context.watch<SurveyProvider>().surveyList;
    final isLoading =
        context.watch<SurveyProvider>().isloadingSurveyList;

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryAppBar(
              title: 'Kembali',
              action: RippleButton(
                onTap: () {},
                padding: EdgeInsets.all(4.w),
                child: SvgPicture.asset(
                  AssetIcons.icSearch,
                  width: 18.w,
                  height: 18.w,
                ),
              ),
            ),
            Text(
              'Survey',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              top: 20.w,
              right: 20.w,
              left: 20.w,
            ),
            isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(20.w),
                  itemCount: surveyList.length,
                  itemBuilder: (context, k) {
                    return AnimatedItem(
                      index: k,
                      child: ItemAssessment(
                        id: surveyList[k].id!,
                        namaDepartment: surveyList[k].namaDepartment!,
                        tanggal: DateFormat('dd MMMM yyyy').format(surveyList[k].startDate!)+' - '+DateFormat('dd MMMM yyyy').format(surveyList[k].endDate!),
                        flagSurvey: surveyList[k].flagSurvey!
                      ),
                    );
                  },
                ).addExpanded
          ],
        ),
      ),
    );
  }
}
