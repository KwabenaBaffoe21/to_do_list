import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.label,
    this.maxLength,
    this.maxLines,
    this.icon,
  });

  final String label;
  final int? maxLength;
  final int? maxLines;
  final IconData? icon;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w300),
      cursorHeight: 25,
      maxLines: widget.maxLines ?? 1,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
          hintText: widget.label,
          hintStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff65558f)),
          suffixIcon: widget.icon != null ? Icon(widget.icon) : null),
    );
  }
}
