import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/level_manager.dart';
import '../models/question.dart';
import '../data/question_data.dart';
import '../models/quiz_result.dart';
import '../data/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Question> quizQuestions;
  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _startQuiz();
  }

  Future<void> _startQuiz() async {
    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    int xp = 0;

    if (user != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final doc = await userRef.get();

      if (doc.exists) {
        xp = doc.data()?['xp'] ?? 0;
      } else {
        await userRef.set({
          'uid': user.uid,
          'email': user.email ?? '',
          'fullName': '',
          'xp': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });
        xp = 0;
      }
    }

    int level = LevelManager.getLevelFromXp(xp);
    String difficulty = LevelManager.getDifficultyFromLevel(level);

    final random = Random();
    quizQuestions = List<Question>.from(questionPool)
        .where((q) => q.difficulty == difficulty)
        .toList()
      ..shuffle(random);

    if (quizQuestions.isEmpty) {
      quizQuestions = List<Question>.from(questionPool)..shuffle(random);
    }

    quizQuestions = quizQuestions.take(min(5, quizQuestions.length)).toList();

    setState(() {
      currentIndex = 0;
      score = 0;
      selectedIndex = null;
      isLoading = false;
    });
  }

  void _checkAnswer() {
    if (selectedIndex == null) return;

    bool isCorrect = selectedIndex == quizQuestions[currentIndex].correctIndex;
    if (isCorrect) score++;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isCorrect ? "assets/ennie_yes.png" : "assets/ennie_no.png",
              height: 80,
            ),
            const SizedBox(height: 10),
            Text(
              isCorrect ? "Correct!" : "Wrong Answer",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              quizQuestions[currentIndex].explanation,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nextQuestion();
            },
            child: Text(
              "Next",
              style: GoogleFonts.inter(),
            ),
          ),
        ],
      ),
    );
  }

  void _nextQuestion() {
    if (currentIndex < quizQuestions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() async {
    final user = FirebaseAuth.instance.currentUser;
    int currentXp = 0;
    int earnedXp = score * LevelManager.xpPerCorrectAnswer;
    int newXp = 0;
    int newLevel = 1;

    if (user != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final doc = await userRef.get();
      currentXp = doc.data()?['xp'] ?? 0;
      newXp = currentXp + earnedXp;
      newLevel = LevelManager.getLevelFromXp(newXp);
    }

    QuizHistoryManager.addResult(
      QuizResult(
        title: "E-Waste Quiz",
        score: score,
        totalQuestions: quizQuestions.length,
        date: DateTime.now(),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/ennie.png", height: 80),
            const SizedBox(height: 10),
            Text(
              "You got $score/${quizQuestions.length}!",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your Eco Level: $newLevel",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (user != null) {
                final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
                await userRef.update({'xp': newXp});
              }
              Navigator.pop(context);
              _startQuiz();
            },
            child: Text(
              "Save Data",
              style: GoogleFonts.inter(),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (user != null) {
                final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
                await userRef.update({'xp': 0});
              }
              setState(() {
                score = 0;
                currentIndex = 0;
                selectedIndex = null;
              });
              Navigator.pop(context);
              _startQuiz();
            },
            child: Text(
              "New Data",
              style: GoogleFonts.inter(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startQuiz();
            },
            child: Text(
              "Try Again",
              style: GoogleFonts.inter(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFFFFDF6),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = quizQuestions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "E-Waste Quiz",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Question ${currentIndex + 1} of ${quizQuestions.length}",
              style: GoogleFonts.inter(),
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: (currentIndex + 1) / quizQuestions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            Image.asset("assets/ennie.png", height: 100),
            const SizedBox(height: 20),
            Text(
              question.question,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green[100] : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        question.options[index],
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: isSelected ? Colors.green[900] : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E4B32),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: _checkAnswer,
              child: Text(
                "Next Question",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}