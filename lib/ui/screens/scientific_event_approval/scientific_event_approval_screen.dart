import 'dart:convert';

import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/score_button.dart';
import 'package:clerkship/ui/screens/scientific_event/providers/scientific_event_lecture_provider.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/dropdown_item.dart';
import '../../../data/models/key_value_data.dart';
import '../../../data/network/entity/mini_cex_form_response.dart';
import '../../../data/shared_providers/user_provider.dart';
import '../../../utils/tools.dart';
import '../../components/buttons/dropdown_field.dart';
import '../../components/buttons/multi_dropdown_field.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/textareas/rich_text_editor.dart';
import '../../components/textareas/textarea.dart';
import 'provider/scientific_event_approval_provider.dart';

class ScientificEventApprovalScreen extends StatefulWidget {
  final String id;

  const ScientificEventApprovalScreen({
    super.key,
    required this.id,
  });

  @override
  State<ScientificEventApprovalScreen> createState() =>
      _ScientificEventApprovalScreenState();
}

class _ScientificEventApprovalScreenState
    extends State<ScientificEventApprovalScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context
          .read<ScientificEventApprovalProvider>()
          .getScientificEventFrom(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final loading = context.watch<ScientificEventApprovalProvider>().loading;
    final approvalForm =
        context.watch<ScientificEventApprovalProvider>().approvalForm;
    final header =
        context.watch<ScientificEventApprovalProvider>().header;
    final controllers =
        context.watch<ScientificEventApprovalProvider>().controllers;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PrimaryAppBar(title: 'Kembali'),
          loading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tinjauan ${header?.namaKegiatan}',
                        style: Themes().blackBold20,
                      ).addMarginBottom(12),
                      Text(
                        '${user.name}',
                        style: Themes().blackBold14,
                      ),
                      Text(
                        'ID. ${user.nim}',
                        style: Themes().gray10?.boldText(),
                      ).addMarginBottom(20),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Themes.stroke,
                        margin: const EdgeInsets.only(bottom: 12),
                      ),
                      Text(
                        'FORMAT',
                        style: Themes().blackBold12,
                      ).addMarginBottom(12),
                      Column(
                        children: List.generate(approvalForm.length, (index) {
                          final form = approvalForm[index];
                          final controller = controllers[index];
                          return formWidget(form, controller);
                        }),
                      ),
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
                              final formData = <KeyValueData>[];
                              for (int i = 0; i < approvalForm.length; i++) {
                                String value = '';
                                final controller = controllers[i];

                                if (controller is TextEditingController) {
                                  value = controller.text;
                                } else if (controller is DropDownController) {
                                  value = controller.selected?.value;
                                } else if (controller is ScoreController) {
                                  value = controller.score.toString();
                                } else if (controller is FleatherController) {
                                  value =
                                      jsonEncode(controller.document.toJson());
                                }

                                final keyValueData = KeyValueData(
                                  id: '${approvalForm[i].id}',
                                  reason: value,
                                );
                                formData.add(keyValueData);
                              }

                              context
                                  .read<ScientificEventApprovalProvider>()
                                  .approveScientificEvent(
                                    id: widget.id,
                                    formData: formData,
                                    onFinish: () => context
                                        .read<ScientificEventLectureProvider>()
                                        .reloadEvents(),
                                  );
                            },
                            text: 'Simpan Penilaian',
                          ).addMarginBottom(26);
                        },
                      ),
                    ],
                  ),
                ).addExpanded,
        ],
      ),
    );
  }

  Widget formWidget(DetailCexForm form, controller) {
    switch (form.tipeScoring) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${form.keterangan}',
              style: Themes().blackBold12,
            ).addMarginBottom(8),
            TextArea(
              controller: controller,
              hint: '${form.placeholder}',
            ).addMarginBottom(20),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${form.keterangan}',
              style: Themes().blackBold12,
            ).addMarginBottom(8),
            DropdownField(
              withSearchField: false,
              controller: controller,
              hint: '${form.placeholder}',
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
        return ScoreButton(
          title: '${form.keterangan}',
          controller: controller,
        ).addMarginBottom(20);
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${form.keterangan}',
              style: Themes().blackBold12,
            ).addMarginBottom(8),
            SizedBox(
              height: 300,
              child: RichTextEditor(
                controller: controller,
                hint: '${form.placeholder}',
              ),
            ).addMarginBottom(20),
          ],
        );
      default:
        return Container();
    }
  }

  bool isValidForm() {
    final controllers =
        context.read<ScientificEventApprovalProvider>().controllers;

    final isAllFormValid = [];
    for (final controller in controllers) {
      if (controller is TextEditingController) {
        isAllFormValid.add(controller.text.isNotEmpty);
      } else if (controller is DropDownController) {
        isAllFormValid.add(controller.selected != null);
      } else if (controller is ScoreController) {
        debugPrint(controller.score.toString());
        isAllFormValid.add(controller.score != null);
      } else if (controller is FleatherController) {
        isAllFormValid.add(controller.document.toPlainText().isNotEmpty);
      }
    }

    return !isAllFormValid.contains(false) && isAllFormValid.isNotEmpty;
  }
}
