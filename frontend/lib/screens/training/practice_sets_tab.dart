import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/exercise.dart';
import 'create_practice_set_screen.dart';

class PracticeSetsTab extends StatelessWidget {
  const PracticeSetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        if (appProvider.practiceSets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No practice sets yet',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreatePracticeSetScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create Practice Set'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: appProvider.practiceSets.length,
          itemBuilder: (context, index) {
            final set = appProvider.practiceSets[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.playlist_play,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(set.name),
                subtitle: Text(
                  '${set.exercises.length} exercises • ${set.totalDuration} min',
                ),
                trailing: set.lastPracticed != null
                    ? Text(
                        'Last: ${set.lastPracticed}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      )
                    : null,
                onTap: () {
                  // to do: start practice session
                },
              ),
            );
          },
        );
      },
    );
  }
}
