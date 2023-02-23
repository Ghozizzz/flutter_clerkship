import 'package:clerkship/data/network/entity/scoring_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../../config/themes.dart';
import '../../../components/buttons/quiz_button.dart';
import '../../../components/textareas/rich_text_editor.dart';

class ItemQuizGroup extends StatelessWidget {
  final ScoringDetail data;

  const ItemQuizGroup({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${data.namaSection}',
          style: Themes().blackBold14?.withColor(Themes.black),
        ).addMarginBottom(12),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.dataDetail?.length,
          itemBuilder: (context, index) {
            final itemData = data.dataDetail?[index];

            if (data.idTipe == 0) {
              return itemData != null
                  ? QuizButton(
                      data: itemData,
                    ).addMarginTop(20)
                  : Container();
            } else {
              return itemData != null
                  ? SizedBox(
                      height: 300,
                      child: RichTextEditor(
                        controller: itemData.notesController,
                        hint: '${data.namaSection}',
                      ),
                    )
                  : Container();
            }
          },
        ).addMarginBottom(20)
      ],
    );
  }
}
