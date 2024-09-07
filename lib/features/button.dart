import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/functions/add_task.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.text,
    this.icon,
    required this.screen,
    this.taskNameController,
    this.descriptionController,
  });

  final String text;
  final IconData? icon;
  final Widget screen;
  final TextEditingController? taskNameController;
  final TextEditingController? descriptionController;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        String? taskName = widget.taskNameController?.text.trim();
        String? description = widget.descriptionController?.text.trim();
        addTask(
          taskName: taskName!,
          description: description,
        );
        if(kDebugMode){
          print('TASK NAME: $taskName');
          print('DESCRIPTION: $description'
              '');
        }
        final snackBar = SnackBar(
          content: Center(
            child: Text(
              'Task Created',
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w400),
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
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.screen,
          ),
        );
      },
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
