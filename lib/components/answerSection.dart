import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomizer_app/classes/questions.dart';

class AnswerPage extends StatelessWidget {
  final int currentPage;
  final List<dynamic> randomQuestions;
  final String selectedPage;

  const AnswerPage({
    super.key,
    required this.currentPage,
    required this.randomQuestions,
    required this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              () {
                if (selectedPage == "mc") {
                  return (randomQuestions[currentPage] as MCQuestion)
                      .answer
                      .toUpperCase();
                } else if (selectedPage == "tf") {
                  return (randomQuestions[currentPage] as TFQuestion)
                      .answer
                      .toString()
                      .toUpperCase();
                } else if (selectedPage == "id") {
                  return (randomQuestions[currentPage] as IQuestion)
                      .answer
                      .toUpperCase();
                } else {
                  return "";
                }
              }(),
              style: GoogleFonts.montserrat(
                color: const Color(0xFF333333),
                fontSize: 54,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            const SizedBox(height: 10),
            Text(
              randomQuestions[currentPage].explanation,
              style: GoogleFonts.montserrat(
                color: const Color(0xFF333333),
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
