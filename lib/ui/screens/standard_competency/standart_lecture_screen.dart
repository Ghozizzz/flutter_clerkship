import 'dart:async';

import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:clerkship/ui/screens/standard_competency/provider/standart_competency_provider.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/network/entity/scientifc_event_participant_response.dart';
import '../../../r.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_standard.dart';
import 'components/item_standard_total.dart';

class StandartLectureScreen extends StatefulWidget {
  final ScientificEventParticipant participant;

  const StandartLectureScreen({
    super.key,
    required this.participant,
  });

  @override
  State<StandartLectureScreen> createState() => _StandartLectureScreenState();
}

class _StandartLectureScreenState extends State<StandartLectureScreen> {
  bool isClickSearch = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context.read<StandartCompetencyProvider>().clearPaths();
      context.read<StandartCompetencyProvider>().setIndex(0, '');

      if (widget.participant.idUser == null) return;
      context
          .read<StandartCompetencyProvider>()
          .getDepartmentLecture(idUser: widget.participant.idUser!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StandartCompetencyProvider>();
    final data = context.watch<StandartCompetencyProvider>().data;
    final paths = context.watch<StandartCompetencyProvider>().paths;
    final pageIndex = context.watch<StandartCompetencyProvider>().index;
    final tipe = context.watch<StandartCompetencyProvider>().tipe;
    final selectedId = context.watch<StandartCompetencyProvider>().selectedId;
    final loading = context.watch<StandartCompetencyProvider>().loading;

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isClickSearch
                ? // create search bar
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      color: Themes.white,
                      boxShadow: [
                        BoxShadow(
                          color: Themes.black.withOpacity(0.1),
                          blurRadius: 10.w,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    child: Row(
                      children: [
                        RippleButton(
                          onTap: () {
                            setState(() {
                              context
                                  .read<StandartCompetencyProvider>()
                                  .searchSK('');
                              // clear search
                              isClickSearch = false;
                            });
                          },
                          padding: EdgeInsets.all(8.w),
                          child: SvgPicture.asset(
                            AssetIcons.icClose,
                            width: 18.w,
                            height: 18.w,
                          ),
                        ),
                        TextArea(
                          hint: 'Cari Standar Kompetensi',
                          onChangedText: (value) {
                            // make delay 1 second after user stop typing
                            if (_debounce?.isActive ?? false) {
                              _debounce?.cancel();
                            }
                            _debounce =
                                Timer(const Duration(milliseconds: 500), () {
                              context
                                  .read<StandartCompetencyProvider>()
                                  .searchSK(value);
                            });
                          },
                        ).addExpanded,
                      ],
                    )).addMarginBottom(20.w)
                : PrimaryAppBar(
                    title: 'Kembali',
                    onTapBack: () {
                      if (pageIndex > 0) {
                        provider.goBack();
                      } else {
                        NavHelper.pop();
                      }
                    },
                    action: RippleButton(
                      onTap: () {
                        setState(() {
                          isClickSearch = true;
                        });
                      },
                      padding: EdgeInsets.all(4.w),
                      child: SvgPicture.asset(
                        AssetIcons.icSearch,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
            Text(
              'Standar Kompetensi',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              right: 20.w,
              left: 20.w,
            ),
            Text(
              '${widget.participant.namaStudent}',
              style: Themes().black16,
            ).addMarginLeft(20.w),
            Text(
              '${widget.participant.idUser}',
              style: Themes().black10?.withFontWeight(FontWeight.w500),
            ).addMarginLeft(20.w),
            if (pageIndex > 0)
              Text(
                paths.sublist(1, pageIndex + 1).join(' > '),
                style: Themes().gray10?.boldText(),
              ).addMarginOnly(
                top: 18,
                left: 20.w,
              ),
            if ((pageIndex >= data.length - 1) && (tipe == true))
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: Themes().blackBold12?.withColor(Themes.black),
                    ).addFlexible,
                    Text(
                      'Frekuensi',
                      style:
                          Themes().blackBold12?.withFontWeight(FontWeight.w500),
                      textAlign: TextAlign.end,
                    ).addFlexible,
                  ],
                ),
              ),
            if (loading) const Center(child: CircularProgressIndicator()),
            if ((pageIndex < data.length - 1) && (tipe == true))
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: paths.isNotEmpty ? data[pageIndex].data.length : 0,
                itemBuilder: (context, index) {
                  final itemData = data[pageIndex].data[index];

                  return AnimatedItem(
                    index: index,
                    child: ItemStandard(
                      onTap: () {
                        context.read<StandartCompetencyProvider>().searchSK('');
                        switch (pageIndex) {
                          case 0:
                            context
                                .read<StandartCompetencyProvider>()
                                .addSelectedId('id_batch', itemData.id);
                            context
                                .read<StandartCompetencyProvider>()
                                .getListSKJenis();
                            break;
                          case 1:
                            if (itemData.tipe == '0') {
                              context
                                  .read<StandartCompetencyProvider>()
                                  .addSelectedId('id_jenis', itemData.id);
                              context
                                  .read<StandartCompetencyProvider>()
                                  .addSelectedId('id_group', '0');
                              context
                                  .read<StandartCompetencyProvider>()
                                  .getListSKGroupDetailBypass();
                            } else {
                              context
                                  .read<StandartCompetencyProvider>()
                                  .addSelectedId('id_jenis', itemData.id);
                              context
                                  .read<StandartCompetencyProvider>()
                                  .getListSKGroup(
                                    idJenisSK: itemData.id,
                                    idBatch: selectedId['id_batch'] ?? '',
                                  );
                            }
                            break;
                          case 2:
                            context
                                .read<StandartCompetencyProvider>()
                                .addSelectedId('id_group', itemData.id);
                            context
                                .read<StandartCompetencyProvider>()
                                .getListSKGroupDetail();
                            break;
                        }
                        provider.setIndex(
                          pageIndex + 1,
                          itemData.title,
                        );

                        isClickSearch = false;
                      },
                      title: itemData.title,
                      subtitle: itemData.subtitle,
                    ),
                  ).addMarginBottom(12);
                },
              ).addExpanded
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: data[pageIndex].data.length,
                itemBuilder: (context, index) {
                  final itemData = data[pageIndex].data[index];

                  return AnimatedItem(
                    index: index,
                    child: ItemStandardTotal(
                      title: itemData.title,
                      total: itemData.count,
                    ),
                  ).addMarginBottom(12);
                },
              ).addExpanded
          ],
        ),
      ),
    );
  }
}
