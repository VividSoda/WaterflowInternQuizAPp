import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterflow_intern/models/result.dart';
import 'dart:convert';

class ResulUtilities {
  static List<Map<String, dynamic>> toMap(List<Result> resultsData) {
    List<Map<String, dynamic>> resultsSummary = [];
    for (final data in resultsData) {
      resultsSummary.add(toMapSingleData(data));
    }
    return resultsSummary;
  }

  static Map<String, dynamic> toMapSingleData(Result data) {
    final Map<String, dynamic> dataMap = {
      'questionIndex': data.questionIndex,
      'question': data.question,
      'correctAnswer': data.correctAnswer,
      'selectedAnwer': data.selectedAnswer,
    };
    return dataMap;
  }

  static void storeData(List<Result> resultsSummary) async {
    List<Map<String, dynamic>> resultsMap = toMap(resultsSummary);

    final jsonData = json.encode(resultsMap);
    // print(jsonData);

    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString("result", jsonData);
  }

  static Future<List<Result>> loadData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonData = pref.getString("result");

    if (jsonData == null) {
      return [];
    }
    final List<dynamic> mapData = json.decode(jsonData);

    final List<Result> results = [];

    for (final map in mapData) {
      // print(map);
      results.add(toObject(map));
      // toObject(map);
    }

    return results;
  }

  static Result toObject(Map<String, dynamic> mapData) {
    // print(mapData['questionIndex'] as int);
    // print(mapData['question'] as String);
    // print(mapData['correctAnswer'] as String);
    // print(mapData['selectedAnwer'] as String);

    final Result result = Result(
      questionIndex: mapData['questionIndex'] as int,
      question: mapData['question'] as String,
      correctAnswer: mapData['correctAnswer'] as String,
      selectedAnswer: mapData['selectedAnwer'] as String,
    );

    return result;
  }
}
