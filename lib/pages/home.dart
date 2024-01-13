import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'randomizer.dart';
import '../components/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import '../classes/questions.dart';
import '../global_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String? selectedFilePath;

  @override
  void initState() {
    super.initState();
    // Initialize with existing file paths from GlobalData
    _loadFilePath();
  }

  Future<void> _loadFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? filePath = prefs.getString('questionsFilePath');

    if (filePath != null) {
      print("ANG FILE PATH AY: ${filePath}");
      setState(() {
        selectedFilePath = filePath;
      });
      // Load questions from Excel if file path is available
      await loadQuestionsFromExcel(filePath);
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
      String difficulty = table; // Assuming the table name represents the difficulty
      List<Question> loadedQuestions = questionsByDifficulty[difficulty] ?? [];

      for (var row in excel.tables[table]!.rows) {
        if (row[0]?.value != null && row[0]?.value != 'Type of Question') {
          String type = row[0]?.value.toString() ?? '';
          String questionText = row[1]?.value.toString() ?? '';
          dynamic answer;

          if (type == 'mc') {
            answer = row[6]?.value.toString() ?? '';
            List<String> choices = [
              row[2]?.value.toString() ?? '',
              row[3]?.value.toString() ?? '',
              row[4]?.value.toString() ?? '',
              row[5]?.value.toString() ?? ''
            ];
            loadedQuestions.add(MCQuestion(questionText: questionText, choices: choices, answer: answer, type: type));
          } else if (type == 'tf') {
            answer = (row[6]?.value.toString() ?? '').toLowerCase() == 'true';
            loadedQuestions.add(TFQuestion(questionText: questionText, answer: answer, type: type));
          } else if (type == 'id') {
            answer = row[6]?.value.toString() ?? '';
            loadedQuestions.add(IQuestion(questionText: questionText, answer: answer, type: type));
          }
        }
      }

      questionsByDifficulty[difficulty] = loadedQuestions;

      // Debug: Print total questions loaded for each difficulty
      print('$difficulty - Total Questions Loaded: ${loadedQuestions.length}');
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
}

// FOR DEBUGGING ONLY
void printFirstQuestionAnswer(String difficulty, List<Question>? questions) {
  if (questions != null && questions.isNotEmpty) {
    var firstQuestion = questions.first;
    var answer = firstQuestion is MCQuestion ? firstQuestion.answer :
                 firstQuestion is TFQuestion ? (firstQuestion.answer ? 'True' : 'False') :
                 firstQuestion is IQuestion ? firstQuestion.answer : 'Unknown';
    print('$difficulty - First Question Answer: ${firstQuestion.questionText}, Answer: $answer');
  } else {
    print('$difficulty - No questions available.');
  }
}



  String getButtonText() {
    if (selectedFilePath != null) {
      var fileName = selectedFilePath!.split('/').last;
      return fileName; // Show only file name
    }
    return "Select Questions";
  }



  // Widget fileSelectionSection(String difficulty) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       // Text(
  //       //   'Select Spreadsheet:',
  //       //   style: GoogleFonts.poppins(
  //       //     color: Colors.black54,
  //       //     fontSize: 18,
  //       //   ),
  //       // ),
  //       const SizedBox(width: 10),
  //       filePickerButton(difficulty),
  //     ],
  //   );
  // }

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo2.png', // Update with your actual logo path
                  height: 200,
                ),
                Text(
                  'National Science Quiz Contest',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Quiz Randomizer',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  buttonText: getButtonText(),
                  onPressed: selectFile,
                ),
                const SizedBox(height: 20),
                Button(
                  buttonText: 'Start Quiz',
                  onPressed: () {
                    loadQuestionsFromExcel(selectedFilePath!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RandomizerPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // TextButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text(
                //     'Back',
                //     style: GoogleFonts.poppins(
                //       fontSize: 12,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                Spacer(),
                // Container(
                //   padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: fileSelectionSection('Easy'),
                //       ),
                //       Expanded(
                //         child: fileSelectionSection('Average'),
                //       ),
                //       Expanded(
                //         child: fileSelectionSection('Difficult'),
                //       ),
                //       Expanded(
                //         child: fileSelectionSection('Clincher'),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
