import 'dart:math';

import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/buttons/primary_button.dart';
import 'package:clerkship/ui/components/buttons/ripple_button.dart';
import 'package:clerkship/ui/components/commons/flat_card.dart';
import 'package:clerkship/ui/components/modal/modal_confirmation.dart';
import 'package:clerkship/utils/dialog_helper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../components/commons/primary_checkbox.dart';
import '../../clinic_detail_approval/components/bullet_list.dart';
import '../../clinic_detail_approval/components/item_file.dart';

class ItemClinicActivity extends StatelessWidget {
  ItemClinicActivity({
    super.key,
  });

  final checkboxController = CheckboxController(false);
  final expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      padding: EdgeInsets.all(12.w),
      border: Border.all(color: Themes.stroke),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryCheckbox(
            controller: checkboxController,
            checkBoxSize: Size(20.w, 20.w),
          ).addMarginBottom(12),
          Text(
            'Jaga Malam',
            style: Themes().blackBold14?.withColor(Themes.black),
          ),
          const ItemKeyValue(
            title: 'Mahasiswa',
            value: 'Bhima Saputra',
          ),
          const ItemKeyValue(
            title: 'Departemen',
            value: 'Ilmu Penyakit Dalam',
          ).addMarginBottom(12),
          ValueListenableBuilder(
            valueListenable: expandableController,
            builder: (context, value, _) {
              return ExpandablePanel(
                controller: expandableController,
                collapsed: RippleButton(
                  onTap: () {
                    expandableController.toggle();
                  },
                  color: Themes.transparent,
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetIcons.icChevronDown)
                          .addMarginRight(8.w),
                      Text(
                        'Lihat Detail',
                        style: Themes().black12,
                      )
                    ],
                  ),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BulletList(
                      title: 'Penyakit',
                    ),
                    const BulletList(
                      title: 'Prosedur',
                      withCount: true,
                    ),
                    const BulletList(
                      title: 'Catatan',
                    ).addMarginBottom(20),
                    Text(
                      'Attachment',
                      style: Themes().blackBold12?.withColor(Themes.hint),
                    ).addMarginBottom(8),
                    Column(
                      children: List.generate(
                        2,
                        (index) => const ItemFile().addMarginBottom(12),
                      ),
                    ),
                    RippleButton(
                      onTap: () {
                        expandableController.toggle();
                      },
                      color: Themes.transparent,
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: 180 * pi / 180,
                            child: SvgPicture.asset(AssetIcons.icChevronDown),
                          ).addMarginRight(8.w),
                          Text(
                            'Tutup Detail',
                            style: Themes().black12,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                theme: const ExpandableThemeData(
                  hasIcon: false,
                ),
              ).addMarginBottom(12);
            },
          ),
          Row(
            children: [
              PrimaryButton(
                onTap: () {
                  DialogHelper.showModalConfirmation(
                    title: 'Konfirmasi Penolakan',
                    message: 'Silakan masukkan alasan penolakan di bawah ini.',
                    type: ConfirmationType.withField,
                    labelField: 'Alasan Penolakan',
                    hintField: 'Masukkan Alasan Penolakan',
                    onPositiveTapWithField: (fieldValue) {
                      debugPrint(fieldValue);
                      Navigator.pop(context);
                    },
                  );
                },
                padding: EdgeInsets.all(14.w),
                color: Themes.red,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetIcons.icClose,
                      color: Themes.white,
                      width: 24.w,
                    ).addMarginRight(8.w),
                    Text(
                      'Tolak',
                      style: Themes().whiteBold16,
                    )
                  ],
                ),
              ).addExpanded,
              Container(
                width: 8.w,
              ),
              PrimaryButton(
                onTap: () {
                  DialogHelper.showModalConfirmation(
                    title: 'Konfirmasi Persetujuan',
                    message: 'Apakah anda yakin ingin menyetujui catatan ini?',
                    type: ConfirmationType.withField,
                    labelField: 'Masukan',
                    hintField: 'Masukkan Alasan Penolakan',
                    optionalField: true,
                    onPositiveTapWithField: (fieldValue) {
                      debugPrint(fieldValue);
                      Navigator.pop(context);
                    },
                  );
                },
                padding: EdgeInsets.all(14.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetIcons.icCheck,
                      color: Themes.white,
                      width: 24.w,
                    ).addMarginRight(8.w),
                    Text(
                      'Setujui',
                      style: Themes().whiteBold16,
                    )
                  ],
                ),
              ).addExpanded,
            ],
          )
        ],
      ),
    );
  }
}

class ItemKeyValue extends StatelessWidget {
  final String title;
  final String value;

  const ItemKeyValue({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Themes().gray12?.boldText(),
            ),
            Text(
              value,
              style: Themes().black12?.withColor(Themes.black),
            ),
          ],
        ).addSymmetricMargin(vertical: 12),
        Container(
          width: double.infinity,
          height: 1,
          color: Themes.stroke,
        ),
      ],
    );
  }
}
