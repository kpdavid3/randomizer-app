import './classes/questions.dart';

class GlobalData {
  static final GlobalData _singleton = GlobalData._internal();

  List<Question>? easyQuestions;
  List<Question>? averageQuestions;
  List<Question>? difficultQuestions;
  List<Question>? clincherQuestions;

  String? easyQuestionsFilePath;
  String? averageQuestionsFilePath;
  String? difficultQuestionsFilePath;
  String? clincherQuestionsFilePath;

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

  void updateFilePath(String filePath, String difficulty) {
    switch (difficulty) {
      case 'Easy':
        easyQuestionsFilePath = filePath;
        break;
      case 'Average':
        averageQuestionsFilePath = filePath;
        break;
      case 'Difficult':
        difficultQuestionsFilePath = filePath;
        break;
      case 'Clincher':
        clincherQuestionsFilePath = filePath;
        break;
    }
  }
}
