import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/goal.dart';
import '../models/exercise.dart';

class AppProvider with ChangeNotifier {
  User? _user;
  bool _isAuthenticated = false;
  List<Goal> _goals = [];
  List<Exercise> _exercises = [];
  List<PracticeSet> _practiceSets = [];
  List<PracticeSession> _sessions = [];
  List<Badge> _badges = [];

  static final User _demoUser = User(
    id: "1",
    name: "Alex Johnson",
    email: "alex@example.com",
    level: 12,
    xp: 2450,
    xpToNextLevel: 3000,
    streak: 7,
    bestStreak: 14,
    totalPracticeHours: 156,
  );

  static final List<Exercise> _demoExercises = [
    Exercise(
      id: "e1",
      title: "Chromatic Warm-Up",
      description: "Four-finger chromatic exercise across all strings",
      difficulty: ExerciseDifficulty.beginner,
      duration: 5,
      isCustom: false,
    ),
    Exercise(
      id: "e2",
      title: "Spider Exercise",
      description: "Finger independence exercise using adjacent strings",
      difficulty: ExerciseDifficulty.intermediate,
      duration: 10,
      isCustom: false,
    ),
    Exercise(
      id: "e3",
      title: "Alternate Picking Drill",
      description: "Single string alternate picking with metronome",
      difficulty: ExerciseDifficulty.intermediate,
      duration: 10,
      isCustom: false,
    ),
    Exercise(
      id: "e4",
      title: "Legato Practice",
      description: "Hammer-ons and pull-offs across scales",
      difficulty: ExerciseDifficulty.advanced,
      duration: 15,
      isCustom: false,
    ),
    Exercise(
      id: "e5",
      title: "Pentatonic Speed Runs",
      description: "Fast pentatonic sequences in various positions",
      difficulty: ExerciseDifficulty.advanced,
      duration: 15,
      isCustom: false,
    ),
    Exercise(
      id: "e6",
      title: "My Custom Riff",
      description: "Personal riff I want to perfect",
      difficulty: ExerciseDifficulty.intermediate,
      duration: 10,
      isCustom: true,
    ),
  ];

  static final List<Goal> _demoGoals = [
    Goal(
      id: "1",
      title: "Master Stairway to Heaven Solo",
      description: "Learn the complete guitar solo from Led Zeppelin's masterpiece",
      category: GoalCategory.song,
      targetDate: "2026-04-01",
      createdAt: "2025-12-01",
      milestones: [
        Milestone(
          id: "m1",
          title: "Learn first phrase at 60 BPM",
          description: "Nail the opening melody with correct fingering",
          completed: true,
          completedDate: "2025-12-15",
          targetDate: "2025-12-20",
        ),
        Milestone(
          id: "m2",
          title: "Play at 80 BPM",
          description: "Increase speed while maintaining accuracy",
          completed: true,
          completedDate: "2026-01-05",
          targetDate: "2026-01-10",
        ),
        Milestone(
          id: "m3",
          title: "Full solo at 100 BPM",
          description: "Play the complete solo at near full speed",
          completed: false,
          targetDate: "2026-02-15",
        ),
        Milestone(
          id: "m4",
          title: "Record final performance",
          description: "Clean recording at full speed with backing track",
          completed: false,
          targetDate: "2026-03-15",
        ),
      ],
    ),
    Goal(
      id: "2",
      title: "Improve Alternate Picking",
      description: "Develop clean and fast alternate picking technique",
      category: GoalCategory.technique,
      targetDate: "2026-03-01",
      createdAt: "2026-01-01",
      milestones: [
        Milestone(
          id: "m5",
          title: "120 BPM 16th notes",
          description: "Clean alternate picking at 120 BPM",
          completed: true,
          completedDate: "2026-01-20",
          targetDate: "2026-01-25",
        ),
        Milestone(
          id: "m6",
          title: "150 BPM 16th notes",
          description: "Increase to 150 BPM with accuracy",
          completed: false,
          targetDate: "2026-02-15",
        ),
      ],
    ),
    Goal(
      id: "3",
      title: "Learn Music Theory Basics",
      description: "Understand scales, modes, and chord progressions",
      category: GoalCategory.theory,
      targetDate: "2026-06-01",
      createdAt: "2026-01-10",
      milestones: [
        Milestone(
          id: "m7",
          title: "Major scale in all positions",
          description: "Memorize and play major scale across the fretboard",
          completed: false,
          targetDate: "2026-02-01",
        ),
      ],
    ),
  ];

