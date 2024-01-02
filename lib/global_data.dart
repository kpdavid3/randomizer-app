import './classes/questions.dart';

class GlobalData {
  static final GlobalData _singleton = GlobalData._internal();

  // Declare fields for each difficulty level
  List<Question>? easyQuestions;
  List<Question>? averageQuestions;
  List<Question>? difficultQuestions;
  List<Question>? clincherQuestions;

  GlobalData._internal();

  factory GlobalData() {
    return _singleton;
  }

  // Method to update questions based on difficulty
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
}
