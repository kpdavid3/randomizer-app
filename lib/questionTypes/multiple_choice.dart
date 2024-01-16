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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Text(
          question.questionText,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            color: const Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[0],
                      type: "mc",
                      letter: "A.",
                    )),
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[1],
                      type: "mc",
                      letter: "B.",
                    )),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[2],
                      type: "mc",
                      letter: "C.",
                    )),
                    Expanded(
                        child: ChoiceBox(
                            text: question.choices[3],
                            type: "mc",
                            letter: "D.")),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
