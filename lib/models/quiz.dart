class Quiz {
  const Quiz({
    required this.question,
    required this.answerOptions,
    required this.correctAnswer,
    required this.id,
  });

  final String question;
  final List<String> answerOptions;
  final String correctAnswer;
  final String id;
}
