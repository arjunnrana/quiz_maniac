import 'package:flutter/material.dart';
import 'package:quiz_maniac/screens/quiz_screen.dart';

class QuizCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Fanatic'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/preview.png'),
                        fit: BoxFit.cover)),
                child: Container()),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            _buildCategoryCard(context, 'Category 1'),
            _buildCategoryCard(context, 'Category 2'),
            _buildCategoryCard(context, 'Category 3'),
            _buildCategoryCard(context, 'Category 4'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String categoryName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizScreen(categoryName: categoryName),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
