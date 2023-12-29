import 'package:flutter/material.dart';
import '../components/choicebox.dart';
import '../classes/questions.dart';

class TrueOrFalsePage extends StatelessWidget {
  final TFQuestion question;

  const TrueOrFalsePage({super.key, required this.question});

  void _showAnswer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 28.0),
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
            const Text(
              'Easy Round',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Question 1 out of 10',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              question.questionText,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(text: 'A. Apollo 10', status: true)),
                    Expanded(
                        child: ChoiceBox(
                      text: "B. Apollo 11",
                      status: false,
                    )),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(text: "C. Apollo 11", status: true)),
                    Expanded(
                        child: ChoiceBox(text: "D. Apollo 12", status: true)),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: _showAnswer,
                    child: const Text('Show Answer'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
