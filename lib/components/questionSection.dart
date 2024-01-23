import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomizer_app/classes/questions.dart';
import 'package:randomizer_app/questionTypes/identification.dart';
import 'package:randomizer_app/questionTypes/multiple_choice.dart';
import 'package:randomizer_app/questionTypes/true_or_false.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizPage extends StatelessWidget {
  final String selectedPage;
  final int currentPage;
  final List<dynamic> randomQuestions;
  final dynamic questionState;
  final int remainingSeconds;

  const QuizPage({
    super.key,
    required this.remainingSeconds,
    required this.selectedPage,
    required this.currentPage,
    required this.randomQuestions,
    required this.questionState,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (() {
                    if (selectedPage == "mc") {
                      return Expanded(
                          flex: 2,
                          child: MultipleChoicePage(
                              question:
                                  randomQuestions[currentPage] as MCQuestion,
                              state: questionState));
                    } else if (selectedPage == "tf") {
                      return Expanded(
                          flex: 2,
                          child: TrueOrFalsePage(
                              question:
                                  randomQuestions[currentPage] as TFQuestion,
                              state: questionState));
                    } else if (selectedPage == "id") {
                      return Expanded(
                          flex: 2,
                          child: IdentificationPage(
                              question:
                                  randomQuestions[currentPage] as IQuestion,
                              state: questionState));
                    } else {
                      return Container();
                    }
                  })(),
                  Row(children: [
                    const Spacer(),
                    Text(
                      "© QRA 2024",
                      style: GoogleFonts.montserrat(
                          color: const Color(0xFF333333),
                          fontSize: 12.sp,
                          fontStyle: FontStyle.italic),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
