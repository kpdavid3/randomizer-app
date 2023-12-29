import 'package:flutter/material.dart';
import '../components/choicebox.dart';
import '../classes/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class MultipleChoicePage extends StatelessWidget {
  final MCQuestion question;
  final bool state;
  const MultipleChoicePage(
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
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                            text: question.choices[0],
                            status: (question.choices[0] == question.answer &&
                                state))),
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[1],
                      status: (question.choices[1] == question.answer && state),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                            text: question.choices[2],
                            status: (question.choices[2] == question.answer &&
                                state))),
                    Expanded(
                        child: ChoiceBox(
                            text: question.choices[3],
                            status: (question.choices[3] == question.answer &&
                                state))),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}
