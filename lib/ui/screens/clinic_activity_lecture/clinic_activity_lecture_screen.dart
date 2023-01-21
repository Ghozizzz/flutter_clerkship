import 'package:clerkship/ui/screens/clinic_activity_lecture/components/filter_header.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../components/commons/primary_appbar.dart';

class ClinicActivityLectureScreen extends StatelessWidget {
  const ClinicActivityLectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(
            title: 'Kembali',
          ).addMarginBottom(12),
          FilterHeader(),
        ],
      ),
    );
  }
}