  static final List<PracticeSet> _demoPracticeSets = [
    PracticeSet(
      id: "ps1",
      name: "Daily Warm-Up",
      exercises: [_demoExercises[0], _demoExercises[1]],
      lastPracticed: "2026-01-28",
      createdAt: "2025-12-01",
    ),
    PracticeSet(
      id: "ps2",
      name: "Speed Training",
      exercises: [_demoExercises[2], _demoExercises[4]],
      lastPracticed: "2026-01-27",
      createdAt: "2026-01-01",
    ),
    PracticeSet(
      id: "ps3",
      name: "Technique Builder",
      exercises: [_demoExercises[1], _demoExercises[2], _demoExercises[3]],
      lastPracticed: "2026-01-25",
      createdAt: "2026-01-10",
    ),
  ];

  static final List<PracticeSession> _demoSessions = [
    PracticeSession(
      id: "s1",
      date: "2026-01-29",
      duration: 45,
      actualPracticeTime: 40,
      exercisesCompleted: 4,
      notes: "Great session!",
      practiceSetId: "ps1",
    ),
    PracticeSession(
      id: "s2",
      date: "2026-01-28",
      duration: 30,
      actualPracticeTime: 25,
      exercisesCompleted: 3,
      notes: "",
      practiceSetId: "ps2",
    ),
    PracticeSession(
      id: "s3",
      date: "2026-01-27",
      duration: 60,
      actualPracticeTime: 50,
      exercisesCompleted: 5,
      notes: "Focused on speed",
      practiceSetId: "ps2",
    ),
    PracticeSession(
      id: "s4",
      date: "2026-01-26",
      duration: 35,
      actualPracticeTime: 30,
      exercisesCompleted: 3,
      notes: "",
      practiceSetId: "ps1",
    ),
    PracticeSession(
      id: "s5",
      date: "2026-01-25",
      duration: 45,
      actualPracticeTime: 40,
      exercisesCompleted: 4,
      notes: "Good progress",
      practiceSetId: "ps3",
    ),
    PracticeSession(
      id: "s6",
      date: "2026-01-24",
      duration: 40,
      actualPracticeTime: 35,
      exercisesCompleted: 4,
      notes: "",
      practiceSetId: "ps1",
    ),
    PracticeSession(
      id: "s7",
      date: "2026-01-23",
      duration: 50,
      actualPracticeTime: 45,
      exercisesCompleted: 5,
      notes: "Best session this week",
      practiceSetId: "ps2",
    ),
  ];

  static final List<Badge> _demoBadges = [
    Badge(
      id: "b1",
      name: "First Steps",
      description: "Complete your first practice session",
      icon: "trophy",
      unlocked: true,
      unlockedDate: "2025-12-01",
    ),
    Badge(
      id: "b2",
      name: "7-Day Streak",
      description: "Practice for 7 consecutive days",
      icon: "flame",
      unlocked: true,
      unlockedDate: "2026-01-20",
    ),
    Badge(
      id: "b3",
      name: "14-Day Streak",
      description: "Practice for 14 consecutive days",
      icon: "flame",
      unlocked: false,
      progress: 7,
      total: 14,
    ),
    Badge(
      id: "b4",
      name: "Goal Getter",
      description: "Complete your first goal",
      icon: "target",
      unlocked: false,
      progress: 0,
      total: 1,
    ),
    Badge(
      id: "b5",
      name: "Speed Demon",
      description: "Complete 10 speed training sessions",
      icon: "zap",
      unlocked: true,
      unlockedDate: "2026-01-15",
    ),
    Badge(
      id: "b6",
      name: "100 Hours",
      description: "Practice for 100 total hours",
      icon: "clock",
      unlocked: true,
      unlockedDate: "2026-01-10",
    ),
    Badge(
      id: "b7",
      name: "Perfectionist",
      description: "Complete all milestones in a goal",
      icon: "star",
      unlocked: false,
      progress: 2,
      total: 4,
    ),
    Badge(
      id: "b8",
      name: "Early Bird",
      description: "Practice before 8 AM, 5 times",
      icon: "sun",
      unlocked: false,
      progress: 2,
      total: 5,
    ),
  ];

