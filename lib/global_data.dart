import './classes/questions.dart';

class GlobalData {
  static final GlobalData _singleton = GlobalData._internal();

  List<Question>? easyQuestions;
  List<Question>? averageQuestions;
  List<Question>? difficultQuestions;
  List<Question>? clincherQuestions;

  String? questionsFilePath; // Single file path for all difficulties

  factory GlobalData() {
    return _singleton;
  }

  GlobalData._internal();

  void updateQuestions(List<Question> questions, String difficulty) {
    switch (difficulty) {
      case 'Easy':
        easyQuestions = questions;
        break;
      case 'Average':
        averageQuestions = questions;
        break;
      case 'Difficult':
        difficultQuestions = questions;
        break;
      case 'Clincher':
        clincherQuestions = questions;
        break;
    }
  }

  void updateFilePath(String filePath) {
    questionsFilePath = filePath; // Update single file path
  }
}
