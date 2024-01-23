import 'package:flutter/material.dart';
import '../classes/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdentificationPage extends StatelessWidget {
  final IQuestion question;
  final bool state;

  const IdentificationPage(
      {super.key, required this.question, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            question.questionText,
            style: GoogleFonts.montserrat(
              fontSize: 48.sp,
              color: const Color(0xFF333333),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
