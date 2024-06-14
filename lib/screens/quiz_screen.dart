import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_maniac/screens/preview_screen.dart';
import 'package:quiz_maniac/services/api_service.dart';
import 'package:quiz_maniac/models/question_model.dart';

class QuizScreen extends StatefulWidget {
  final String categoryName;

  const QuizScreen({
    super.key,
    required this.categoryName,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ApiService _apiService = ApiService();
  Future<List<Datum>>? _questionsFuture;
  List<Datum> _questions = [];
  final Map<int, String> _answers = {};
  Timer? _timer;
  int _timerSeconds = 300;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _questionsFuture = _fetchQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timerSeconds > 0) {
            _timerSeconds--;
          } else {
            timer.cancel();
            _submitQuiz();
          }
        });
      }
    });
  }

  Future<List<Datum>> _fetchQuestions() async {
    try {
      List<Datum> questions = await _apiService.fetchQuestions();
      if (mounted) {
        setState(() {
          _questions = questions.take(5).toList();
          _questions.shuffle();
        });
        _startTimer();
      }
      return _questions;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load questions: $e')),
        );
      }
      return [];
    }
  }

  void _submitQuiz() {
    _timer?.cancel();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(
          questions: _questions,
          answers: _answers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.categoryName),
            Text('Time: ${_formatTimer(_timerSeconds)}'),
          ],
        ),
      ),
      body: FutureBuilder<List<Datum>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No questions available'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                _questions[_currentIndex].questionEnglish!,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                _questions[_currentIndex].questionHindi!,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ...['A', 'B', 'C', 'D'].map((option) {
                          final optionText = _questions[_currentIndex]
                              .toJson()['OPTION $option (ENGLISH)'];
                          final optionHindi = _questions[_currentIndex]
                              .toJson()['OPTION $option (HINDI)'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _answers[_currentIndex] = option;
                              });
                            },
                            child: Card(
                              elevation: 1.0,
                              color: _answers[_currentIndex] == option
                                  ? const Color.fromARGB(255, 28, 130, 214)
                                  : null,
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      optionText,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      optionHindi,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                leading: Radio<String>(
                                  value: option,
                                  groupValue: _answers[_currentIndex],
                                  onChanged: (value) {
                                    setState(() {
                                      _answers[_currentIndex] = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_currentIndex < _questions.length - 1)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (_currentIndex < _questions.length - 1) {
                                _currentIndex++;
                              }
                            });
                          },
                          child: const Text('Next'),
                        )
                      else
                        ElevatedButton(
                          onPressed: _submitQuiz,
                          child: const Text('Preview'),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
