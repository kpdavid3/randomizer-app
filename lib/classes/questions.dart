abstract class Question {
  final String questionText;
  final String type;

  Question({required this.questionText, required this.type});
}

class MCQuestion extends Question {
  final List<String> choices;
  final String answer;

  MCQuestion({
    required String questionText,
    required this.choices,
    required this.answer,
    required String type,
  }) : super(questionText: questionText, type: type);
}

class TFQuestion extends Question {
  final bool answer;

  TFQuestion({
    required String questionText,
    required this.answer,
    required String type,
  }) : super(questionText: questionText, type: type);
}

class IQuestion extends Question {
  final String answer;

  IQuestion({
    required String questionText,
    required this.answer,
    required String type,
  }) : super(questionText: questionText, type: type);
}
