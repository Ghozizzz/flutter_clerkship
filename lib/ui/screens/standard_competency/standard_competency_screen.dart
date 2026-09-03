import 'dart:async';

import 'package:clerkship/data/models/breadcrum_sk.dart';
import 'package:clerkship/r.dart';
import 'package:clerkship/ui/components/textareas/textarea.dart';
import 'package:clerkship/ui/screens/standard_competency/sub_first_standard_competency_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/sk_constants.dart';
import '../../../config/themes.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../../utils/nav_helper.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_standard.dart';

class StandardCompetencyScreen extends StatefulWidget {
  const StandardCompetencyScreen({super.key});

  @override
  State<StandardCompetencyScreen> createState() =>
      _StandardCompetencyScreenState();
}

class _StandardCompetencyScreenState extends State<StandardCompetencyScreen> {
  bool isClickSearch = false;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    // id 0 ("Tata Tertib") adalah entri umum khusus menu Peraturan dan Tata
    // Tertib — tidak relevan sebagai batch, jadi disembunyikan di sini.
    final skList = context
        .watch<StandardCompetencyProvider>()
        .skList
        .where((sk) => sk.id != kTataTertibBatchId)
        .toList();
    final isLoading =
        context.watch<StandardCompetencyProvider>().isloadingListSK;

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
                                  .searchSK('sklist', '');
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
                                  .searchSK('sklist', value);
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
              bottom: 22,
            ),
            if (isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: skList.length,
                itemBuilder: (context, index) {
                  return ItemStandard(
                    title: skList[index].namaBatch!,
                    subtitle: skList[index].batchName!,
                    onTap: () {
                      context.read<StandardCompetencyProvider>().getListSKJenis(
                            idBatch: '${skList[index].id}',
                          );
                      NavHelper.navigatePush(
                        SubFirstStandardCompetencyScreen(
                          breadcrumSK: BreadcrumSK(
                              id: skList[index].id!,
                              title: skList[index].namaBatch!,
                              subtitle: skList[index].batchName!),
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
