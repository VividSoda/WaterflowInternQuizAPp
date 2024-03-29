import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:waterflow_intern/api/quiz_api.dart';
import 'package:waterflow_intern/models/quiz.dart';
import 'package:waterflow_intern/models/result.dart';
import 'package:waterflow_intern/widgets/answer_tile.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.quizQuestions,
  });

  final List<Quiz> quizQuestions;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _seconds = 60;
  late Timer _quizTimer;
  // int _currentQuestionIndex = 0;
  int _currentQuestionIndex = 0;
  int _selectedOption = -1;
  List<Quiz> quizQuestions = [];
  bool _loading = true;
  List<Result> resultSummary = [];
  // List<String> _shuffledAnswerOptions = [];

  @override
  void initState() {
    super.initState();
    _getQuizList();
    _currentQuestionIndex = 0;
    _startTimer();
  }

  @override
  void dispose() {
    _quizTimer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _quizTimer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_seconds == 0) {
          timer.cancel();
          // Handle timer completion, e.g., show a message or perform an action
          _nextQuestion();
        } else {
          _seconds--;
        }
      });
    });
  }

  void _nextQuestion() {
    print("next clicked");
    resultSummary.add(
      Result(
        questionIndex: _currentQuestionIndex,
        question: quizQuestions[_currentQuestionIndex].question,
        correctAnswer: quizQuestions[_currentQuestionIndex].correctAnswer,
        selectedAnswer: _selectedOption == -1
            ? ""
            : quizQuestions[_currentQuestionIndex]
                .answerOptions[_selectedOption],
      ),
    );
    _quizTimer.cancel();
    setState(() {
      _currentQuestionIndex++;
      _selectedOption = -1;
      _seconds = 60;
    });
    _startTimer();
  }

  void _getQuizList() async {
    List<Quiz> questions = await QuizApi.getQuizQuestions();
    for (final question in questions) {
      question.shuffleOptions();
    }
    setState(() {
      quizQuestions = questions;
      _loading = false;
    });
  }

  void _finishQuiz() {
    resultSummary.add(
      Result(
        questionIndex: _currentQuestionIndex,
        question: quizQuestions[_currentQuestionIndex].question,
        correctAnswer: quizQuestions[_currentQuestionIndex].correctAnswer,
        selectedAnswer: _selectedOption == -1
            ? ""
            : quizQuestions[_currentQuestionIndex]
                .answerOptions[_selectedOption],
      ),
    );
    Navigator.of(context).pop(resultSummary);
  }

  @override
  Widget build(BuildContext context) {
    final scrHeight = MediaQuery.of(context).size.height;
    final scrWeidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFf1f2f6),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color(0xFF334c4c),
                                ),
                              ),
                              const Text(
                                "Previous",
                                style: TextStyle(
                                  color: Color(0xFF334c4c),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: scrWeidth * 0.15,
                              ),
                              Text(
                                "${_currentQuestionIndex + 1}/10",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: scrHeight * 0.125,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                height: scrHeight * 0.3,
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 5, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: const Offset(
                                          0, 3), // Offset to bottom-right
                                    ),
                                  ],
                                ),
                                child: Text(
                                  quizQuestions[_currentQuestionIndex].question,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -scrWeidth * 0.125,
                                left: scrWeidth * 0.35,
                                child: CircularPercentIndicator(
                                  radius: scrWeidth * 0.1,
                                  lineWidth: 10.0,
                                  percent: _seconds / 60,
                                  center: Text(
                                    _seconds.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      color: Color(0xFF0e4b4a),
                                    ),
                                  ),
                                  backgroundColor: const Color(0xFFb7d6ce),
                                  progressColor: const Color(0xFF0e4b4a),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: scrHeight * 0.07,
                          ),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   itemCount: quizQuestions[_currentQuestionIndex]
                          //       .answerOptions
                          //       .length,
                          //   itemBuilder: (context, index) {
                          //     return AnswerTile(
                          //       value: index,
                          //       // selectAnswer: _selectedOption > 0
                          //       //     ? null
                          //       //     :
                          //       selectAnswer: (value) {
                          //         if (_selectedOption > -1) {
                          //           return;
                          //         }
                          //         setState(() {
                          //           _selectedOption = value ?? -1;
                          //         });
                          //       },
                          //       groutValue: _selectedOption,
                          //       answerOption:
                          //           quizQuestions[_currentQuestionIndex]
                          //               .answerOptions[index],
                          //       isCorrect: quizQuestions[_currentQuestionIndex]
                          //               .answerOptions[index] ==
                          //           quizQuestions[_currentQuestionIndex]
                          //               .correctAnswer,
                          //       showCorrect: _selectedOption > -1,
                          //     );
                          //   },
                          // ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: quizQuestions[_currentQuestionIndex]
                                .answerOptions
                                .length,
                            itemBuilder: (context, index) {
                              return AnswerTile(
                                value: index,
                                // selectAnswer: _selectedOption > 0
                                //     ? null
                                //     :
                                selectAnswer: (value) {
                                  if (_selectedOption > -1) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedOption = value ?? -1;
                                  });
                                },
                                groutValue: _selectedOption,
                                answerOption:
                                    quizQuestions[_currentQuestionIndex]
                                        .answerOptions[index],
                                isCorrect: quizQuestions[_currentQuestionIndex]
                                        .answerOptions[index] ==
                                    quizQuestions[_currentQuestionIndex]
                                        .correctAnswer,
                                showCorrect: _selectedOption > -1,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: _currentQuestionIndex >= 9
                          ? _finishQuiz
                          : _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0a4f4c),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        _currentQuestionIndex >= 9 ? "Finish" : "Next",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
