import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/exercise.dart';
import 'session_complete_screen.dart';

class ActiveSessionScreen extends StatefulWidget {
  final PracticeSet practiceSet;

  const ActiveSessionScreen({super.key, required this.practiceSet});

  @override
  State<ActiveSessionScreen> createState() => _ActiveSessionScreenState();
}

class _ActiveSessionScreenState extends State<ActiveSessionScreen> {
  int _currentExerciseIndex = 0;
  int _elapsedSeconds = 0;
  bool _isPaused = false;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _isRunning && !_isPaused) {
        setState(() => _elapsedSeconds++);
        _startTimer();
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (!_isPaused) {
        _startTimer();
      }
    });
  }

  void _nextExercise() {
    if (_currentExerciseIndex < widget.practiceSet.exercises.length - 1) {
      setState(() => _currentExerciseIndex++);
    } else {
      _completeSession();
    }
  }

  void _completeSession() {
    final duration = _elapsedSeconds ~/ 60;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SessionCompleteScreen(
          practiceSet: widget.practiceSet,
          duration: duration,
          exercisesCompleted: _currentExerciseIndex + 1,
        ),
      ),
    );
  }

  void _stopSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stop Session?'),
        content: const Text('Are you sure you want to stop this practice session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Stop'),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = widget.practiceSet.exercises[_currentExerciseIndex];
    final progress = (_currentExerciseIndex + 1) / widget.practiceSet.exercises.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Session'),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: _stopSession,
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withOpacity(0.2),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatTime(_elapsedSeconds),
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    currentExercise.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Exercise ${_currentExerciseIndex + 1} of ${widget.practiceSet.exercises.length}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _togglePause,
                  icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                  label: Text(_isPaused ? 'Resume' : 'Pause'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _nextExercise,
                  icon: const Icon(Icons.skip_next),
                  label: const Text('Next Exercise'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
