import 'package:flutter/material.dart';
import 'package:quiz_maniac/models/question_model.dart';

class QuestionReviewScreen extends StatelessWidget {
  final Datum question;
  final String userAnswer;
  final String correctAnswer;

  const QuestionReviewScreen({
    super.key,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
  });

  String _getOptionText(String option) {
    return question.toJson()['OPTION $option (ENGLISH)'] ?? '';
  }

  String _getOptionTextHindi(String option) {
    return question.toJson()['OPTION $option (HINDI)'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionEnglish!,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              question.questionHindi!,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Your Answer: $userAnswer',
              style: const TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Correct Answer: $correctAnswer',
              style: const TextStyle(fontSize: 16.0, color: Colors.green),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Options:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ['A', 'B', 'C', 'D'].map((option) {
                final optionText = _getOptionText(option);
                final optionTextHindi = _getOptionTextHindi(option);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$option: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(optionText,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: option == correctAnswer
                                        ? FontWeight.bold
                                        : FontWeight.normal)),
                            Text(optionTextHindi,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: option == correctAnswer
                                        ? FontWeight.bold
                                        : FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
