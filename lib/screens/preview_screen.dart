import 'package:flutter/material.dart';
import 'package:quiz_maniac/models/question_model.dart';
import 'question_detail_screen.dart';
import 'result_screen.dart';

class PreviewScreen extends StatefulWidget {
  final List<Datum> questions;
  final Map<int, String> answers;

  const PreviewScreen({
    Key? key,
    required this.questions,
    required this.answers,
  }) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  void _navigateToDetailScreen(int index) async {
    final updatedAnswer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionDetailScreen(
          question: widget.questions[index],
          userAnswer: widget.answers[index] ?? '',
          questionIndex: index,
        ),
      ),
    );

    if (updatedAnswer != null) {
      setState(() {
        widget.answers[index] = updatedAnswer;
      });
    }
  }

  void _submitQuiz() {
    int score = 0;
    widget.answers.forEach((index, answer) {
      if (widget.answers.containsKey(index) &&
          answer == widget.questions[index].answer.toString().split('.').last) {
        score++;
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: widget.questions,
          answers: widget.answers,
          score: score,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _navigateToDetailScreen(index),
                    child: Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Question ${index + 1}'),
                            Text(
                              'Answer: ${widget.answers[index] ?? 'Not Answered'}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitQuiz,
              child: Text('Submit Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
