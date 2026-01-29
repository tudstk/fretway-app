import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/app_provider.dart';
import '../../models/goal.dart';

class CreateMilestoneScreen extends StatefulWidget {
  final String goalId;

  const CreateMilestoneScreen({super.key, required this.goalId});

  @override
  State<CreateMilestoneScreen> createState() => _CreateMilestoneScreenState();
}

class _CreateMilestoneScreenState extends State<CreateMilestoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _targetDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _targetDate = picked);
    }
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;
    if (_targetDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a target date')),
      );
      return;
    }

    final milestone = Milestone(
      id: const Uuid().v4(),
      title: _titleController.text,
      description: _descriptionController.text,
      completed: false,
      targetDate: _targetDate!.toIso8601String().split('T')[0],
    );

    Provider.of<AppProvider>(context, listen: false)
        .addMilestone(widget.goalId, milestone);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Milestone'),
        actions: [
          TextButton(
            onPressed: _handleSave,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Milestone Title',
                  hintText: 'e.g., Play at 90 BPM',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a milestone title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Describe this milestone...',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Target Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _targetDate == null
                        ? 'Select target date'
                        : _targetDate!.toIso8601String().split('T')[0],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create Milestone'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
