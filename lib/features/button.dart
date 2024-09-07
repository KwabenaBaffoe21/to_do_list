import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });

  final String text;
  final IconData? icon;

  final VoidCallback? onPressed;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 14),
        ),
        backgroundColor: WidgetStatePropertyAll(
          Color(0xff65558f),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              color: const Color(0xffffffff),
            ),
            const SizedBox(
              width: 11.63,
            ),
          ],
          Text(
            widget.text,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xffffffff),
            ),
          ),
        ],
      ),
    );
  }
}
