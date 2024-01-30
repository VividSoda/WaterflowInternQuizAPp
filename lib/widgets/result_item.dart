import 'package:flutter/material.dart';
import 'package:waterflow_intern/models/result.dart';
import 'package:waterflow_intern/widgets/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.resultData, {super.key});

  final Result resultData;

  @override
  Widget build(context) {
    final isCorrectAnswer =
        resultData.selectedAnswer == resultData.correctAnswer;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionsIdentifier(
            isCorrectAnswer: isCorrectAnswer,
            questionIndex: resultData.questionIndex,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resultData.question,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  resultData.selectedAnswer,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 202, 171, 252),
                  ),
                ),
                Text(
                  resultData.correctAnswer,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 181, 254, 246)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
