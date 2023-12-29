import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/randomizer.dart';

// import 'dart:async';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LockScreenPage(),
    );
  }
}

class LockScreenPage extends StatelessWidget {
  const LockScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    const String correctPassword = '123'; // Set password

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Quiz Randomizer',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 100,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10), // Adjust padding
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (passwordController.text == correctPassword) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RandomizerPage()),
                      );
                    } else {
                      // Show an error message or handle incorrect password
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Incorrect Password'),
                            content: const Text(
                                'Please enter the correct password.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Go to Second Page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class Question {
//   final String questionText;
//   final List<String> choices;
//   final String answer;

//   Question({
//     required this.questionText,
//     required this.choices,
//     required this.answer,
//   });
// }

// List<Question> easyQuestions = [
//   Question(
//     questionText: "What is the largest mammal in the world?",
//     choices: ["Elephant", "Blue Whale", "Giraffe", "Rhino"],
//     answer: "Blue Whale",
//   ),
//   Question(
//     questionText: "What do bees collect and use to create honey?",
//     choices: ["Pollen", "Dust", "Leaves", "Bark"],
//     answer: "Pollen",
//   ),
//   Question(
//     questionText: "Which animal is known for its ability to change color?",
//     choices: ["Chameleon", "Octopus", "Polar Bear", "Tiger"],
//     answer: "Chameleon",
//   ),
// ];

// List<Question> averageQuestions = [
//   Question(
//     questionText: "Which bird is known for its impressive mimicry of sounds?",
//     choices: ["Parrot", "Eagle", "Lyrebird", "Sparrow"],
//     answer: "Lyrebird",
//   ),
//   Question(
//     questionText: "What is the primary diet of a carnivorous animal?",
//     choices: ["Plants", "Fruits", "Meat", "Seeds"],
//     answer: "Meat",
//   ),
//   Question(
//     questionText: "Which animal has a pouch for carrying its babies?",
//     choices: ["Kangaroo", "Elephant", "Lion", "Penguin"],
//     answer: "Kangaroo",
//   ),
// ];

// List<Question> difficultQuestions = [
//   Question(
//     questionText: "What is the process called where birds migrate at night?",
//     choices: ["Nocturnal migration", "Diurnal migration", "Transmigration", "Intermigration"],
//     answer: "Nocturnal migration",
//   ),
//   Question(
//     questionText: "Which animal has the longest gestation period?",
//     choices: ["Elephant", "Whale", "Rhinoceros", "Giraffe"],
//     answer: "Elephant",
//   ),
//   Question(
//     questionText: "What is a group of lions called?",
//     choices: ["Pack", "Herd", "Pride", "School"],
//     answer: "Pride",
//   ),
// ];

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: QuizPage(),
//     );
//   }
// }

// class QuizPage extends StatefulWidget {
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   late List<Question> allQuestions;
//   late Question currentQuestion;
//   Timer? timer;
//   double timerProgress = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     easyQuestions.shuffle();
//     averageQuestions.shuffle();
//     difficultQuestions.shuffle();
//     allQuestions = []..addAll(easyQuestions)..addAll(averageQuestions)..addAll(difficultQuestions);
//     currentQuestion = allQuestions.removeAt(0);
//     startTimer();
//   }

//   void startTimer() {
//     timerProgress = 1.0;
//     timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) {
//       setState(() {
//         timerProgress -= 0.01;
//         if (timerProgress <= 0) {
//           t.cancel();
//           if (allQuestions.isNotEmpty) {
//             currentQuestion = allQuestions.removeAt(0);
//             startTimer();
//           } else {
//             // Quiz finished
//             // Implement what happens when the quiz is finished
//           }
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(20.0),
//         color: Colors.green[50],
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             LinearProgressIndicator(
//               value: timerProgress,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
//             ),
//             SizedBox(height: 20), // Space between progress bar and question
//             Expanded(
//               flex: 2,
//               child: Center(
//                 child: FittedBox(
//                   fit: BoxFit.fitWidth,
//                   child: Text(
//                     currentQuestion.questionText,
//                     style: TextStyle(
//                       fontSize: 48.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green[800],
//                     ),
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Expanded(child: buildChoiceBox(currentQuestion.choices[0])),
//                         Expanded(child: buildChoiceBox(currentQuestion.choices[1])),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Expanded(child: buildChoiceBox(currentQuestion.choices[2])),
//                         Expanded(child: buildChoiceBox(currentQuestion.choices[3])),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget buildChoiceBox(String text) {
//     return Container(
//       margin: EdgeInsets.all(8.0),
//       padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 36.0,
//             fontWeight: FontWeight.w500,
//             color: Colors.green[800],
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
