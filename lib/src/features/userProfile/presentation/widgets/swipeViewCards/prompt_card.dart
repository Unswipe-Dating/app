import 'package:flutter/material.dart';

class PromptCard extends StatelessWidget {
  final String question;
  final String answer;
  final int color;

  const PromptCard({Key? key,
    required this.question,
    required this.color,
    required this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(color),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
        children:[
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                question,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                question,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0),
              ),
            ),
            const Align( alignment: Alignment.centerRight,
              child: FloatingActionButton(
                heroTag: null,
              shape: CircleBorder(),
                onPressed: null,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite
                )
            ),
            ),
          ],
        ),

        ],
      ),
      ),
    );
  }
}
