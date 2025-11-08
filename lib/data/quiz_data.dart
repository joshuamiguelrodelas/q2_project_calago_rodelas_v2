// quiz_data.dart
import 'package:e_nfohub/models/quiz_result.dart';

class QuizHistoryManager {
  static final List<QuizResult> _history = [];

  static void addResult(QuizResult result) {
    _history.add(result);
  }

  static List<QuizResult> get history => List.unmodifiable(_history);

  static double get averageScore {
    if (_history.isEmpty) return 0;
    double total = _history.fold(0, (sum, r) => sum + (r.score / r.totalQuestions));
    return total / _history.length;
  }
}
