import './classes/questions.dart';

class GlobalData {
  static final GlobalData _singleton = GlobalData._internal();

  // Declare the fields you need
  String? selectedFilePath;
  List<Question>? allQuestions;

  // Private constructor
  GlobalData._internal();

  // Factory constructor for singleton instance
  factory GlobalData() {
    return _singleton;
  }

  // Method to update questions
  void updateQuestions(List<Question> questions) {
    allQuestions = questions;
  }
}
