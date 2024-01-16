abstract class Question {
  final String questionText;
  final String type;
  final String explanation;

  Question(
      {required this.questionText,
      required this.type,
      required this.explanation});
}

class MCQuestion extends Question {
  final List<String> choices;
  final String answer;

  MCQuestion({
    required super.questionText,
    required this.choices,
    required this.answer,
    required super.type,
    required super.explanation,
  });
}

class TFQuestion extends Question {
  final bool answer;

  TFQuestion({
    required super.questionText,
    required this.answer,
    required super.type,
    required super.explanation,
  });
}

class IQuestion extends Question {
  final String answer;

  IQuestion({
    required super.questionText,
    required this.answer,
    required super.type,
    required super.explanation,
  });
}
