import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';

import 'package:randomizer_app/classes/questions.dart';
import 'package:randomizer_app/global_data.dart'; // Import GlobalData

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String? selectedFilePath;

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
        GlobalData().selectedFilePath = filePath;
        
        await loadQuestionsFromExcel(filePath);
      }
    }
  }

  Future<void> loadQuestionsFromExcel(String filePath) async {
    try {
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      List<Question> loadedQuestions = [];

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          if (row[0]?.value != null && row[0]?.value != 'Type of Question') {
            String type = row[0]?.value.toString() ?? ''; // Safely access the string value
            String questionText = row[1]?.value.toString() ?? '';
            dynamic answer;
            // Answers are located at row 6
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

      GlobalData().allQuestions = loadedQuestions;
    } catch (e) {
      print("Error loading Excel file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: selectFile,
              child: const Text('Select Excel File'),
            ),
            if (selectedFilePath != null) Text('Selected file: $selectedFilePath'),
            // Additional UI elements...
          ],
        ),
      ),
    );
  }
}
