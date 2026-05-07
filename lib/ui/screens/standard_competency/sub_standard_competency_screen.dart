import 'dart:async';

import 'package:clerkship/data/models/breadcrum_sk.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:clerkship/ui/screens/standard_competency/detail_standard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_standard.dart';

class SubStandardCompetencyScreen extends StatefulWidget {
  final BreadcrumSK breadcrumSK;
  final BreadcrumSK breadcrumSKJenis;
  const SubStandardCompetencyScreen(
      {super.key, required this.breadcrumSK, required this.breadcrumSKJenis});

  @override
  State<SubStandardCompetencyScreen> createState() =>
      _SubStandardCompetencyScreenState();
}

class _SubStandardCompetencyScreenState
    extends State<SubStandardCompetencyScreen> {
  bool isClickSearch = false;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final skListGroup = context.watch<StandardCompetencyProvider>().skListGroup;
    final isLoadingGroup =
        context.watch<StandardCompetencyProvider>().isloadingListSKGroup;

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
                                  .searchSK('sklistgroup', '');
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
                                  .searchSK('sklistgroup', value);
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
              '${widget.breadcrumSK.title} > ${widget.breadcrumSKJenis.title}',
              style: Themes().blackBold10?.withColor(Themes.hint),
            ).addMarginOnly(
              top: 4,
              left: 20.w,
              bottom: 16,
            ),
            if (isLoadingGroup)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: skListGroup.length,
                itemBuilder: (context, index) {
                  return ItemStandard(
                    title: skListGroup[index].namaGroup!,
                    onTap: () {
                      context
                          .read<StandardCompetencyProvider>()
                          .getListSKGroupDetail(
                            idJenisSK: widget.breadcrumSKJenis.id,
                            idBatch: widget.breadcrumSK.id,
                            idGroup: skListGroup[index].id!,
                          );

                      NavHelper.navigatePush(
                        DetailStandardCompetencyScreen(
                          breadcrumSK: widget.breadcrumSK,
                          breadcrumSKJenis: widget.breadcrumSKJenis,
                          breadcrumSKGroup: BreadcrumSK(
                            id: skListGroup[index].id!,
                            title: skListGroup[index].namaGroup!,
                          ),
                        ),
                      );
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
