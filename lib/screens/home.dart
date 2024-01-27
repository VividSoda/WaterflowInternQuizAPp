import 'package:flutter/material.dart';
import 'package:waterflow_intern/api/quiz_api.dart';
import 'package:waterflow_intern/models/quiz.dart';
import 'package:waterflow_intern/screens/quiz.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  String? _errorText;
  late List<Quiz> quizQuestions;

  @override
  void initState() {
    super.initState();
    _intializeQuizList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _intializeQuizList() async {
    List<Quiz> questions = await QuizApi.getQuizQuestions();
    setState(() {
      quizQuestions = questions;
    });
  }

  void _validateName() {
    final enteredName = _nameController.text;
    if (enteredName.isEmpty) {
      setState(() {
        _errorText = "Please enter your name!";
      });
    } else if (!enteredName.contains(" ")) {
      setState(() {
        _errorText = 'Enter full name!';
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  void _startQuiz() {
    // _validateName();
    final bool isValid = _errorText == null;
    if (!isValid) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          quizQuestions: quizQuestions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF578885),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 120, // Adjusted bottom padding to accommodate buttons
                top: 20,
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 80),
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
                    const SizedBox(height: 100),
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
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _nameController,
                      autocorrect: false,
                      enableSuggestions: false,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "name",
                        hintStyle: const TextStyle(color: Colors.white),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorText: _errorText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _startQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFf7ce62),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF75bda7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
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
        ],
      ),
    );
  }
}
