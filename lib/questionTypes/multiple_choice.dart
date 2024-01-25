import 'package:flutter/material.dart';
import '../components/choicebox.dart';
import '../classes/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultipleChoicePage extends StatelessWidget {
  final MCQuestion question;
  final bool state;
  const MultipleChoicePage(
      {super.key, required this.question, required this.state});

  @override
  Widget build(BuildContext context) {
    int length = findLongestChoiceLength(question.choices);
    bool isLessLength = lessLength(question.choices);
    double fontSize;
    if (length > 70) {
      fontSize = 16;
    } else if (length > 20) {
      fontSize = 22;
    } else {
      fontSize = 28;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Text(
                question.questionText,
                style: GoogleFonts.montserrat(
                  fontSize: 28.sp,
                  color: const Color(0xFF333333),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isLessLength)
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: ChoiceBox(
                        text: question.choices[0].trimLeft(),
                        type: "mc",
                        letter: "A.",
                        fontSize: fontSize.sp,
                      )),
                      Expanded(
                          child: ChoiceBox(
                        text: question.choices[1].trimLeft(),
                        type: "mc",
                        letter: "B.",
                        fontSize: fontSize.sp,
                      )),
                    ],
                  ),
                ),
              if (!isLessLength)
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: ChoiceBox(
                        text: question.choices[2].trimLeft(),
                        type: "mc",
                        letter: "C.",
                        fontSize: fontSize.sp,
                      )),
                      Expanded(
                          child: ChoiceBox(
                        text: question.choices[3].trimLeft(),
                        type: "mc",
                        letter: "D.",
                        fontSize: fontSize.sp,
                      )),
                    ],
                  ),
                ),
              if (isLessLength)
                Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[0].trimLeft(),
                      type: "mc",
                      letter: "A.",
                      fontSize: fontSize.sp,
                    )),
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[1].trimLeft(),
                      type: "mc",
                      letter: "B.",
                      fontSize: fontSize.sp,
                    )),
                  ],
                ),
              if (isLessLength)
                Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[2].trimLeft(),
                      type: "mc",
                      letter: "C.",
                      fontSize: fontSize.sp,
                    )),
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[3].trimLeft(),
                      type: "mc",
                      letter: "D.",
                      fontSize: fontSize.sp,
                    )),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }
}

int findLongestChoiceLength(List<String> choices) {
  int maxLength = 0;

  for (String choice in choices) {
    if (choice.length > maxLength) {
      maxLength = choice.length;
    }
  }
  return maxLength;
}

bool lessLength(List<String> choices) {
  for (String choice in choices) {
    if (choice.length >= 70) {
      return false;
    }
  }
  return true;
}
