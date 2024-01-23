import 'dart:async';

import 'package:flutter/material.dart';
import 'package:randomizer_app/components/answerSection.dart';
import 'package:randomizer_app/components/questionSection.dart';
import 'package:randomizer_app/global_data.dart';
import '../components/defaultSection.dart';
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

  bool fadingOut = false;
  String transitionText = '';

  bool isModalDisplayed = false;

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

    initiateTransition();
  }

  void initiateTransition() {
    setState(() {
      fadingOut = true;
      transitionText = "Easy Round"; // Example: "Easy"
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        fadingOut = false;
      });
    });
  }

  void advanceDifficulty() async {
    // Check if the next level is Clincher
    if (difficultyIndex == difficultyLevels.length - 2) {
      bool proceed = await showClincherConfirmationDialog();
      if (!proceed) return; // Do not proceed if user chooses not to
    }

    if (difficultyIndex < difficultyLevels.length - 1) {
      // Start fade out
      setState(() {
        fadingOut = true;
        // Reset the transitionText so it's empty during the fade-out
        transitionText = '';
      });

      // Wait for the fade-out animation to complete
      await Future.delayed(Duration(seconds: 1));

      // Increment the difficulty and load new questions
      difficultyIndex++;
      loadQuestionsForDifficulty(difficultyLevels[difficultyIndex]);

      // Set the transition text for the new difficulty
      setState(() {
        transitionText = "${difficultyLevels[difficultyIndex]} Round";
        ;
      });

      // Wait a bit before fading back in
      await Future.delayed(Duration(seconds: 2)); // Delay before fade-in

      // Reset the fade-out flag for fade in
      setState(() {
        fadingOut = false;
      });

      //Wait for the fade-in animation to complete
      await Future.delayed(Duration(seconds: 3));

      // Reset the transition text after it has been displayed
      // This is a band-aid solution to hide text temporarily during fade in
      setState(() {
        transitionText = '';
      });
    }
  }

  void decreaseDifficulty() async {
    if (difficultyIndex > 0) {
      bool proceed = await showDecreaseDifficultyConfirmationDialog();
      if (!proceed) return; // Do not proceed if user chooses not to

      setState(() {
        fadingOut = true;
        transitionText = ''; // Reset during fade-out
      });

      await Future.delayed(Duration(seconds: 1));

      difficultyIndex--;
      loadQuestionsForDifficulty(difficultyLevels[difficultyIndex]);

      setState(() {
        transitionText = "${difficultyLevels[difficultyIndex]} Round";
        ;
      });

      await Future.delayed(Duration(seconds: 2));

      setState(() {
        fadingOut = false;
      });

      await Future.delayed(Duration(seconds: 3));

      setState(() {
        transitionText = '';
      });
    }
  }

  Future<bool> showDecreaseDifficultyConfirmationDialog() async {
    if (isModalDisplayed) return false;

    isModalDisplayed = true;

    bool result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Return to Previous Round?"),
              // content: Text("Are you sure you want to return to the previous round?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop(false); // Return false
                  },
                ),
                TextButton(
                  child: Text("Return"),
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true
                  },
                ),
              ],
            );
          },
        ) ??
        false; // In case the dialog is dismissed, return false

    isModalDisplayed = false;
    return result;
  }

  Future<bool> showClincherConfirmationDialog() async {
    if (isModalDisplayed) return false;

    isModalDisplayed = true;
    bool result = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Proceed to Clincher Round?"),
              // content: Text(
              //     "Proceed to the Clincher round?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop(false); // Return false
                  },
                ),
                TextButton(
                  child: Text("Proceed"),
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true
                  },
                ),
              ],
            );
          },
        ) ??
        false; // In case the dialog is dismissed, return false

    isModalDisplayed = false;
    return result;
  }

  void loadQuestionsForDifficulty(String difficulty) {
    List<Question>? questions;
    switch (difficulty) {
    case "Easy":
      questions = GlobalData().easyQuestions;
      _secondsLeft = 10;
      break;
    case "Average":
      questions = GlobalData().averageQuestions;
      _secondsLeft = 20;
      break;
    case "Difficult":
    case "Clincher":
      questions = GlobalData().difficultQuestions;
      _secondsLeft = 30;
      break;
    default:
      questions = []; 
      _secondsLeft = 30;
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
  int timerDuration;
  switch (difficultyLevels[difficultyIndex]) {
    case "Easy":
      timerDuration = 10;
      break;
    case "Average":
      timerDuration = 20;
      break;
    case "Difficult":
    case "Clincher":
      timerDuration = 30;
      break;
    default:
      timerDuration = 30;
  }

  setState(() {
    _secondsLeft = timerDuration;
  });

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
      
      switch (difficultyLevels[difficultyIndex]) {
        case "Easy":
          _secondsLeft = 10;
          break;
        case "Average":
          _secondsLeft = 20;
          break;
        case "Difficult":
        case "Clincher":
          _secondsLeft = 30;
          break;
        default:
          _secondsLeft = 30;
      }
    });
  }

  void setTimerForCurrentDifficulty() {
  switch (difficultyLevels[difficultyIndex]) {
    case "Easy":
      _secondsLeft = 10;
      break;
    case "Average":
      _secondsLeft = 20;
      break;
    case "Difficult":
    case "Clincher":
      _secondsLeft = 30;
      break;
    default:
      _secondsLeft = 30;
  }
  _isRunning = false;
}


  void nextPage() {
    setState(() {
      // Don't do anything if transitioning
      if (!fadingOut) {
        if (currentPage < 9) {
          currentPage++;
          setTimerForCurrentDifficulty();
          questionState = false;
        } else {
          advanceDifficulty();
        }
      }
    });
  }

  void prevPage() {
    setState(() {
      if (!fadingOut) {
        if (currentPage > 0) {
          currentPage--;
          setTimerForCurrentDifficulty();
          questionState = false;
        } else if (difficultyIndex > 0) {
          decreaseDifficulty();
        }
      }
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
            if (currentPage >= 0 &&
                event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              prevPage();
            }
            if (currentPage < 10 &&
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
              // The main content with fade transition
              AnimatedOpacity(
                opacity: fadingOut ? 0.0 : 1.0,
                duration: const Duration(seconds: 1),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      'assets/logo2.png', // Update with your actual logo path
                                      height: 300,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD4AD52),
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    selectedPage: selectedPage),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Transition text
              if (fadingOut)
                AnimatedOpacity(
                  opacity: fadingOut ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        transitionText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFFD4AD52),
                          fontSize: 128,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            const Shadow(
                              color: Colors.grey,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
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
