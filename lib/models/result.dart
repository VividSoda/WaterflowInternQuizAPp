class Result {
  const Result({
    required this.questionIndex,
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
  });

  final int questionIndex;
  final String question;
  final String correctAnswer;
  final String selectedAnswer;
}
