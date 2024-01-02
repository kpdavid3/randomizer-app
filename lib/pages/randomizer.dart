import 'package:flutter/material.dart';
import '../components/countdown.dart';
import '../questionTypes/identification.dart';
import '../questionTypes/multiple_choice.dart';
import '../questionTypes/true_or_false.dart';
import '../classes/questions.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import 'package:randomizer_app/global_data.dart'; // Import GlobalData

class RandomizerPage extends StatefulWidget {
  const RandomizerPage({Key? key}) : super(key: key);

  @override
  _RandomizerPageState createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  late List<Question> randomQuestions;
  int currentPage = 0;
  bool questionState = false;
  String round = "Easy";
  final List<String> difficultyLevels = ["Easy", "Average", "Difficult", "Clincher"];
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

  void advanceDifficulty() {
    if (difficultyIndex < difficultyLevels.length - 1) {
      difficultyIndex++;
      loadQuestionsForDifficulty(difficultyLevels[difficultyIndex]);
    }
  }

  List<Question> getRandomQuestions(List<Question> questions, int count) {
    final random = Random();
    List<Question> selectedQuestions = [];
    count = count.clamp(0, questions.length);

    while (selectedQuestions.length < count) {
      int index = random.nextInt(questions.length);
      Question randomQuestion = questions[index];
      if (!selectedQuestions.contains(randomQuestion)) {
        selectedQuestions.add(randomQuestion);
      }
    }
    return selectedQuestions;
  }

  @override
  Widget build(BuildContext context) {
    if (randomQuestions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text("No questions available. Please load from Excel."),
        ),
      );
    }

    Question currentQuestion = randomQuestions[currentPage];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.red[200],
        child: Center(
          child: Container(
            width: screenWidth * 0.95,
            height: screenHeight * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 28.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$round round',
                                style: GoogleFonts.poppins(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Question ${currentPage + 1} out of 10',
                                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
                              ),
                              Expanded(
                                child: displayQuestion(currentQuestion),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Button(
                                  buttonText: 'Show Answer',
                                  onPressed: () {
                                    setState(() {
                                      questionState = !questionState;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const CountdownApp(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: currentPage > 0
                            ? () {
                                setState(() {
                                  currentPage--;
                                  questionState = false;
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.pink,
                        ),
                        child: const Text(
                          'Prev',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ...List.generate(10, (i) => ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentPage = i;
                              questionState = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: currentPage == i ? Colors.red : Colors.white,
                            foregroundColor: Colors.pink,
                          ),
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: currentPage == i ? Colors.white : Colors.black,
                            ),
                          )),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (currentPage < 9) {
                            setState(() => currentPage++);
                          } else {
                            advanceDifficulty();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.pink,
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
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
    );
  }

  Widget displayQuestion(Question question) {
    switch (question.runtimeType) {
      case MCQuestion:
        return MultipleChoicePage(question: question as MCQuestion, state: questionState);
      case TFQuestion:
        return TrueOrFalsePage(question: question as TFQuestion, state: questionState);
      case IQuestion:
        return IdentificationPage(question: question as IQuestion, state: questionState);
      default:
        return Text('Unknown Question Type');
    }
  }
}
