import 'package:flutter/material.dart';

class GradientTextUi extends StatelessWidget {
  const GradientTextUi(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
    this.maxLines,
  });

  final String text;
  final TextStyle? style;
  final LinearGradient gradient;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, maxLines: maxLines, style: style),
    );
  }
}
