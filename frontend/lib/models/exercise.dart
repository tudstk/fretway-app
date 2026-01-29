enum ExerciseDifficulty {
  beginner,
  intermediate,
  advanced,
}

class Exercise {
  final String id;
  final String title;
  final String description;
  final ExerciseDifficulty difficulty;
  final int duration; // in minutes
  final String? videoUrl;
  final bool isCustom;
  final String? thumbnailUrl;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.duration,
    this.videoUrl,
    required this.isCustom,
    this.thumbnailUrl,
  });

  Exercise copyWith({
    String? id,
    String? title,
    String? description,
    ExerciseDifficulty? difficulty,
    int? duration,
    String? videoUrl,
    bool? isCustom,
    String? thumbnailUrl,
  }) {
    return Exercise(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      duration: duration ?? this.duration,
      videoUrl: videoUrl ?? this.videoUrl,
      isCustom: isCustom ?? this.isCustom,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}

class PracticeSet {
  final String id;
  final String name;
  final List<Exercise> exercises;
  final String? lastPracticed;
  final String createdAt;

  PracticeSet({
    required this.id,
    required this.name,
    required this.exercises,
    this.lastPracticed,
    required this.createdAt,
  });

  PracticeSet copyWith({
    String? id,
    String? name,
    List<Exercise>? exercises,
    String? lastPracticed,
    String? createdAt,
  }) {
    return PracticeSet(
      id: id ?? this.id,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
      lastPracticed: lastPracticed ?? this.lastPracticed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  int get totalDuration {
    return exercises.fold(0, (sum, exercise) => sum + exercise.duration);
  }
}

class PracticeSession {
  final String id;
  final String date;
  final int duration; // in minutes
  final int actualPracticeTime; // in minutes
  final int exercisesCompleted;
  final String notes;
  final String? practiceSetId;

  PracticeSession({
    required this.id,
    required this.date,
    required this.duration,
    required this.actualPracticeTime,
    required this.exercisesCompleted,
    required this.notes,
    this.practiceSetId,
  });
}

class Badge {
  final String id;
  final String name;
  final String description;
  final String icon;
  final bool unlocked;
  final String? unlockedDate;
  final int? progress;
  final int? total;

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.unlocked,
    this.unlockedDate,
    this.progress,
    this.total,
  });

  Badge copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    bool? unlocked,
    String? unlockedDate,
    int? progress,
    int? total,
  }) {
    return Badge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      unlocked: unlocked ?? this.unlocked,
      unlockedDate: unlockedDate ?? this.unlockedDate,
      progress: progress ?? this.progress,
      total: total ?? this.total,
    );
  }
}
