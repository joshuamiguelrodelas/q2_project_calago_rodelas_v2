// quiz_result.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizResult {
  final String title;
  final int score;
  final int totalQuestions;
  final DateTime date;

  QuizResult({
    required this.title,
    required this.score,
    required this.totalQuestions,
    required this.date,
  });

  // Convert Firestore document to QuizResult
  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      title: map['title'] ?? 'Untitled Quiz',
      score: map['score'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 5,
      date: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert QuizResult to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'score': score,
      'totalQuestions': totalQuestions,
      'timestamp': date,
    };
  }
}
