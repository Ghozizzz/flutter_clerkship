import 'dart:async';

import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/breadcrum_sk.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import '../standard_competency/components/item_standard_total.dart';

class DetailStandardCompetencyScreen extends StatefulWidget {
  final BreadcrumSK breadcrumSK;
  final BreadcrumSK breadcrumSKJenis;
  final BreadcrumSK breadcrumSKGroup;
  const DetailStandardCompetencyScreen(
      {super.key,
      required this.breadcrumSK,
      required this.breadcrumSKJenis,
      required this.breadcrumSKGroup});

  @override
  State<DetailStandardCompetencyScreen> createState() =>
      _DetailStandardCompetencyScreenState();
}

class _DetailStandardCompetencyScreenState
    extends State<DetailStandardCompetencyScreen> {
  bool isClickSearch = false;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final skListGroupDetail =
        context.watch<StandardCompetencyProvider>().skListGroupDetail;
    final isLoadingGroupDetail =
        context.watch<StandardCompetencyProvider>().isloadingListSKGroupDetail;

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isClickSearch
                ? Container(
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
                                  .read<StandardCompetencyProvider>()
                                  .searchSK('sklistgroupdetail', '');
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
                                  .read<StandardCompetencyProvider>()
                                  .searchSK('sklistgroupdetail', value);
                            });
                          },
                        ).addExpanded,
                      ],
                    )).addMarginBottom(20.w)
                : PrimaryAppBar(
                    title: 'Kembali',
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
              top: 20.w,
              right: 20.w,
              left: 20.w,
            ),
            Text(
              '${widget.breadcrumSK.title} > ${widget.breadcrumSKJenis.title} > ${widget.breadcrumSKGroup.title}',
              style: Themes().blackBold10?.withColor(Themes.hint),
            ).addMarginOnly(
              top: 4,
              left: 20.w,
              bottom: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
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
            if (isLoadingGroupDetail)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: skListGroupDetail.length,
                itemBuilder: (context, index) {
                  return ItemStandardTotal(
                    title: skListGroupDetail[index].name!,
                    total: skListGroupDetail[index].jumlah!,
                  ).addMarginBottom(12);
                },
              ).addExpanded
          ],
        ),
      ),
    );
  }
}
