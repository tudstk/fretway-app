import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/exercise.dart';
import 'practice_sets_tab.dart';
import 'exercises_tab.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Practice Sets'),
            Tab(text: 'Exercises Library'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PracticeSetsTab(),
          ExercisesTab(),
        ],
      ),
    );
  }
}
