// quiz_history_manager.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/quiz_result.dart';

class QuizHistoryManager {
  static List<QuizResult> history = [];

  // Average score of all quizzes
  static double get averageScore {
    if (history.isEmpty) return 0.0;
    double total = 0;
    for (var q in history) {
      total += q.score / q.totalQuestions;
    }
    return total / history.length;
  }

  // Load latest quizzes from Firestore (default: latest 5)
  static Future<void> loadHistory({int limit = 5}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quizHistory')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .get();

    history = snapshot.docs
        .map((doc) => QuizResult.fromMap(doc.data()))
        .toList();
  }

  // Add a new quiz result to Firestore and update local history
  static Future<void> addQuiz(QuizResult result) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quizHistory')
        .add(result.toMap());

    // Add to local history (keep latest 5)
    history.insert(0, result);
    if (history.length > 5) history = history.sublist(0, 5);
  }
}
