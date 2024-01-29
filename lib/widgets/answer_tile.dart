import 'package:flutter/material.dart';

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    super.key,
    required this.option,
    required this.selectAnswer,
    required this.groutValue,
  });

  final int option;
  final void Function(int? selectedOption) selectAnswer;
  final int groutValue;

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: scrHeight * 0.07,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              const Text(
                "Option",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Radio(
                activeColor: Colors.black,
                value: option,
                groupValue: groutValue,
                onChanged: selectAnswer,
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
