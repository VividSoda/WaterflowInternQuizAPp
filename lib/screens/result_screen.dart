import 'package:flutter/material.dart';
import 'package:waterflow_intern/models/result.dart';
import 'package:waterflow_intern/utils/result_utilities.dart';
import 'package:waterflow_intern/widgets/result_item.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    // required this.resultSummary,
  });

  // final List<Result> resultSummary;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Result> resultSummary = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadResultSummary();
  }

  void _loadResultSummary() async {
    final List<Result> results = await ResulUtilities.loadData();
    setState(() {
      resultSummary = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = resultSummary.length;
    final numCorrectQuestions = resultSummary.where((data) {
      return data.selectedAnswer == data.correctAnswer;
    }).length;

    return Scaffold(
      backgroundColor: const Color(0xFF578885),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Result Screen",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'You answers $numCorrectQuestions out of $numTotalQuestions questions correctly!',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 230, 200, 253),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      ...resultSummary.map((result) => SummaryItem(result)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
