import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import '../components/questionCounterBox.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:randomizer_app/classes/questions.dart';
import 'package:randomizer_app/global_data.dart';
import '../components/button.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Map<String, String?> selectedFilePaths = {};

  @override
  void initState() {
    super.initState();
    // Initialize with existing file paths from GlobalData
    var globalData = GlobalData();
    selectedFilePaths = {
      'Easy': globalData.easyQuestionsFilePath,
      'Average': globalData.averageQuestionsFilePath,
      'Difficult': globalData.difficultQuestionsFilePath,
      'Clincher': globalData.clincherQuestionsFilePath,
    };
  }

  Future<void> selectFile(String difficulty) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          selectedFilePaths[difficulty] = filePath;
        });
        await loadQuestionsFromExcel(filePath, difficulty);
      }
    }
  }

  Future<void> loadQuestionsFromExcel(
      String filePath, String difficulty) async {
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
              loadedQuestions.add(MCQuestion(
                  questionText: questionText,
                  choices: choices,
                  answer: answer,
                  type: type));
            } else if (type == 'tf') {
              answer = (row[6]?.value.toString() ?? '').toLowerCase() == 'true';
              loadedQuestions.add(TFQuestion(
                  questionText: questionText, answer: answer, type: type));
            } else if (type == 'id') {
              answer = row[6]?.value.toString() ?? '';
              loadedQuestions.add(IQuestion(
                  questionText: questionText, answer: answer, type: type));
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

  Widget filePickerButton(String label) {
    String buttonText = selectedFilePaths[label] ?? 'Select Spreadsheet';

    if (selectedFilePaths[label] != null) {
      var filePath = selectedFilePaths[label]!;
      var fileName = filePath.split('/').last;
      buttonText = fileName; // Show only file name
    }

    return Expanded(
        child:
            Button(buttonText: buttonText, onPressed: () => selectFile(label)));
  }

  Widget fileSelectionSection(String difficulty) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Select Spreadsheet:',
          style: GoogleFonts.poppins(
            color: Colors.black54,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 10),
        filePickerButton(difficulty),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Edit Page'),
        // ),
        body: Container(
            color: Colors.red[200], // Set red background color
            child: Center(
              child: Container(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.9,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // White background for the rounded rectangle
                    borderRadius:
                        BorderRadius.circular(20), // Set border radius
                  ),
                  child: Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Edit Questions",
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CounterBox(
                                  mcNum: "8",
                                  iNum: "8",
                                  tfNum: "8",
                                  difficulty: "Easy",
                                ),
                                SizedBox(width: 24),
                                CounterBox(
                                  mcNum: "8",
                                  iNum: "8",
                                  tfNum: "8",
                                  difficulty: "Average",
                                ),
                                SizedBox(width: 24),
                                CounterBox(
                                  mcNum: "8",
                                  iNum: "8",
                                  tfNum: "8",
                                  difficulty: "Difficult",
                                ),
                                SizedBox(width: 24),
                                CounterBox(
                                  mcNum: "8",
                                  iNum: "8",
                                  tfNum: "8",
                                  difficulty: "Clincher",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                        child: Row(
                          children: [
                            Button(buttonText: "Back", onPressed: () {}),
                            const Spacer(),
                            Expanded(
                              child: fileSelectionSection('Easy'),
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
            )));
  }
}
