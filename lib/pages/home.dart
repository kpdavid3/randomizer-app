import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:randomizer_app/pages/questionPage.dart';
import 'randomizer.dart';
import '../components/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import '../classes/questions.dart';
import '../global_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String selectedFilePath = "";

  @override
  void initState() {
    super.initState();
    _loadFilePath();
  }

  Future<void> _loadFilePath() async {
    String filePath = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filePath = prefs.getString('questionsFilePath')!;

    if (filePath != "") {
      setState(() {
        selectedFilePath = filePath;
      });
      // Load questions from Excel if file path is available
      await loadQuestionsFromExcel(filePath);
    } else {
      // print("itlog");
      // GlobalData().loadPlaceholderQuestions(); // Call the method on the instance
    }
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          selectedFilePath = filePath;
        });
        await loadQuestionsFromExcel(filePath);
      }
    }
  }

  Future<void> loadQuestionsFromExcel(String filePath) async {
    if (filePath != "") {
      try {
        var bytes = File(filePath).readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        Map<String, List<Question>> questionsByDifficulty = {
          'Easy': [],
          'Average': [],
          'Difficult': [],
          'Clincher': []
        };

        for (var table in excel.tables.keys) {
          String difficulty =
              table; // Assuming the table name represents the difficulty
          List<Question> loadedQuestions =
              questionsByDifficulty[difficulty] ?? [];

          for (var row in excel.tables[table]!.rows) {
            if (row[0]?.value != null && row[0]?.value != 'Type of Question') {
              String type = row[0]?.value.toString() ?? '';
              String questionText = row[1]?.value.toString() ?? '';
              dynamic answer;
              String explanation = row[7]?.value.toString() ?? '';

              if (type == 'mc') {
                answer = row[6]?.value.toString() ?? '';
                List<String> choices = [
                  row[2]?.value.toString() ?? '',
                  row[3]?.value.toString() ?? '',
                  row[4]?.value.toString() ?? '',
                  row[5]?.value.toString() ?? ''
                ];
                loadedQuestions.add(MCQuestion(
                    questionText: questionText,
                    choices: choices,
                    answer: answer,
                    type: type,
                    explanation: explanation));
              } else if (type == 'tf') {
                answer =
                    (row[6]?.value.toString() ?? '').toLowerCase() == 'true';
                loadedQuestions.add(TFQuestion(
                    questionText: questionText,
                    answer: answer,
                    type: type,
                    explanation: explanation));
              } else if (type == 'id') {
                answer = row[6]?.value.toString() ?? '';
                loadedQuestions.add(IQuestion(
                    questionText: questionText,
                    answer: answer,
                    type: type,
                    explanation: explanation));
              }
            }
          }

          questionsByDifficulty[difficulty] = loadedQuestions;

          // Debug: Print total questions loaded for each difficulty
          print(
              '$difficulty - Total Questions Loaded: ${loadedQuestions.length}');
        }

        // Update GlobalData with questions for each difficulty
        GlobalData().easyQuestions = questionsByDifficulty['easy'];
        GlobalData().averageQuestions = questionsByDifficulty['average'];
        GlobalData().difficultQuestions = questionsByDifficulty['difficult'];
        GlobalData().clincherQuestions = questionsByDifficulty['clincher'];

        // Print the correct answer of the first question of each difficulty from GlobalData
        printFirstQuestionAnswer('easy', GlobalData().easyQuestions);
        printFirstQuestionAnswer('average', GlobalData().averageQuestions);
        printFirstQuestionAnswer('difficult', GlobalData().difficultQuestions);
        printFirstQuestionAnswer('clincher', GlobalData().clincherQuestions);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('questionsFilePath', filePath);
      } catch (e) {
        print("Error loading Excel file: $e");
      }
    } else {
      // IF FILE PATH IS "", THEN THERE IS NO EXCEL FILE SELECTED

      GlobalData().easyQuestions = P_easyQuestions;
      GlobalData().averageQuestions = P_averageQuestions;
      GlobalData().difficultQuestions = P_difficultQuestions;
      GlobalData().clincherQuestions = P_clincherQuestions;
    }
  }

  // FOR DEBUGGING ONLY
  void printFirstQuestionAnswer(String difficulty, List<Question>? questions) {
    if (questions != null && questions.isNotEmpty) {
      var firstQuestion = questions.first;
      var answerText = firstQuestion is MCQuestion
          ? firstQuestion.answer
          : firstQuestion is TFQuestion
              ? (firstQuestion.answer ? 'True' : 'False')
              : firstQuestion is IQuestion
                  ? firstQuestion.answer
                  : 'Unknown';
      var explanation = firstQuestion.explanation;

      print('$difficulty - First Question: ${firstQuestion.questionText}');
      print('$difficulty - Answer: $answerText');
      print('$difficulty - Explanation: $explanation');
    } else {
      print('$difficulty - No questions available.');
    }
  }

  // Method to clear the selected file
  void clearSelectedFile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('questionsFilePath'); // Clear the saved file path
    setState(() {
      selectedFilePath = "";
      // Optionally, clear the loaded questions from GlobalData
      GlobalData().easyQuestions = null;
      GlobalData().averageQuestions = null;
      GlobalData().difficultQuestions = null;
      GlobalData().clincherQuestions = null;
    });
  }

  String getButtonText() {
    if (selectedFilePath != "") {
      var filePathComponents = selectedFilePath!
          .split(Platform.pathSeparator); // Split by path separator
      var fileName = filePathComponents
          .last; // Get the last component, which is the file name
      return fileName; // Show only file name
    }
    return "Select Questions";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String buttonText;
    if (selectedFilePath != null) {
      var fileName = selectedFilePath!.split('/').last;
      buttonText = fileName; // Show only file name
    } else {
      buttonText = "Select Questions";
    }

    return Scaffold(
      body: Container(
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
        child: Center(
          child: Container(
            width: screenWidth * 0.95,
            height: screenHeight * 0.9,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo2.png', // Update with your actual logo path
                  height: 200,
                ),
                Text(
                  'National Science Quiz Contest',
                  style: GoogleFonts.montserrat(
                    fontSize: 48,
                    color: const Color(0xFFD4AD52),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        color: Colors.grey,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Quiz Randomizer',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment
                      .center, // Align the stack's children to the center
                  children: [
                    Button(
                      buttonText: getButtonText(),
                      onPressed: selectFile,
                    ),
                    if (selectedFilePath != "")
                      Positioned(
                        left:
                            0, // Position the 'X' button to the left of the 'Select File' button
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white54),
                          onPressed: clearSelectedFile,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Button(
                  buttonText: 'Start Quiz',
                  onPressed: () {
                    // if(filePath != null){
                    loadQuestionsFromExcel(selectedFilePath!);
                    // }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuestionPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
