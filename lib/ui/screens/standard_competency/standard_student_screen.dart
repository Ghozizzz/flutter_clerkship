import 'package:clerkship/ui/components/commons/animated_item.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:clerkship/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';
import 'components/item_standard.dart';
import 'components/item_standard_total.dart';
import 'provider/standart_competency_provider.dart';

class StandardStudentScreen extends StatefulWidget {
  const StandardStudentScreen({super.key});

  @override
  State<StandardStudentScreen> createState() => _StandardStudentScreenState();
}

class _StandardStudentScreenState extends State<StandardStudentScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      context.read<StandartCompetencyProvider>().clearPaths();
      context.read<StandartCompetencyProvider>().setIndex(0, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<StandartCompetencyProvider>();
    final data = context.watch<StandartCompetencyProvider>().data;
    final paths = context.watch<StandartCompetencyProvider>().paths;
    final pageIndex = context.watch<StandartCompetencyProvider>().index;

    return WillPopScope(
      onWillPop: () async {
        if (pageIndex > 0) {
          provider.setIndex(
            pageIndex - 1,
            data.entries.toList()[pageIndex - 1].key,
          );
          provider.removeLastPath();
        } else {
          NavHelper.pop();
        }
        return false;
      },
      child: SafeStatusBar(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryAppBar(
                title: 'Kembali',
                action: RippleButton(
                  onTap: () {},
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
                'Bhima Saputra',
                style: Themes().black16,
              ).addMarginLeft(20.w),
              Text(
                '2345 2342341',
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
              if (pageIndex < data.length - 1)
                ListView.builder(
                  padding: EdgeInsets.all(20.w),
                  itemCount:
                      paths.isNotEmpty ? data[paths[pageIndex]]?.length : 0,
                  itemBuilder: (context, index) {
                    return AnimatedItem(
                      index: index,
                      child: ItemStandard(
                        onTap: () {
                          if (pageIndex < data.length) {
                            provider.setIndex(
                              pageIndex + 1,
                              data.entries.toList()[pageIndex + 1].key,
                            );
                          }
                        },
                      ),
                    ).addMarginBottom(12);
                  },
                ).addExpanded
              else
                ListView.builder(
                  padding: EdgeInsets.all(20.w),
                  itemCount: data[paths[pageIndex]]?.length,
                  itemBuilder: (context, index) {
                    return AnimatedItem(
                      index: index,
                      child: const ItemStandardTotal(),
                    ).addMarginBottom(12);
                  },
                ).addExpanded
            ],
          ),
        ),
      ),
    );
  }
}
