import 'package:flutter/material.dart';
import '../components/choicebox.dart';
import '../classes/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class TrueOrFalsePage extends StatelessWidget {
  final TFQuestion question;
  final bool state;

  const TrueOrFalsePage(
      {super.key, required this.question, required this.state});

  void _showAnswer() {}

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
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: ChoiceBox(
                        text: 'True',
                        type: "tf",
                        letter: "",
                      )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: ChoiceBox(
                        text: 'False',
                        type: "tf",
                        letter: "",
                      )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
