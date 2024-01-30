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

  // List<String> get shuffledOptions {
  //   final List<String> shuffledList = List.of(answerOptions);
  //   shuffledList.shuffle();
  //   return shuffledList;
  // }
  void shuffleOptions() {
    answerOptions.shuffle();
  }
}
