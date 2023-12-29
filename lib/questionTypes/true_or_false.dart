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
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: ChoiceBox(
                            text: 'True', status: true == question.answer)),
                    Expanded(
                        child: ChoiceBox(
                      text: "False",
                      status: false == question.answer,
                    )),
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
