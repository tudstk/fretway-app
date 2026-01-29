import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/app_provider.dart';
import '../../models/exercise.dart';

class SessionCompleteScreen extends StatefulWidget {
  final PracticeSet practiceSet;
  final int duration;
  final int exercisesCompleted;

  const SessionCompleteScreen({
    super.key,
    required this.practiceSet,
    required this.duration,
    required this.exercisesCompleted,
  });

  @override
  State<SessionCompleteScreen> createState() => _SessionCompleteScreenState();
}

class _SessionCompleteScreenState extends State<SessionCompleteScreen> {
  final _notesController = TextEditingController();
  int _actualPracticeTime = 0;

  @override
  void initState() {
    super.initState();
    _actualPracticeTime = widget.duration;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _saveSession() {
    final session = PracticeSession(
      id: const Uuid().v4(),
      date: DateTime.now().toIso8601String().split('T')[0],
      duration: widget.duration,
      actualPracticeTime: _actualPracticeTime,
      exercisesCompleted: widget.exercisesCompleted,
      notes: _notesController.text,
      practiceSetId: widget.practiceSet.id,
    );

    Provider.of<AppProvider>(context, listen: false).addSession(session);

    final updatedSet = widget.practiceSet.copyWith(
      lastPracticed: DateTime.now().toIso8601String().split('T')[0],
    );
    Provider.of<AppProvider>(context, listen: false)
        .updatePracticeSet(widget.practiceSet.id, updatedSet);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Session saved! 🎉'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Complete'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
              color: Colors.green.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 64,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Great Session!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
                ),
                const SizedBox(height: 24),
                Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSummaryItem('Total Time', '${widget.duration} min'),
                    const Divider(),
                    _buildSummaryItem(
                      'Exercises Completed',
                      '${widget.exercisesCompleted}',
                    ),
                  ],
                ),
              ),
                ),
                const SizedBox(height: 24),
                Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How many minutes did you actually practice?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('$_actualPracticeTime minutes'),
                    Slider(
                      value: _actualPracticeTime.toDouble(),
                      min: 0,
                      max: widget.duration.toDouble(),
                      divisions: widget.duration,
                      label: '$_actualPracticeTime min',
                      onChanged: (value) {
                        setState(() => _actualPracticeTime = value.round());
                      },
                    ),
                  ],
                ),
              ),
                ),
                const SizedBox(height: 24),
                TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                hintText: 'How did the session go?',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
              onPressed: _saveSession,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save Session'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
