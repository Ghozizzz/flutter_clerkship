import 'dart:convert';

import 'package:clerkship/ui/components/buttons/survey_score_button.dart';
import 'package:clerkship/ui/components/dialog/custom_alert_dialog.dart';
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
import '../../../utils/dialog_helper.dart';
import '../../../utils/tools.dart';
import '../../components/buttons/dropdown_field.dart';
import '../../components/buttons/multi_dropdown_field.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/rating_button.dart';
import '../../components/buttons/tertiary_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/textareas/rich_text_editor.dart';
import '../../components/textareas/textarea.dart';
import '../clinic_activity/providers/item_list_draft_provider.dart';
import '../scientific_event/providers/item_list_draft_provider.dart';
import '../survey/providers/survey_approval_provider.dart';

class SurveyApprovalScreen extends StatefulWidget {
  final int id;
  final int flow;

  const SurveyApprovalScreen({
    super.key,
    required this.id,
    required this.flow,
  });

  @override
  State<SurveyApprovalScreen> createState() => _SurveyApprovalScreenState();
}

class _SurveyApprovalScreenState extends State<SurveyApprovalScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context
          .read<SurveyApprovalProvider>()
          .getSurveyFormDetail(widget.id.toString(), '2');
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<SurveyApprovalProvider>().loading;
    final approvalForm = context.watch<SurveyApprovalProvider>().approvalForm;
    final controllers = context.watch<SurveyApprovalProvider>().controllers;
    final header = context.watch<SurveyApprovalProvider>().header;
    bool isFillAll = false;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Survey', showBackButton: false),
          loading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : WillPopScope(
                  onWillPop: () async {
                    bool willLeave = false;
                    // show the confirm dialog
                    await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text(
                                  'Anda yakin ingin keluar ? Data anda tidak akan terkirim',
                                  style: Themes().blackBold14),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(top: 25.0),
                              actions: [
                                Column(
                                  children: [
                                    PrimaryButton(
                                      onTap: () {
                                        willLeave = true;
                                        if (widget.flow == 1) {
                                          context
                                              .read<
                                                  ItemListDraftClinicProvider>()
                                              .getListClinic();
                                        } else {
                                          context
                                              .read<
                                                  ItemListDraftScientificProvider>()
                                              .getListScientific();
                                        }
                                        Navigator.of(context).pop();
                                      },
                                      text: 'Yes',
                                    ).addMarginOnly(
                                      top: 20,
                                      bottom: 12,
                                    ),
                                    TertiaryButton(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      text: 'No',
                                    ),
                                  ],
                                )
                              ],
                            ));
                    return willLeave;
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Survey ${header?.namaDepartment}',
                            style: Themes().primaryBold20,
                          ).addMarginBottom(14),
                          Text(
                            header?.namaDokter ?? '',
                            style: Themes().blackBold14,
                          ),
                          Text(
                            header?.namaBatch ?? '',
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
                            children:
                                List.generate(approvalForm.length, (index) {
                              final form = approvalForm[index];
                              final controller = controllers[index];
                              return formWidget(form, controller);
                            }),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          MultiValueListenableBuilder(
                            valueListenables: List.generate(
                              controllers.length,
                              (index) =>
                                  controllers[index] is FleatherController
                                      ? MultiDropDownController()
                                      : controllers[index],
                            ),
                            builder: (context, _, __) {
                              return PrimaryButton(
                                      enable: isValidForm(),
                                      onTap: () async {
                                        final formData = <SurveyKeyValueData>[];
                                        isFillAll = true;
                                        for (int i = 0;
                                            i < approvalForm.length;
                                            i++) {
                                          String value = '';
                                          final controller = controllers[i];

                                          if (controller
                                              is TextEditingController) {
                                            value = controller.text;
                                          } else if (controller
                                              is DropDownController) {
                                            value = controller.selected?.value;
                                          } else if (controller
                                              is SurveyScoreController) {
                                            value = controller.score.toString();
                                          } else if (controller
                                              is FleatherController) {
                                            value = jsonEncode(
                                                controller.document.toJson());
                                            if (controller.document.length <
                                                5) {
                                              isFillAll = false;
                                            }
                                          }

                                          if (value == 'null') {
                                            isFillAll = false;
                                          }

                                          final keyValueData =
                                              SurveyKeyValueData(
                                            id: '${approvalForm[i].id}',
                                            jenisSurvey:
                                                '${approvalForm[i].jenisSurvey}',
                                            reason: value,
                                          );
                                          formData.add(keyValueData);
                                        }
                                        if (isFillAll == true) {
                                          context
                                              .read<SurveyApprovalProvider>()
                                              .approveSurveyApprovalForm(
                                                context: context,
                                                id: widget.id.toString(),
                                                flow: widget.flow,
                                                formData: formData,
                                                onFinish: () => context
                                                    .read<SurveyProvider>()
                                                    .getSurveyList(),
                                              );
                                        } else {
                                          DialogHelper.showMessageDialog(
                                              title: 'Error',
                                              body:
                                                  'Pertanyaan belum diisi semua',
                                              alertType: AlertType.error);
                                        }
                                      },
                                      text: 'Simpan Penilaian')
                                  .addMarginBottom(26);
                            },
                          ),
                        ],
                      ),
                    ),
                  ).addExpanded,
                ),
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
      case 4:
        return SurveyScoreButton(
          title: '${form.description}',
          readOnly: false,
          nilai: int.parse(form.nilai ?? '0'),
          controller: controller,
        ).addMarginBottom(20);
      case 5:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              form.description ?? '',
              style: Themes().blackBold12,
            ).addMarginBottom(2),
            Text(
              '*Minimum 4 karakter',
              style: Themes().black10,
            ).addMarginBottom(8),
            SizedBox(
              height: 300,
              child:
                  // Text(
                  //   form.nilai ?? '',
                  //   style: Themes().black14,
                  // ).addMarginBottom(8)
                  RichTextEditor(
                readOnly: false,
                controller: (form.nilai != null)
                    ? FleatherController(
                        document: ParchmentDocument.fromJson(
                            jsonDecode(form.nilai ?? '{}')))
                    : FleatherController(),
                hint: '',
              ),
            )
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
        isAllFormValid.add(controller.rating != null);
      } else if (controller is FleatherController) {
        isAllFormValid.add(controller.document.toPlainText().isNotEmpty);
      }
    }

    return !isAllFormValid.contains(false) && isAllFormValid.isNotEmpty;
  }
}
