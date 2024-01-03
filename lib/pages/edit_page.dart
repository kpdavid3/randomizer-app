import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';

import 'package:randomizer_app/classes/questions.dart';
import 'package:randomizer_app/global_data.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Map<String, String?> selectedFilePaths = {};

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
    } catch (e) {
      print("Error loading Excel file: $e");
    }
  }

  Widget filePickerButton(String label) {
    String buttonText = 'Select Spreadsheet';
    
    if (selectedFilePaths[label] != null) {
      var filePath = selectedFilePaths[label]!;
      var fileName = filePath.split('/').last; // Extracts the file name
      var folderName = filePath.split('/')..removeLast(); // Extracts the folder path
      buttonText = '${folderName.join('/')}/$fileName'; // Combines folder path and file name
    }

    return ElevatedButton(
      onPressed: () => selectFile(label),
      child: Text(buttonText),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 36), // makes button wide
      ),
    );
  }


  Widget fileSelectionSection(String difficulty) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select $difficulty Questions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              filePickerButton(difficulty),
              SizedBox(height: 10),
              // fileInfoText(selectedFilePaths[difficulty], difficulty),
            ],
          ),
        ),
      );
    }



  // Display Full path
  // Widget fileInfoText(String? filePath, String difficulty) {
  //   return filePath != null
  //       ? Text('Selected file: $filePath')
  //       : Container(); // Returns an empty container if filePath is null
  // }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: Center( // Centering the content
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600), // Set a maximum width
          child: SingleChildScrollView(
            child: Column(
              children: [
                fileSelectionSection('Easy'),
                fileSelectionSection('Average'),
                fileSelectionSection('Difficult'),
                fileSelectionSection('Clincher'),
                // Additional UI elements...
              ],
            ),
          ),
        ),
      ),
    );
  }
}

