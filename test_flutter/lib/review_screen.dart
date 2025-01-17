import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  final Map<String, dynamic> project;

  const ReviewScreen({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave a Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review Project: ${project['name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Rating:'),
            Slider(
              value: 3.0,
              min: 0,
              max: 5,
              divisions: 5,
              label: '3',
              onChanged: (double value) {},
            ),
            const SizedBox(height: 20),
            const Text('Review:'),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Write your review here...',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save review and rating
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Review submitted')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
