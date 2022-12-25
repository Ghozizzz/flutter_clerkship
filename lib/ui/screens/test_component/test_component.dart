import 'package:clerkship/ui/components/buttons/dropdown_field.dart';
import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../data/models/dropdown_item.dart';
import '../../components/buttons/date_picker_button.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';
import '../../components/buttons/time_picker_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/primary_checkbox.dart';
import '../../components/textareas/otp_field.dart';
import '../../components/textareas/password_textarea.dart';
import '../../components/textareas/rich_text_editor.dart';
import '../../components/textareas/textarea.dart';

class TestComponent extends StatelessWidget {
  const TestComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(title: 'Test Appbar'),
          SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                PrimaryButton(
                  onTap: () {},
                  text: 'Primary Button',
                ),
                SecondaryButton(
                  onTap: () {},
                  text: 'Secondary Button',
                ).addMarginTop(24),
                PrimaryButton(
                  enable: false,
                  onTap: () {},
                  text: 'Disabled Button',
                ).addMarginTop(24),
                DatePickerButton(
                  controller: DatePickerController(),
                ).addMarginTop(24),
                TimePickerButton(
                  controller: TimePickerController(),
                ).addMarginTop(24),
                DropdownField(
                  controller: DropDownController(),
                  hint: 'Pilih Jenis Kegiatan',
                  items: [
                    DropDownItem(
                      title: 'Pembuatan status',
                      value: 0,
                    ),
                    DropDownItem(
                      title: 'Bed-side teaching (BST)',
                      value: 1,
                    ),
                  ],
                ).addMarginTop(24),
                const TextArea(
                  hint: 'General Textfield',
                ).addMarginTop(24),
                const PasswordTextarea(
                  hint: 'General Textfield',
                ).addMarginTop(24),
                SizedBox(
                  height: 250,
                  child: RichTextEditor(
                    controller: FleatherController(),
                  ),
                ).addMarginTop(24),
                PrimaryCheckbox(
                  controller: CheckboxController(false),
                  title: 'Test checkbox',
                ).addMarginTop(24),
                const OtpField().addMarginTop(24),
              ],
            ),
          ).addExpanded,
        ],
      ),
    );
  }
}
