import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF578885),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
          top: 20,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: CircleAvatar(
                  radius: scrWidth * 0.15,
                  backgroundColor: Colors.white,
                  child: const Text(
                    'QUIZ',
                    style: TextStyle(
                      color: Color(0xFF0f4e45),
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Enter your name",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "name",
                ),
              ),
              const Spacer(),
              //start button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFf7ce62),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //view quiz results
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF75bda7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    "View Quiz Result",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
