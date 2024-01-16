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

  void _pauseTimer() {
    setState(() {
      _timer.cancel();
      _isRunning = false;
      _secondsLeft = 60;
    });
  }

  void _resetTimer() {
    setState(() {
      _timer.cancel();
      _isRunning = false;
      _secondsLeft = 60;
    });
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
        if (_isRunning == false) {
          if (_secondsLeft != 0 &&
              event.isKeyPressed(LogicalKeyboardKey.enter)) {
            _startTimer();
          }
          if (currentPage != 0 &&
              event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            prevPage();
          }
          if (currentPage != 9 &&
              event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            nextPage();
          }
        }
        if (_isRunning == true &&
            _secondsLeft != 0 &&
            event.isKeyPressed(LogicalKeyboardKey.keyP)) {
          _pauseTimer();
        }
        if (event.isKeyPressed(LogicalKeyboardKey.keyR)) {
          _resetTimer();
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
                        Color(0xFF333333),
                        Colors.yellow,
                        Colors.white,
                        Colors.yellow,
                        Color(0xFF333333),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.85,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/logo2.png', // Update with your actual logo path
                                  height: 500,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4AD52),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: const Color(0xFF333333),
                                      width: 10,
                                    ),
                                  ),
                                  width: 600,
                                  height: 150,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/logo2.png', // Update with your actual logo path
                                  height: 500,
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        CountdownTimer(secondsLeft: _secondsLeft),
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
                                      Row(children: [
                                        const Spacer(),
                                        Text(
                                          "© QRA 2024",
                                          style: GoogleFonts.montserrat(
                                              color: const Color(0xFF333333),
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
