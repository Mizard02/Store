import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final String username;
  final int rating;
  final String comment;

  Review({
    required this.username,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recensione da $username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.deepPurple,
              ),
              SizedBox(width: 5),
              Text('$rating/5'),
            ],
          ),
          SizedBox(height: 8),
          Text(comment),
        ],
      ),
    );
  }
}