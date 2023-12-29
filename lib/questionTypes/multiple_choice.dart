import 'package:flutter/material.dart';

class MultipleChoicePage extends StatelessWidget {
  const MultipleChoicePage({super.key});

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
            const Text(
              'What number was the Apollo mission that successfully put a man on the moon for the first time in human history?',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: buildChoiceBox("A. Apollo 10")),
                    Expanded(child: buildChoiceBox("B. Apollo 11")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: buildChoiceBox("C. Apollo 11")),
                    Expanded(child: buildChoiceBox("D. Apollo 12")),
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

Widget buildChoiceBox(String text) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
