import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/app_provider.dart';
import '../../models/exercise.dart';

class CreatePracticeSetScreen extends StatefulWidget {
  const CreatePracticeSetScreen({super.key});

  @override
  State<CreatePracticeSetScreen> createState() => _CreatePracticeSetScreenState();
}

class _CreatePracticeSetScreenState extends State<CreatePracticeSetScreen> {
  final _nameController = TextEditingController();
  final List<Exercise> _selectedExercises = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name')),
      );
      return;
    }

    if (_selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one exercise')),
      );
      return;
    }

    final set = PracticeSet(
      id: const Uuid().v4(),
      name: _nameController.text,
      exercises: _selectedExercises,
      createdAt: DateTime.now().toIso8601String().split('T')[0],
    );

    Provider.of<AppProvider>(context, listen: false).addPracticeSet(set);
    Navigator.pop(context);
  }

  void _showExerciseSelector() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: appProvider.exercises.length,
          itemBuilder: (context, index) {
            final exercise = appProvider.exercises[index];
            final isSelected = _selectedExercises.contains(exercise);
            return CheckboxListTile(
              title: Text(exercise.title),
              subtitle: Text('${exercise.duration} min'),
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedExercises.add(exercise);
                  } else {
                    _selectedExercises.remove(exercise);
                  }
                });
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = _selectedExercises.fold<int>(
      0,
      (sum, exercise) => sum + exercise.duration,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Practice Set'),
        actions: [
          TextButton(
            onPressed: _handleSave,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Practice Set Name',
                hintText: 'e.g., Daily Warm-Up',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exercises',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showExerciseSelector,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Exercise'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_selectedExercises.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(Icons.fitness_center, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No exercises added yet',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              )
            else
              ..._selectedExercises.map((exercise) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(exercise.title),
                    subtitle: Text('${exercise.duration} min'),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() => _selectedExercises.remove(exercise));
                      },
                    ),
                  ),
                );
              }),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Duration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$totalDuration min',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
