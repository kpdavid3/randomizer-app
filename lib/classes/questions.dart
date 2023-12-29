class MCQuestion {
  final String questionText;
  final List<String> choices;
  final String answer;

  MCQuestion({
    required this.questionText,
    required this.choices,
    required this.answer,
  });
}

class TFQuestion {
  final String questionText;
  final bool answer;

  TFQuestion({
    required this.questionText,
    required this.answer,
  });
}

class IQuestion {
  final String questionText;
  final String answer;

  IQuestion({
    required this.questionText,
    required this.answer,
  });
}
