import 'package:flutter/material.dart';
import '../classes/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentificationPage extends StatelessWidget {
  final IQuestion question;
  final bool state;

  const IdentificationPage(
      {super.key, required this.question, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // White background for the rounded rectangle
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              question.questionText,
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
                child: Text(
              state ? question.answer : "_________________",
              style: GoogleFonts.poppins(
                fontSize: 64,
                color: state ? Colors.red : Colors.black,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
