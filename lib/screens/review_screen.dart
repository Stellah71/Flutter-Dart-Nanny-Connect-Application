import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReviewScreen extends StatefulWidget {
  final String nannyId;
  final String nannyName;

  const ReviewScreen({super.key, required this.nannyId, required this.nannyName});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 3.0;
  final _reviewController = TextEditingController();
  bool _submitting = false;

  Future<void> _submitReview() async {
    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter a review")));
      return;
    }

    setState(() => _submitting = true);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('nannies')
          .doc(widget.nannyId)
          .collection('reviews')
          .add({
        'employerId': user.uid,
        'rating': _rating,
        'review': _reviewController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Review submitted")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to submit review: $e")));
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Review ${widget.nannyName}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Rate", style: TextStyle(fontSize: 18)),
            Slider(
              value: _rating,
              min: 1,
              max: 5,
              divisions: 4,
              label: _rating.toString(),
              onChanged: (val) => setState(() => _rating = val),
            ),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                labelText: "Write your review",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            _submitting
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitReview,
                    child: Text("Submit Review"),
                  ),
          ],
        ),
      ),
    );
  }
}
