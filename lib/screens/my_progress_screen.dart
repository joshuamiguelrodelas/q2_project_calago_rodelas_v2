import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/quiz_data.dart';
import '../utils/level_manager.dart';

class MyProgressScreen extends StatefulWidget {
  const MyProgressScreen({super.key});

  @override
  State<MyProgressScreen> createState() => _MyProgressScreenState();
}

class _MyProgressScreenState extends State<MyProgressScreen> {
  int totalXp = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserXp();
  }

  Future<void> _fetchUserXp() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          totalXp = doc.data()?['xp'] ?? 0;
          isLoading = false;
        });
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  Widget _buildCard(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: child,
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

    final history = QuizHistoryManager.history;

    final latestScore = history.isNotEmpty ? history.last.score : 0;
    final lastQuizTitle = history.isNotEmpty
        ? history.last.title
        : "No quizzes yet";
    final totalQuizzes = history.length;
    final averageScore = QuizHistoryManager.averageScore;

    final ecoLevel = LevelManager.getLevelFromXp(totalXp);
    final ecoProgress = LevelManager.getLevelProgress(totalXp);
    final ecoType = LevelManager.getEcoType(ecoLevel);

    final weeklyScores = history
        .take(3)
        .map((r) => r.score)
        .toList()
        .reversed
        .toList();

    final achievements = <String>[];
    if (totalQuizzes >= 1) achievements.add("First Quiz Completed!");
    if (averageScore > 0.8) achievements.add("Eco Genius: 80%+ Average!");
    if (totalQuizzes >= 5) achievements.add("Quiz Streak: 5 quizzes done!");

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "My Progress",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              children: [
                Image.asset("assets/ennie.png", height: 100),
                const SizedBox(height: 10),
                Text(
                  "Great job on your eco journey!",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildCard(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latest Score",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$latestScore/5  (Last Quiz: $lastQuizTitle)",
                    style: GoogleFonts.inter(),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: latestScore / 5,
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            _buildCard(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Eco Level",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Level $ecoLevel of ${LevelManager.maxLevel}",
                    style: GoogleFonts.inter(),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: ecoProgress,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Progress to next level → ${(ecoProgress * 100).toInt()}%",
                    style: GoogleFonts.inter(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Eco User Type → $ecoType",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            if (weeklyScores.isNotEmpty)
              _buildCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quiz Progress",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (int i = 0; i < weeklyScores.length; i++) ...[
                      Text(
                        "Quiz ${i + 1}   ${weeklyScores[i]}/5",
                        style: GoogleFonts.inter(),
                      ),
                      LinearProgressIndicator(
                        value: weeklyScores[i] / 5,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),

            _buildCard(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$totalQuizzes",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Quizzes Completed",
                        style: GoogleFonts.inter(),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${(averageScore * 100).toInt()}%",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Average Score",
                        style: GoogleFonts.inter(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (achievements.isNotEmpty)
              _buildCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Achievements",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var achievement in achievements) ...[
                      Text(
                        "🏅 $achievement",
                        style: GoogleFonts.inter(),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ],
                ),
              ),

            const SizedBox(height: 20),

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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Start Quiz",
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