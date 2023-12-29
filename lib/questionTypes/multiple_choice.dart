import 'package:flutter/material.dart';
import '../components/choicebox.dart';
import '../classes/questions.dart';

class MultipleChoicePage extends StatelessWidget {
  final MCQuestion question;
  const MultipleChoicePage({super.key, required this.question});

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
                Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                            text: question.choices[0],
                            status: question.choices[0] == question.answer)),
                    Expanded(
                        child: ChoiceBox(
                      text: question.choices[1],
                      status: question.choices[1] == question.answer,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                            text: question.choices[2],
                            status: question.choices[2] == question.answer)),
                    Expanded(
                        child: ChoiceBox(
                            text: question.choices[3],
                            status: question.choices[3] == question.answer)),
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
