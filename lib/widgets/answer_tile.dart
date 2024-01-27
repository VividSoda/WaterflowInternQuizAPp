import 'package:flutter/material.dart';

class AnswerTile extends StatelessWidget {
  const AnswerTile({super.key});

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.of(context).size.height;
    return Container(
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
            value: 0,
            groupValue: 0,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
