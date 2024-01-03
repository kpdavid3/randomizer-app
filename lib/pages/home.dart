import 'package:flutter/material.dart';
import 'edit_page.dart';
import 'randomizer.dart';
import '../components/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import '../classes/questions.dart';
import '../global_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    loadDefaultQuestions();
  }

  void loadDefaultQuestions() async {
    Map<String, String> fileNames = {
      'Easy': 'easy_questions.xlsx',
      'Average': 'average_questions.xlsx',
      'Difficult': 'difficult_questions.xlsx',
      'Clincher': 'clincher_questions.xlsx',
    };

    String currentDirectory = Directory.current.path;

    for (var entry in fileNames.entries) {
      String filePath = '$currentDirectory/${entry.value}';

      if (File(filePath).existsSync()) {
        await loadQuestionsFromExcel(filePath, entry.key);
      } else {
        print("${entry.value} not found in the current directory");
      }
    }
  }

  Future<void> loadQuestionsFromExcel(String filePath, String difficulty) async {
    try {
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      List<Question> loadedQuestions = [];

      for (var table in excel.tables.keys) {
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
      }

      GlobalData().updateQuestions(loadedQuestions, difficulty);
      GlobalData().updateFilePath(filePath, difficulty); // Update file path
    } catch (e) {
      print("Error loading Excel file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Update with your actual logo path
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
                  buttonText: 'Edit Questions',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Button(
                  buttonText: 'Start Quiz',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RandomizerPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                    ),
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
