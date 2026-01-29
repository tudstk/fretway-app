import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: appProvider.badges.length,
            itemBuilder: (context, index) {
              final badge = appProvider.badges[index];
              return _buildBadgeCard(context, badge);
            },
          );
        },
      ),
    );
  }

  Widget _buildBadgeCard(BuildContext context, badge) {
    final isUnlocked = badge.unlocked;
    final progress = badge.progress != null && badge.total != null
        ? badge.progress! / badge.total!
        : 0.0;

    return Card(
      color: isUnlocked
          ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
          : Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getBadgeIcon(badge.icon),
              size: 48,
              color: isUnlocked
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              badge.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isUnlocked ? null : Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              badge.description,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (!isUnlocked && badge.progress != null) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.withOpacity(0.2),
              ),
              const SizedBox(height: 4),
              Text(
                '${badge.progress}/${badge.total}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[400],
                ),
              ),
            ],
            if (isUnlocked && badge.unlockedDate != null) ...[
              const SizedBox(height: 8),
              Text(
                'Unlocked: ${badge.unlockedDate}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getBadgeIcon(String iconName) {
    switch (iconName) {
      case 'trophy':
        return Icons.emoji_events;
      case 'flame':
        return Icons.local_fire_department;
      case 'target':
        return Icons.track_changes;
      case 'zap':
        return Icons.bolt;
      case 'clock':
        return Icons.access_time;
      case 'star':
        return Icons.star;
      case 'sun':
        return Icons.wb_sunny;
      default:
        return Icons.star;
    }
  }
}
