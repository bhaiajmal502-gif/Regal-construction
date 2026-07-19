import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../widgets/inputs/premium_text_field.dart';
import '../../widgets/buttons/premium_button.dart';
import '../../models/todo_model.dart';
import '../../services/todo_local_storage.dart';
import 'package:uuid/uuid.dart';

class AddEditTodoScreen extends StatefulWidget {
  final TodoModel? todo;

  const AddEditTodoScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;

  late DateTime _selectedDate;
  late String _selectedPriority;
  late String _selectedCategory;
  late bool _hasReminder;
  late TimeOfDay _reminderTime;
  late List<String> _tags;

  bool _isLoading = false;

  final List<String> priorities = ['Low', 'Medium', 'High', 'Urgent'];
  final List<String> categories = ['Work', 'Personal', 'Shopping', 'Health', 'Other'];

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController = TextEditingController(text: widget.todo!.title);
      _descriptionController =
          TextEditingController(text: widget.todo!.description);
      _selectedDate = widget.todo!.dueDate;
      _selectedPriority = widget.todo!.priority;
      _selectedCategory = widget.todo!.category;
      _hasReminder = widget.todo!.hasReminder;
      _tags = List.from(widget.todo!.tags);
      _tagsController = TextEditingController();
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _selectedDate = DateTime.now().add(const Duration(days: 1));
      _selectedPriority = 'Medium';
      _selectedCategory = 'Other';
      _hasReminder = false;
      _tags = [];
      _tagsController = TextEditingController();
    }
    _reminderTime = const TimeOfDay(hour: 9, minute: 0);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _saveTodo() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final todo = TodoModel(
      id: widget.todo?.id ?? const Uuid().v4(),
      title: _titleController.text,
      description: _descriptionController.text,
      dueDate: _selectedDate,
      priority: _selectedPriority,
      category: _selectedCategory,
      isCompleted: widget.todo?.isCompleted ?? false,
      tags: _tags,
      createdAt: widget.todo?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
      hasReminder: _hasReminder,
      reminderTime: _hasReminder
          ? '${_reminderTime.hour}:${_reminderTime.minute}'
          : null,
    );

    bool success;
    if (widget.todo != null) {
      success = await TodoLocalStorage.updateTodo(todo);
    } else {
      success = await TodoLocalStorage.addTodo(todo);
    }

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.todo != null ? 'Todo updated' : 'Todo created',
          ),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving todo'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text(
          widget.todo != null ? 'Edit Todo' : 'New Todo',
          style: AppTypography.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            PremiumTextField(
              label: 'Title',
              hint: 'Enter todo title',
              controller: _titleController,
              prefixIcon: Icons.title_rounded,
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Description
            PremiumTextField(
              label: 'Description',
              hint: 'Add details about your task',
              controller: _descriptionController,
              prefixIcon: Icons.description_outlined,
              maxLines: 3,
              minLines: 3,
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Category
            Text('Category', style: AppTypography.labelMedium),
            const SizedBox(height: AppSpacing.marginSmall),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.marginSmall),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMedium,
                          vertical: AppSpacing.paddingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textLight,
                          ),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMedium),
                        ),
                        child: Text(
                          category,
                          style: AppTypography.labelMedium.copyWith(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Priority
            Text('Priority', style: AppTypography.labelMedium),
            const SizedBox(height: AppSpacing.marginSmall),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: priorities.map((priority) {
                  final isSelected = _selectedPriority == priority;
                  Color color = _getPriorityColor(priority);
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.marginSmall),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPriority = priority),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMedium,
                          vertical: AppSpacing.paddingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? color : Colors.white,
                          border: Border.all(
                            color: isSelected ? color : AppColors.textLight,
                          ),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMedium),
                        ),
                        child: Text(
                          priority,
                          style: AppTypography.labelMedium.copyWith(
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Due Date
            Text('Due Date', style: AppTypography.labelMedium),
            const SizedBox(height: AppSpacing.marginSmall),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                  vertical: AppSpacing.paddingMedium,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  border: Border.all(
                    color: Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Date',
                          style: AppTypography.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: AppTypography.titleMedium,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Tags
            Text('Tags', style: AppTypography.labelMedium),
            const SizedBox(height: AppSpacing.marginSmall),
            Row(
              children: [
                Expanded(
                  child: PremiumTextField(
                    label: '',
                    hint: 'Add tag and press Enter',
                    controller: _tagsController,
                  ),
                ),
                const SizedBox(width: AppSpacing.marginSmall),
                GestureDetector(
                  onTap: () {
                    if (_tagsController.text.isNotEmpty) {
                      setState(() {
                        _tags.add(_tagsController.text);
                        _tagsController.clear();
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            if (_tags.isNotEmpty) ...
              const SizedBox(height: AppSpacing.marginSmall),
            if (_tags.isNotEmpty)
              Wrap(
                spacing: AppSpacing.marginSmall,
                children: _tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() => _tags.remove(tag));
                    },
                  );
                }).toList(),
              ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Reminder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Enable Reminder', style: AppTypography.titleMedium),
                Switch(
                  value: _hasReminder,
                  onChanged: (value) {
                    setState(() => _hasReminder = value);
                  },
                  activeColor: AppColors.primary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: PremiumButton(
                text: widget.todo != null ? 'Update Todo' : 'Create Todo',
                onPressed: _saveTodo,
                isLoading: _isLoading,
                icon: Icons.check_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Urgent':
        return AppColors.error;
      case 'High':
        return AppColors.warning;
      case 'Medium':
        return AppColors.accent;
      case 'Low':
        return AppColors.success;
      default:
        return AppColors.info;
    }
  }
}
