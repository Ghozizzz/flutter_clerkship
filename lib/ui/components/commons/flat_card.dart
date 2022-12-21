import 'package:flutter/material.dart';

class FlatCard extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final Border? border;
  final BoxShadow? shadow;
  final EdgeInsets? padding;

  const FlatCard({
    Key? key,
    this.child,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
    this.border,
    this.shadow,
    this.padding,
  }) : super(key: key);

  @override
  State<FlatCard> createState() => _FlatCardState();
}

class _FlatCardState extends State<FlatCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      padding: widget.padding,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color ?? Colors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
        border: widget.border,
        boxShadow: widget.shadow != null ? [widget.shadow!] : [],
      ),
      child: widget.child ?? Container(),
    );
  }
}