  User? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  List<Goal> get goals => _goals;
  List<Exercise> get exercises => _exercises;
  List<PracticeSet> get practiceSets => _practiceSets;
  List<PracticeSession> get sessions => _sessions;
  List<Badge> get badges => _badges;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email.isNotEmpty) {
      _user = _demoUser;
      _isAuthenticated = true;
      _goals = List.from(_demoGoals);
      _practiceSets = List.from(_demoPracticeSets);
      _sessions = List.from(_demoSessions);
      _badges = List.from(_demoBadges);
      _exercises = List.from(_demoExercises);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (name.isNotEmpty && email.isNotEmpty) {
      _user = _demoUser.copyWith(name: name, email: email);
      _isAuthenticated = true;
      _goals = [];
      _practiceSets = [];
      _sessions = [];
      _badges = _demoBadges.map((b) => Badge(
            id: b.id,
            name: b.name,
            description: b.description,
            icon: b.icon,
            unlocked: false,
            progress: b.progress,
            total: b.total,
          )).toList();
      _exercises = List.from(_demoExercises);
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _user = null;
    _isAuthenticated = false;
    _goals = [];
    _practiceSets = [];
    _sessions = [];
    _badges = [];
    _exercises = List.from(_demoExercises);
    notifyListeners();
  }

  void addGoal(Goal goal) {
    _goals = [..._goals, goal];
    notifyListeners();
  }

  void updateGoal(String id, Goal updatedGoal) {
    _goals = _goals.map((g) => g.id == id ? updatedGoal : g).toList();
    notifyListeners();
  }

  void deleteGoal(String id) {
    _goals = _goals.where((g) => g.id != id).toList();
    notifyListeners();
  }

  void addMilestone(String goalId, Milestone milestone) {
    _goals = _goals.map((g) {
      if (g.id == goalId) {
        return g.copyWith(milestones: [...g.milestones, milestone]);
      }
      return g;
    }).toList();
    notifyListeners();
  }

  void toggleMilestone(String goalId, String milestoneId) {
    _goals = _goals.map((g) {
      if (g.id == goalId) {
        return g.copyWith(
          milestones: g.milestones.map((m) {
            if (m.id == milestoneId) {
              return m.copyWith(
                completed: !m.completed,
                completedDate: !m.completed
                    ? DateTime.now().toIso8601String().split('T')[0]
                    : null,
              );
            }
            return m;
          }).toList(),
        );
      }
      return g;
    }).toList();
    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    _exercises = [..._exercises, exercise];
    notifyListeners();
  }

  void addPracticeSet(PracticeSet set) {
    _practiceSets = [..._practiceSets, set];
    notifyListeners();
  }

  void updatePracticeSet(String id, PracticeSet updatedSet) {
    _practiceSets = _practiceSets.map((ps) => ps.id == id ? updatedSet : ps).toList();
    notifyListeners();
  }

  void deletePracticeSet(String id) {
    _practiceSets = _practiceSets.where((ps) => ps.id != id).toList();
    notifyListeners();
  }

  void addSession(PracticeSession session) {
    _sessions = [session, ..._sessions];
    if (_user != null) {
      _user = _user!.copyWith(
        xp: _user!.xp + (session.actualPracticeTime * 2),
        totalPracticeHours: _user!.totalPracticeHours + (session.actualPracticeTime / 60),
      );
    }
    notifyListeners();
  }
}
