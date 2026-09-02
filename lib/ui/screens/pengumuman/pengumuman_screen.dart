import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:clerkship/data/network/services/get_feature_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/breadcrum_sk.dart';
import '../../../data/shared_providers/standard_competency_provider.dart';
import '../../../config/themes.dart';
import '../../components/buttons/ripple_button.dart';
import '../../components/commons/primary_appbar.dart';
import '../../components/commons/safe_statusbar.dart';

class PengumumanScreen extends StatefulWidget {
  final BreadcrumSK breadcrumSK;
  const PengumumanScreen({super.key, required this.breadcrumSK});

  @override
  State<PengumumanScreen> createState() => _PengumumanScreenState();
}

class _PengumumanScreenState extends State<PengumumanScreen> {
  String htmlData = '';

  @override
  void initState() {
    super.initState();
    GetFeatureService()
        .getFeature(idBatch: widget.breadcrumSK.id)
        .then((value) {
      if (value.statusCode == 200 && mounted) {
        setState(() {
          htmlData = value.data?.data?.news ?? '';
        });
      }
    }).catchError((_) {
      // Server bermasalah / respons bukan JSON — gagal senyap, bagian
      // berita cukup kosong daripada nge-crash seluruh halaman.
    });
  }

  final _urlRegex = RegExp(r'((https?:\/\/)[^\s]+)', caseSensitive: false);

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Teks deskripsi tanpa URL mentah — dipakai saat kartu link-preview di
  /// [_buildLinkPreviews] juga ditampilkan, jadi URL tidak perlu dobel
  /// muncul sebagai teks biru di sini juga.
  Widget _buildDescription(String description) {
    final withoutUrls = description.replaceAll(_urlRegex, '').trim();
    if (withoutUrls.isEmpty) return const SizedBox.shrink();
    return Text(withoutUrls, style: Themes().black14);
  }

  /// Teks deskripsi apa adanya dengan URL tetap tampil & bisa diklik inline —
  /// dipakai untuk batch selain "Tata Tertib" (id 0) yang tidak memakai
  /// kartu link-preview.
  Widget _buildDescriptionWithInlineLinks(String description) {
    final spans = <InlineSpan>[];
    var start = 0;
    for (final match in _urlRegex.allMatches(description)) {
      if (match.start > start) {
        spans.add(TextSpan(text: description.substring(start, match.start)));
      }
      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Themes.primary,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
        ),
      );
      start = match.end;
    }
    if (start < description.length) {
      spans.add(TextSpan(text: description.substring(start)));
    }
    return RichText(text: TextSpan(style: Themes().black14, children: spans));
  }

  List<String> _extractUrls(String description) {
    final urls = _urlRegex
        .allMatches(description)
        .map((match) => match.group(0)!)
        .toSet()
        .toList();
    return urls;
  }

  Widget _buildLinkPreviews(String description) {
    final urls = _extractUrls(description);
    if (urls.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: urls
          .map(
            (url) => AnyLinkPreview(
              link: url,
              displayDirection: UIDirection.uiDirectionHorizontal,
              urlLaunchMode: LaunchMode.externalApplication,
              borderRadius: 12,
              backgroundColor: Themes.lightGrey,
              bodyMaxLines: 2,
              errorWidget: RippleButton(
                onTap: () => _launchUrl(url),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Themes.lightGrey,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Text(
                    url,
                    style: Themes().black12?.withColor(Themes.primary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ).addMarginBottom(8.w),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final skDetail = context.watch<StandardCompetencyProvider>().skDetail;
    final isLoadingSkDetail =
        context.watch<StandardCompetencyProvider>().isloadingSkDetail;

    return SafeStatusBar(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryAppBar(
              title: 'Kembali',
              action: RippleButton(
                onTap: () {},
                padding: EdgeInsets.all(4.w),
                // child: SvgPicture.asset(
                //   AssetIcons.icSearch,
                //   width: 18.w,
                //   height: 18.w,
                // ),
              ),
            ),
            Text(
              'Pengumuman',
              style: Themes().primaryBold20,
            ).addMarginOnly(
              top: 0.w,
              right: 20.w,
              left: 20.w,
            ),
            Text(
              widget.breadcrumSK.title,
              style: Themes().primaryBold18,
            ).addMarginOnly(top: 5.w, right: 20.w, left: 20.w, bottom: 20.w),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoadingSkDetail)
                      const Center(child: CircularProgressIndicator())
                    else if (skDetail?.description != null &&
                        skDetail!.description!.isNotEmpty) ...[
                      // Kartu link-preview cuma buat "Tata Tertib" (id 0);
                      // batch lain cukup teks biasa dengan link inline.
                      if (widget.breadcrumSK.id == 0) ...[
                        _buildDescription(skDetail.description!).addMarginOnly(
                            right: 20.w, left: 20.w, bottom: 12.w),
                        _buildLinkPreviews(skDetail.description!)
                            .addMarginOnly(
                                right: 20.w, left: 20.w, bottom: 20.w),
                      ] else
                        _buildDescriptionWithInlineLinks(skDetail.description!)
                            .addMarginOnly(
                                right: 20.w, left: 20.w, bottom: 20.w),
                    ],
                    Html(
                      data: htmlData,
                    ).addMarginOnly(
                        top: 10.w, right: 10.w, left: 10.w, bottom: 20.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
