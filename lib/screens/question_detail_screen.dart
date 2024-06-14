import 'package:flutter/material.dart';
import 'package:quiz_maniac/models/question_model.dart';

class QuestionDetailScreen extends StatefulWidget {
  final Datum question;
  final String userAnswer;
  final int questionIndex;

  const QuestionDetailScreen({
    Key? key,
    required this.question,
    required this.userAnswer,
    required this.questionIndex,
  }) : super(key: key);

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  late String _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _selectedAnswer = widget.userAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.questionEnglish!,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              widget.question.questionHindi!,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Your Answer: $_selectedAnswer',
              style: TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
            SizedBox(height: 20.0),
            Text(
              'Options:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            ...['A', 'B', 'C', 'D'].map((option) {
              final optionText =
                  widget.question.toJson()['OPTION $option (ENGLISH)'];
              final optionHindi =
                  widget.question.toJson()['OPTION $option (HINDI)'];
              return RadioListTile<String>(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      optionText ?? '',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      optionHindi ?? '',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                value: option,
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value!;
                  });
                },
              );
            }).toList(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedAnswer);
              },
              child: Text('Save and Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
