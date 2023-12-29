import 'package:flutter/material.dart';
import '../components/countdown.dart';
import '../questionTypes/identification.dart';
import '../questionTypes/multiple_choice.dart';
import '../questionTypes/true_or_false.dart';
import '../classes/questions.dart';

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

List<TFQuestion> trueOrFalseQuestions = [
  TFQuestion(
    questionText: "The Earth is flat.",
    answer: false,
  ),
  TFQuestion(
    questionText: "Flutter is a framework for mobile development.",
    answer: true,
  ),
  TFQuestion(
    questionText: "Water boils at 100 degrees Celsius.",
    answer: true,
  ),
];

List<IQuestion> identificationQuestions = [
  IQuestion(
    questionText: "What is the capital of France?",
    answer: "Paris",
  ),
  IQuestion(
    questionText: "In which year did the United States gain independence?",
    answer: "1776",
  ),
  IQuestion(
    questionText: "Who is the author of 'Romeo and Juliet'?",
    answer: "William Shakespeare",
  ),
];

class RandomizerPage extends StatelessWidget {
  const RandomizerPage({super.key});

  void _showAnswer() {}

  @override
  Widget build(BuildContext context) {
    String selectedPage = "tf";
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
                        if (selectedPage == "mc") {
                          return Expanded(
                              child: MultipleChoicePage(
                                  question: easyQuestions[1]));
                        } else if (selectedPage == "tf") {
                          return Expanded(
                              child: TrueOrFalsePage(
                                  question: trueOrFalseQuestions[1]));
                        } else if (selectedPage == "id") {
                          return Expanded(
                              child: IdentificationPage(
                                  question: identificationQuestions[1]));
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
