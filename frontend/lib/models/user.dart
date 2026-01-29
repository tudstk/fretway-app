class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final int level;
  final int xp;
  final int xpToNextLevel;
  final int streak;
  final int bestStreak;
  final double totalPracticeHours;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.level,
    required this.xp,
    required this.xpToNextLevel,
    required this.streak,
    required this.bestStreak,
    required this.totalPracticeHours,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    int? level,
    int? xp,
    int? xpToNextLevel,
    int? streak,
    int? bestStreak,
    double? totalPracticeHours,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      totalPracticeHours: totalPracticeHours ?? this.totalPracticeHours,
    );
  }
}
