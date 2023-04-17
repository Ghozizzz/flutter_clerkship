import 'dart:convert';

import 'package:clerkship/ui/components/buttons/survey_score_button.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/dropdown_item.dart';
import '../../../data/models/survey_value.dart';
import '../../../data/network/entity/survey_form_response.dart';
import '../../../data/shared_providers/survey_provider.dart';
import '../../../utils/tools.dart';
import '../../components/buttons/dropdown_field.dart';
import '../../components/buttons/multi_dropdown_field.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/rating_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/textareas/rich_text_editor.dart';
import '../../components/textareas/textarea.dart';
import './providers/survey_approval_provider.dart';

class SurveyAddScreen extends StatefulWidget {
  final String id;
  final int flagSurvey;

  const SurveyAddScreen({
    super.key,
    required this.id,
    required this.flagSurvey,
  });

  @override
  State<SurveyAddScreen> createState() => _SurveyAddScreenState();
}

class _SurveyAddScreenState extends State<SurveyAddScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context
          .read<SurveyApprovalProvider>()
          .getSurveyFormDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<SurveyApprovalProvider>().loading;
    final approvalForm = context.watch<SurveyApprovalProvider>().approvalForm;
    final controllers = context.watch<SurveyApprovalProvider>().controllers;
    final header = context.watch<SurveyApprovalProvider>().header;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(
            title: 'Kembali',
          ),
            loading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    // width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          header?.namaDepartment ?? '',
                          style: Themes().primaryBold20,
                        ).addMarginBottom(14),
                        Text(
                          header?.namaBatch ?? '',
                          style: Themes().blackBold14,
                        ),
                        Text(
                          header?.startDate ?? '',
                          style: Themes().gray10?.boldText(),
                        ).addMarginBottom(16),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Themes.stroke,
                        ).addMarginBottom(14),
                        Text(
                          'INFORMASI DASAR',
                          style: Themes().blackBold12,
                        ).addMarginBottom(8),
                        Column(
                          children: List.generate(approvalForm.length, (index) {
                            final form = approvalForm[index];
                            final controller = controllers[index];
                            return formWidget(form, controller);
                          }),
                        ),
                        if(widget.flagSurvey != 1)
                          MultiValueListenableBuilder(
                            valueListenables: List.generate(
                              controllers.length,
                              (index) => controllers[index] is FleatherController
                                  ? MultiDropDownController()
                                  : controllers[index],
                            ),
                            builder: (context, _, __) {
                              return PrimaryButton(
                                enable: isValidForm(),
                                onTap: () async {
                                  final formData = <SurveyKeyValueData>[];
                                  for (int i = 0; i < approvalForm.length; i++) {
                                    String value = '';
                                    final controller = controllers[i];

                                    if (controller is TextEditingController) {
                                      value = controller.text;
                                    } else if (controller is DropDownController) {
                                      value = controller.selected?.value;
                                    } else if (controller is SurveyScoreController) {
                                      value = controller.score.toString();
                                    } else if (controller is FleatherController) {
                                      value = jsonEncode(
                                          controller.document.toJson());
                                    }

                                    final keyValueData = SurveyKeyValueData(
                                      id: '${approvalForm[i].id}',
                                      jenisSurvey: '${approvalForm[i].jenisSurvey}',
                                      reason: value,
                                    );
                                    formData.add(keyValueData);
                                  }

                                  context
                                      .read<SurveyApprovalProvider>()
                                      .approveSurveyForm(
                                        id: widget.id,
                                        formData: formData,
                                        onFinish: () => context
                                            .read<SurveyProvider>()
                                            .getSurveyList(),
                                      );
                                },
                                text: 'Simpan Penilaian',
                              ).addMarginBottom(26);
                            },
                          ),
                      ],
                    ),
                  ),
                ).addExpanded,
        ],
      ),
    );
  }

  Widget formWidget(SurveyCexForm form, controller) {
    switch (form.jenisSurvey) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              form.description ?? '',
              style: Themes().blackBold12,
            ).addMarginBottom(8),
            TextArea(
              controller: controller,
              hint: '',
            ).addMarginBottom(20),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              form.description ?? '',
              style: Themes().blackBold12,
            ).addMarginBottom(8),
            DropdownField(
              withSearchField: false,
              controller: controller,
              hint: '',
              items: [
                DropDownItem(
                  title: 'Low',
                  value: 'Low',
                ),
                DropDownItem(
                  title: 'Moderate',
                  value: 'Moderate',
                ),
                DropDownItem(
                  title: 'High',
                  value: 'High',
                ),
              ],
            ).addMarginBottom(20),
        ],
        );
      case 2:
        return SurveyScoreButton(
          title: '${form.description}',
          readOnly: widget.flagSurvey == 1 ? true : false,
          nilai: int.parse(form.nilai ?? '0'),
          controller: controller,
        ).addMarginBottom(20);
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              form.description ?? '',
              style: Themes().blackBold12,
            ).addMarginBottom(8),
            (widget.flagSurvey==1)?
              SizedBox(
                height: 300,
                child: 
                  // Text(
                  //   form.nilai ?? '',
                  //   style: Themes().black14,
                  // ).addMarginBottom(8)
                  RichTextEditor(
                    readOnly: true,
                    controller: (widget.flagSurvey == 1 && form.nilai != null)
                                  ? FleatherController(
                                      ParchmentDocument.fromJson(
                                          jsonDecode(form.nilai ?? '{}')))
                                  : controller,
                    hint: '',
                  ),
              )
              :
              SizedBox(
                height: 300,
                child: RichTextEditor(
                  controller: controller,
                  hint: '',
                ),
              ).addMarginBottom(20)
          ],
        );
      default:
        return Container();
    }
  }

  bool isValidForm() {
    final controllers = context.read<SurveyApprovalProvider>().controllers;

    final isAllFormValid = [];
    for (final controller in controllers) {
      if (controller is TextEditingController) {
        isAllFormValid.add(controller.text.isNotEmpty);
      } else if (controller is DropDownController) {
        isAllFormValid.add(controller.selected != null);
      } else if (controller is RatingController) {
        debugPrint(controller.rating.toString());
        isAllFormValid.add(controller.rating != null);
      } else if (controller is FleatherController) {
        isAllFormValid.add(controller.document.toPlainText().isNotEmpty);
      }
    }

    return !isAllFormValid.contains(false) && isAllFormValid.isNotEmpty;
  }
}
