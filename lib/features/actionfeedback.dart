import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionFeedback extends StatelessWidget {
  const ActionFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Center(
        child: Text(
          'Task Created',
          style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400),
          //textAlign: TextAlign.center,
        ),
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: const Color(0xa6655587),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      width: 150,
      behavior: SnackBarBehavior.floating,
    );
  }
}
