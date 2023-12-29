import 'package:flutter/material.dart';
import '../components/countdown.dart';
import '../questionTypes/identification.dart';
import '../questionTypes/multiple_choice.dart';
import '../questionTypes/true_or_false.dart';

class RandomizerPage extends StatelessWidget {
  const RandomizerPage({super.key});

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
                      const Expanded(
                        flex: 2,
                        child: MultipleChoicePage(),
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
