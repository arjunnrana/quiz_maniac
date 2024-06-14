import 'package:flutter/material.dart';
import 'package:quiz_maniac/models/question_model.dart';

class QuestionReviewScreen extends StatelessWidget {
  final Datum question;
  final String userAnswer;
  final String correctAnswer;

  const QuestionReviewScreen({
    Key? key,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionEnglish!,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              question.questionHindi!,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Your Answer: $userAnswer',
              style: TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
            SizedBox(height: 10.0),
            Text(
              'Correct Answer: $correctAnswer',
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
