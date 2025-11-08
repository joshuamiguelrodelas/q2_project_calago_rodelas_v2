class LevelManager {
  static const int maxLevel = 10;
  static const int xpPerCorrectAnswer = 10;

  // XP thresholds for each level (example: 0, 50, 100, 200, etc.)
  static List<int> levelThresholds = [
    0,
    50,
    120,
    200,
    300,
    420,
    560,
    720,
    900,
    1100,
    1300,
  ];

  // Get level from total XP
  static int getLevelFromXp(int xp) {
    for (int i = levelThresholds.length - 1; i >= 0; i--) {
      if (xp >= levelThresholds[i]) {
        return i + 1; // levels start at 1
      }
    }
    return 1;
  }

  // Get XP progress within the current level (0.0–1.0)
  static double getLevelProgress(int xp) {
    int currentLevel = getLevelFromXp(xp);
    if (currentLevel >= maxLevel) return 1.0;

    int currentLevelXp = levelThresholds[currentLevel - 1];
    int nextLevelXp = levelThresholds[currentLevel];
    return ((xp - currentLevelXp) / (nextLevelXp - currentLevelXp)).clamp(
      0.0,
      1.0,
    );
  }

  // Difficulty by level
  static String getDifficultyFromLevel(int level) {
    if (level <= 3) return "Easy";
    if (level <= 7) return "Medium";
    return "Hard";
  }

  // Eco type based on level
  static String getEcoType(int level) {
    if (level <= 3) return "Eco Starter";
    if (level <= 6) return "Eco Saver";
    if (level <= 9) return "Eco Warrior";
    return "Eco Master";
  }
}
