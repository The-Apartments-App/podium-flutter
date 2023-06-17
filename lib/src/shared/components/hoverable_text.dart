import 'package:flutter/material.dart';

class HoverableText extends StatefulWidget {
  const HoverableText({
    super.key,
    required this.text,
    required this.style,
  });
  final String text;
  final TextStyle style;

  @override
  HoverableTextState createState() => HoverableTextState();
}

class HoverableTextState extends State<HoverableText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => _mouseEnter(true),
      onExit: (event) => _mouseEnter(false),
      child: Text(
        widget.text,
        style: widget.style.copyWith(
          decoration:
              _isHovering ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _isHovering = hover;
    });
  }
}
