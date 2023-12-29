import 'package:flutter/material.dart';
import '../classes/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentificationPage extends StatelessWidget {
  final IQuestion question;

  const IdentificationPage({super.key, required this.question});

  void _showAnswer() {}

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
              question.answer,
              style: GoogleFonts.poppins(
                fontSize: 64,
                color: Colors.red,
              ),
            )),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: _showAnswer,
                child: const Text('Show Answer'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
