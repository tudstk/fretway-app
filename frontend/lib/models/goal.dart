class Milestone {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String? completedDate;
  final String targetDate;
  final String? videoUrl;

  Milestone({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    this.completedDate,
    required this.targetDate,
    this.videoUrl,
  });

  Milestone copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
    String? completedDate,
    String? targetDate,
    String? videoUrl,
  }) {
    return Milestone(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      completedDate: completedDate ?? this.completedDate,
      targetDate: targetDate ?? this.targetDate,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}

enum GoalCategory {
  technique,
  song,
  theory,
  performance,
}

class Goal {
  final String id;
  final String title;
  final String description;
  final GoalCategory category;
  final String targetDate;
  final List<Milestone> milestones;
  final String createdAt;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.targetDate,
    required this.milestones,
    required this.createdAt,
  });

  Goal copyWith({
    String? id,
    String? title,
    String? description,
    GoalCategory? category,
    String? targetDate,
    List<Milestone>? milestones,
    String? createdAt,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      targetDate: targetDate ?? this.targetDate,
      milestones: milestones ?? this.milestones,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  int get progressPercentage {
    if (milestones.isEmpty) return 0;
    final completed = milestones.where((m) => m.completed).length;
    return ((completed / milestones.length) * 100).round();
  }
}
