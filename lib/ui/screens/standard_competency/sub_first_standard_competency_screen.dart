import 'dart:async';

import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:clerkship/ui/screens/standard_competency/sub_standard_competency_screen.dart';
import 'package:clerkship/ui/screens/standard_competency/detail_standard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/models/breadcrum_sk.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_standard.dart';

class SubFirstStandardCompetencyScreen extends StatefulWidget {
  final BreadcrumSK breadcrumSK;
  const SubFirstStandardCompetencyScreen(
      {super.key, required this.breadcrumSK});

  @override
  State<SubFirstStandardCompetencyScreen> createState() =>
      _SubFirstStandardCompetencyScreenState();
}

class _SubFirstStandardCompetencyScreenState
    extends State<SubFirstStandardCompetencyScreen> {
  bool isClickSearch = false;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final skListJenis = context.watch<StandardCompetencyProvider>().skListJenis;
    final isLoadingJenis =
        context.watch<StandardCompetencyProvider>().isloadingListSKJenis;
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
                                  .searchSK('sklistjenis', '');
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
                                  .searchSK('sklistjenis', value);
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
              right: 20.w,
              left: 20.w,
            ),
            Text(
              widget.breadcrumSK.title,
              style: Themes().blackBold10?.withColor(Themes.hint),
            ).addMarginOnly(
              top: 4,
              left: 20.w,
              bottom: 16,
            ),
            if (isLoadingJenis)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: skListJenis.length,
                itemBuilder: (context, index) {
                  return ItemStandard(
                    title: skListJenis[index].namaJenis!,
                    onTap: () {
                      context.read<StandardCompetencyProvider>().getListSKGroup(
                            idJenisSK: '${skListJenis[index].id}',
                            idbatch: '${widget.breadcrumSK.id}',
                          );

                      if (skListJenis[index].tipe! == 1) {
                        NavHelper.navigatePush(
                          SubStandardCompetencyScreen(
                            breadcrumSK: widget.breadcrumSK,
                            breadcrumSKJenis: BreadcrumSK(
                                id: skListJenis[index].id!,
                                title: skListJenis[index].namaJenis!),
                          ),
                        );
                      } else {
                        context
                            .read<StandardCompetencyProvider>()
                            .getListSKGroupDetail(
                              idJenisSK: skListJenis[index].id!,
                              idBatch: widget.breadcrumSK.id,
                              idGroup: 0,
                            );

                        NavHelper.navigatePush(
                          DetailStandardCompetencyScreen(
                            breadcrumSK: widget.breadcrumSK,
                            breadcrumSKJenis: BreadcrumSK(
                                id: skListJenis[index].id!,
                                title: skListJenis[index].namaJenis!),
                            breadcrumSKGroup: BreadcrumSK(
                              id: 0,
                              title: 'Semua',
                            ),
                          ),
                        );
                      }
                    },
                  ).addMarginBottom(12);
                },
              ).addExpanded
          ],
        ),
      ),
    );
  }
}
