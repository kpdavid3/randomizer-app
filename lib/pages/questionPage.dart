import 'dart:async';

import 'package:flutter/material.dart';
import 'package:randomizer_app/components/answerSection.dart';
import 'package:randomizer_app/components/questionSection.dart';
import 'package:randomizer_app/global_data.dart';
import '../components/countdown.dart';
import '../classes/questions.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

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
  final List<String> difficultyLevels = [
    "Easy",
    "Average",
    "Difficult",
    "Clincher"
  ];
  int difficultyIndex = 0;

  @override
  void initState() {
    super.initState();
    loadQuestionsForDifficulty(round);
  }

  void loadQuestionsForDifficulty(String difficulty) {
    List<Question>? questions;
    switch (difficulty) {
      case "Easy":
        questions = GlobalData().easyQuestions;
        break;
      case "Average":
        questions = GlobalData().averageQuestions;
        break;
      case "Difficult":
        questions = GlobalData().difficultQuestions;
        break;
      case "Clincher":
        questions = GlobalData().clincherQuestions;
        break;
    }
    setState(() {
      randomQuestions = getRandomQuestions(questions ?? [], 10);
      currentPage = 0;
      round = difficulty;
    });
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
      _secondsLeft = 60;
      questionState = false;
    });
  }

  void prevPage() {
    setState(() {
      currentPage--;
      _secondsLeft = 60;
      questionState = false;
    });
  }

  void setAnswer() {
    setState(() {
      questionState = !questionState;
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedPage = randomQuestions[currentPage].type;

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
          if (event.isKeyPressed(LogicalKeyboardKey.keyA)) {
            setAnswer();
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
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.9,
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.85,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        if (!questionState)
                          Expanded(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/logo2.png', // Update with your actual logo path
                                  height: 300,
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
                                  height: 80,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        selectedPage == "mc"
                                            ? "MULTIPLE CHOICE"
                                            : selectedPage == "id"
                                                ? "IDENTIFICATION"
                                                : selectedPage == "tf"
                                                    ? "TRUE OR FALSE"
                                                    : "",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/logo1.png', // Update with your actual logo path
                                  height: 300,
                                ),
                              ],
                            ),
                          ),
                        if (!questionState)
                          CountdownTimer(secondsLeft: _secondsLeft),
                        !questionState
                            ? QuizPage(
                                remainingSeconds: _secondsLeft,
                                selectedPage: selectedPage,
                                currentPage: currentPage,
                                randomQuestions: randomQuestions,
                                questionState: questionState,
                              )
                            : AnswerPage(
                                randomQuestions: randomQuestions,
                                currentPage: currentPage,
                                selectedPage: selectedPage)
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
