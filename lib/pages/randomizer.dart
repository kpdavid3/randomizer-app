import 'package:flutter/material.dart';
import '../components/countdown.dart';
import '../questionTypes/identification.dart';
import '../questionTypes/multiple_choice.dart';
import '../questionTypes/true_or_false.dart';

class MCQuestion {
  final String questionText;
  final List<String> choices;
  final String answer;

  MCQuestion({
    required this.questionText,
    required this.choices,
    required this.answer,
  });
}

List<MCQuestion> easyQuestions = [
  MCQuestion(
    questionText: "What is the largest mammal in the world?",
    choices: ["Elephant", "Blue Whale", "Giraffe", "Rhino"],
    answer: "Blue Whale",
  ),
  MCQuestion(
    questionText: "What do bees collect and use to create honey?",
    choices: ["Pollen", "Dust", "Leaves", "Bark"],
    answer: "Pollen",
  ),
  MCQuestion(
    questionText: "Which animal is known for its ability to change color?",
    choices: ["Chameleon", "Octopus", "Polar Bear", "Tiger"],
    answer: "Chameleon",
  ),
];

class RandomizerPage extends StatelessWidget {
  const RandomizerPage({super.key});

  void _showAnswer() {}

  @override
  Widget build(BuildContext context) {
    String selectedPage = "multipleChoice";
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
                      (() {
                        if (selectedPage == "multipleChoice") {
                          return const MultipleChoicePage();
                        } else if (selectedPage == "trueOrFalse") {
                          return const TrueOrFalsePage();
                        } else if (selectedPage == "identification") {
                          return const IdentificationPage();
                        } else {
                          return Container();
                        }
                      })(),
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
