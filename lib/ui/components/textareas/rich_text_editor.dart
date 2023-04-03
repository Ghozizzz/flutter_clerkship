import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:responsive/responsive.dart';

import '../../../config/themes.dart';
import '../../../r.dart';
import '../buttons/toggle_button.dart';
import '../commons/flat_card.dart';

class RichTextEditor extends StatefulWidget {
  final FleatherController controller;
  final String? hint;
  final bool readOnly;

  const RichTextEditor({
    super.key,
    this.hint,
    this.readOnly = false,
    required this.controller,
  });

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      border: Border.all(color: Themes.stroke),
      child: Column(
        children: [
          if (!widget.readOnly)
            FlatCard(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              width: double.infinity,
              color: Themes.stroke,
              child: FleatherToolbar(
                children: [
                  ToggleButton(
                    controller: widget.controller,
                    attribute: ParchmentAttribute.bold,
                    icon: AssetIcons.icBold,
                  ),
                  ToggleButton(
                    controller: widget.controller,
                    attribute: ParchmentAttribute.italic,
                    icon: AssetIcons.icItalic,
                  ),
                  ToggleButton(
                    controller: widget.controller,
                    attribute: ParchmentAttribute.underline,
                    icon: AssetIcons.icUnderline,
                  ),
                  ToggleButton(
                    controller: widget.controller,
                    attribute: ParchmentAttribute.left,
                    icon: AssetIcons.icAlignLeft,
                  ),
                  ToggleButton(
                    controller: widget.controller,
                    attribute: ParchmentAttribute.center,
                    icon: AssetIcons.icAlignCenter,
                  ),
                  ToggleButton(
                    controller: widget.controller,
                    attribute: ParchmentAttribute.right,
                    icon: AssetIcons.icAlignRight,
                  ),
                  ToggleButton(
                    controller: widget.controller,
                    attribute: ParchmentAttribute.justify,
                    icon: AssetIcons.icAlignJustify,
                  ),
                ],
              ),
            ),
          Expanded(
            child: FleatherEditor(
              readOnly: widget.readOnly,
              showCursor: !widget.readOnly,
              controller: widget.controller,
              focusNode: focusNode,
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
