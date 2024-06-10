import 'package:dio/dio.dart';
import 'package:quiz_maniac/models/question_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Datum>> fetchQuestions() async {
    final response =
        await _dio.get('https://dakshadmin.online/api/fetchPhdQuestion');
    if (response.statusCode == 200) {
      final data = response.data;
      final QuestionModel questionModel = QuestionModel.fromJson(data);
      final List<Datum> questions = questionModel.data.take(40).toList();
      print(questions.map((q) => q.toJson()).toList()); // Print the questions
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
