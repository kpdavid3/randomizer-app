import 'package:flutter/material.dart';
import '../components/countdown.dart';

class TrueOrFalsePage extends StatelessWidget {
  const TrueOrFalsePage({super.key});

  void _showAnswer() {}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.red, // Set red background color
        child: Center(
          child: Container(
            width: screenWidth * 0.95,
            height: screenHeight * 0.9,
            decoration: BoxDecoration(
              color: Colors.white, // White background for the rounded rectangle
              borderRadius: BorderRadius.circular(20), // Set border radius
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 28.0),
                          decoration: const BoxDecoration(
                            color: Colors
                                .white, // White background for the rounded rectangle
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
                                      Expanded(
                                          child:
                                              buildChoiceBox("A. Apollo 10")),
                                      Expanded(
                                          child:
                                              buildChoiceBox("B. Apollo 11")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child:
                                              buildChoiceBox("C. Apollo 11")),
                                      Expanded(
                                          child:
                                              buildChoiceBox("D. Apollo 12")),
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
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          child: CountdownApp(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100.0,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle prev button press
                        },
                        child: Text('Prev'),
                      ),
                      const SizedBox(width: 10),
                      for (int i = 1; i <= 10; i++)
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              child: Text('$i'),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle next button press
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
