import 'dart:async';

import 'package:flutter/material.dart';
import '../components/countdown.dart';
import '../questionTypes/identification.dart';
import '../questionTypes/multiple_choice.dart';
import '../questionTypes/true_or_false.dart';
import '../classes/questions.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import 'package:flutter/services.dart';

List<Question> allQuestions = [
  MCQuestion(
      questionText: "What is the largest mammal in the world?",
      choices: ["Elephant", "Blue Whale", "Giraffe", "Rhino"],
      answer: "Blue Whale",
      type: 'mc'),
  MCQuestion(
      questionText: "What do bees collect and use to create honey?",
      choices: ["Pollen", "Dust", "Leaves", "Bark"],
      answer: "Pollen",
      type: 'mc'),
  MCQuestion(
      questionText: "Which animal is known for its ability to change color?",
      choices: ["Chameleon", "Octopus", "Polar Bear", "Tiger"],
      answer: "Chameleon",
      type: 'mc'),
  TFQuestion(questionText: "The Earth is flat.", answer: false, type: 'tf'),
  TFQuestion(
      questionText: "Flutter is a framework for mobile development.",
      answer: true,
      type: 'tf'),
  TFQuestion(
      questionText: "Water boils at 100 degrees Celsius.",
      answer: true,
      type: 'tf'),
  IQuestion(
      questionText: "What is the capital of France?",
      answer: "Paris",
      type: 'id'),
  IQuestion(
      questionText: "What is the capital of France?",
      answer: "Paris",
      type: 'id'),
  IQuestion(
      questionText: "In which year did the United States gain independence?",
      answer: "1776",
      type: 'id'),
  IQuestion(
      questionText: "Who is the author of 'Romeo and Juliet'?",
      answer: "William Shakespeare",
      type: 'id'),
  MCQuestion(
    questionText: "What is the capital of Japan?",
    choices: ["Seoul", "Beijing", "Tokyo", "Bangkok"],
    answer: "Tokyo",
    type: 'mc',
  ),
  MCQuestion(
    questionText: "Which planet is known as the Red Planet?",
    choices: ["Venus", "Mars", "Jupiter", "Saturn"],
    answer: "Mars",
    type: 'mc',
  ),
  MCQuestion(
    questionText: "Who wrote the play 'Hamlet'?",
    choices: [
      "Charles Dickens",
      "Jane Austen",
      "William Shakespeare",
      "Mark Twain"
    ],
    answer: "William Shakespeare",
    type: 'mc',
  ),
  TFQuestion(
    questionText: "The Great Wall of China is visible from space.",
    answer: false,
    type: 'tf',
  ),
  TFQuestion(
    questionText: "The Amazon River is the longest river in the world.",
    answer: true,
    type: 'tf',
  ),
  TFQuestion(
    questionText: "Bananas are berries.",
    answer: true,
    type: 'tf',
  ),
  IQuestion(
    questionText: "What is the largest ocean on Earth?",
    answer: "Pacific Ocean",
    type: 'id',
  ),
  IQuestion(
    questionText: "What is the currency of Brazil?",
    answer: "Brazilian Real",
    type: 'id',
  ),
  IQuestion(
    questionText: "Who painted the Mona Lisa?",
    answer: "Leonardo da Vinci",
    type: 'id',
  ),
  IQuestion(
    questionText: "What is the main ingredient in guacamole?",
    answer: "Avocado",
    type: 'id',
  ),
];

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RandomizerPageState createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<QuestionPage> {
  late List<Question> randomQuestions;
  int currentPage = 0;
  bool questionState = false;
  String round = "Easy";

  @override
  void initState() {
    super.initState();
    randomQuestions = getRandomQuestions(allQuestions, 10);
  }

  late Timer _timer;
  int _secondsLeft = 60;
  bool _isRunning = false;

  void _updateTimer(Timer timer) {
    if (_secondsLeft > 0 && _isRunning) {
      setState(() {
        _secondsLeft--;
      });
    } else {
      _timer.cancel();
      _isRunning = false;
    }
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void nextPage() {
    setState(() {
      currentPage++;
    });
  }

  void prevPage() {
    setState(() {
      currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedPage = randomQuestions[currentPage].type;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (currentPage != 0 &&
            event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          print("left");
          prevPage();
        }
        if (currentPage != 9 &&
            event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          print("right");
          nextPage();
        }
        if (_secondsLeft != 0 && event.isKeyPressed(LogicalKeyboardKey.enter)) {
          _startTimer();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/background.png'), // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                width: screenWidth * 0.95,
                height: screenHeight * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.yellow,
                        Color(0xffad9c00),
                        Colors.yellow,
                        Colors.white,
                        Colors.yellow,
                        Color(0xffad9c00),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.85,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            'assets/background.png'), // Replace with your image asset
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Logo Left"),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(() {
                                        switch (selectedPage) {
                                          case "mc":
                                            return "MULTIPLE CHOICE";
                                          case "id":
                                            return "IDENTIFICATION";
                                          case "tf":
                                            return "TRUE OR FALSE";
                                          default:
                                            return "";
                                        }
                                      }(),
                                          style: const TextStyle(fontSize: 36)),
                                      CountdownTimer(secondsLeft: _secondsLeft)
                                    ],
                                  ),
                                ),
                                Text("Logo Left"),
                              ],
                            )),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0, horizontal: 28.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   '$round round',
                                      //   style: GoogleFonts.poppins(
                                      //     fontSize: 24,
                                      //     color: Colors.red,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 5),
                                      // Text(
                                      //   'Question ${currentPage + 1} out of 10',
                                      //   style: GoogleFonts.poppins(
                                      //     fontSize: 14,
                                      //     color: Colors.black54,
                                      //   ),
                                      // ),
                                      (() {
                                        if (selectedPage == "mc") {
                                          return Expanded(
                                              flex: 2,
                                              child: MultipleChoicePage(
                                                  question: randomQuestions[
                                                          currentPage]
                                                      as MCQuestion,
                                                  state: questionState));
                                        } else if (selectedPage == "tf") {
                                          return Expanded(
                                              flex: 2,
                                              child: TrueOrFalsePage(
                                                  question: randomQuestions[
                                                          currentPage]
                                                      as TFQuestion,
                                                  state: questionState));
                                        } else if (selectedPage == "id") {
                                          return Expanded(
                                              flex: 2,
                                              child: IdentificationPage(
                                                  question: randomQuestions[
                                                      currentPage] as IQuestion,
                                                  state: questionState));
                                        } else {
                                          return Container();
                                        }
                                      })(),
                                    ],
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: Colors.transparent,
                              //         borderRadius: BorderRadius.circular(20)),
                              //     child:
                              //         CountdownTimer(secondsLeft: _secondsLeft),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        // Container(
                        //   height: 100.0,
                        //   decoration: BoxDecoration(
                        //     color: Colors.transparent,
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       ElevatedButton(
                        //         onPressed: currentPage > 0
                        //             ? () {
                        //                 setState(() {
                        //                   currentPage--;
                        //                   questionState = false;
                        //                 });
                        //               }
                        //             : null,
                        //         style: ElevatedButton.styleFrom(
                        //           foregroundColor: Colors.pink,
                        //         ),
                        //         child: const Text(
                        //           'Prev',
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       ),
                        //       const SizedBox(width: 10),
                        //       for (int i = 0; i < 10; i++)
                        //         Row(
                        //           children: [
                        //             ElevatedButton(
                        //               onPressed: () {
                        //                 setState(() {
                        //                   currentPage = i;
                        //                   questionState = false;
                        //                 });
                        //               },
                        //               style: ElevatedButton.styleFrom(
                        //                 backgroundColor: currentPage == i
                        //                     ? Colors.red
                        //                     : Colors.white,
                        //                 foregroundColor: Colors.pink,
                        //               ),
                        //               child: Text(
                        //                 '${i + 1}',
                        //                 style: TextStyle(
                        //                   color: currentPage == i
                        //                       ? Colors.white
                        //                       : Colors.black,
                        //                 ),
                        //               ),
                        //             ),
                        //             const SizedBox(width: 10),
                        //           ],
                        //         ),
                        //       ElevatedButton(
                        //         onPressed: currentPage < 9
                        //             ? () {
                        //                 setState(() {
                        //                   currentPage++;
                        //                   questionState = false;
                        //                 });
                        //               }
                        //             : null,
                        //         style: ElevatedButton.styleFrom(
                        //           foregroundColor: Colors.pink,
                        //         ),
                        //         child: const Text(
                        //           'Next',
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

List<Question> getRandomQuestions(List<Question> questions, int count) {
  final random = Random();
  List<Question> selectedQuestions = [];

  // Ensure that the count is not greater than the total number of questions
  count = count.clamp(0, questions.length);

  while (selectedQuestions.length < count) {
    int index = random.nextInt(questions.length);
    Question randomQuestion = questions[index];

    // Check if the question is not already in the selected list
    if (!selectedQuestions.contains(randomQuestion)) {
      selectedQuestions.add(randomQuestion);
    }
  }

  return selectedQuestions;
}
