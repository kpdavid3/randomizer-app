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
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 40, 50, 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AD52),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: const Color(0xFF333333),
                      width: 15,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          () {
                            if (selectedPage == "mc") {
                              return (randomQuestions[currentPage]
                                      as MCQuestion)
                                  .answer;
                            } else if (selectedPage == "tf") {
                              return (randomQuestions[currentPage]
                                      as TFQuestion)
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
                            height: 1,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  left: MediaQuery.of(context).size.width * 0.315,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Answer",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
