import 'package:flutter/material.dart';
import 'package:quiz_maniac/models/question_model.dart';
import 'package:quiz_maniac/main.dart';
import 'package:quiz_maniac/screens/quiz_category_screen.dart'; // Import your main.dart file
import 'question_review_screen.dart';

class ResultScreen extends StatelessWidget {
  final List<Datum> questions;
  final Map<int, String> answers;
  final int score;

  const ResultScreen(
      {super.key,
      required this.questions,
      required this.answers,
      required this.score});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Result'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Score: $score',
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    final userAnswer = answers[index];
                    final correctAnswer =
                        question.answer.toString().split('.').last;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionReviewScreen(
                              question: question,
                              userAnswer: userAnswer ?? 'Not Answered',
                              correctAnswer: correctAnswer,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(question.questionEnglish!),
                          subtitle: Text(
                              'Your answer: $userAnswer\nCorrect answer: $correctAnswer'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                    (route) => false,
                  );
                },
                child: const Text('Start Another Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
