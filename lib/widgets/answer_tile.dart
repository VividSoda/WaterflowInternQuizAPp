import 'package:flutter/material.dart';

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    super.key,
    required this.value,
    required this.selectAnswer,
    required this.groutValue,
    required this.answerOption,
    required this.isCorrect,
    required this.showCorrect,
  }) : isSelected = value == groutValue;

  final int value;
  final void Function(int? selectedOption) selectAnswer;
  final int groutValue;
  final String answerOption;
  final bool isSelected;
  final bool isCorrect;
  final bool showCorrect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          // height: scrHeight * 0.07,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: !isSelected
                ? !showCorrect
                    ? Colors.white
                    : isCorrect
                        ? const Color(0xFFb5d6cd)
                        : Colors.white
                : isCorrect
                    ? const Color(0xFFb5d6cd)
                    : const Color(0xFFd6a4a3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  answerOption,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Radio(
                  activeColor: isCorrect
                      ? const Color(0xFF0c594f)
                      : const Color(0xFFb01800),
                  value: value,
                  groupValue: groutValue,
                  onChanged: selectAnswer,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
