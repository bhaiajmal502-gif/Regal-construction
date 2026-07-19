import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../models/todo_model.dart';
import '../../services/todo_local_storage.dart';
import '../../widgets/todos/todo_card.dart';
import '../../widgets/buttons/premium_button.dart';
import 'add_edit_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoModel> _todos = [];
  List<TodoModel> _filteredTodos = [];
  String _selectedFilter = 'All';
  String _searchQuery = '';
  late TextEditingController _searchController;

  final List<String> filterOptions = [
    'All',
    'Pending',
    'Completed',
    'Today',
    'Overdue',
    'High Priority'
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadTodos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadTodos() async {
    final todos = await TodoLocalStorage.getAllTodos();
    setState(() {
      _todos = todos;
      _applyFilter();
    });
  }

  void _applyFilter() {
    List<TodoModel> filtered = _todos;

    // Apply filter
    switch (_selectedFilter) {
      case 'Pending':
        filtered = filtered.where((t) => !t.isCompleted).toList();
        break;
      case 'Completed':
        filtered = filtered.where((t) => t.isCompleted).toList();
        break;
      case 'Today':
        filtered = filtered.where((t) => t.isDueToday()).toList();
        break;
      case 'Overdue':
        filtered = filtered.where((t) => t.isOverdue()).toList();
        break;
      case 'High Priority':
        filtered = filtered
            .where((t) => t.priority == 'High' || t.priority == 'Urgent')
            .toList();
        break;
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((t) =>
              t.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              t.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Sort by priority and due date
    filtered.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return a.dueDate.compareTo(b.dueDate);
    });

    setState(() => _filteredTodos = filtered);
  }

  void _toggleTodoComplete(TodoModel todo) async {
    final updated =
        todo.copyWith(isCompleted: !todo.isCompleted, updatedAt: DateTime.now());
    await TodoLocalStorage.updateTodo(updated);
    _loadTodos();
  }

  void _deleteTodo(String id) async {
    await TodoLocalStorage.deleteTodo(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todo deleted'),
        backgroundColor: AppColors.success,
      ),
    );
    _loadTodos();
  }

  void _editTodo(TodoModel todo) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTodoScreen(todo: todo),
      ),
    );
    if (result == true) {
      _loadTodos();
    }
  }

  void _addNewTodo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditTodoScreen(),
      ),
    );
    if (result == true) {
      _loadTodos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text(
          'My Todos',
          style: AppTypography.headlineSmall,
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistics
              _buildStatistics(),
              const SizedBox(height: AppSpacing.marginLarge),

              // Search bar
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  _searchQuery = value;
                  _applyFilter();
                },
                decoration: InputDecoration(
                  hintText: 'Search todos...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF3F4F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.marginLarge),

              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filterOptions.map((filter) {
                    final isSelected = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.marginSmall),
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedFilter = filter);
                          _applyFilter();
                        },
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
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium,
                            ),
                          ),
                          child: Text(
                            filter,
                            style: AppTypography.labelMedium.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppSpacing.marginLarge),

              // Todos list
              if (_filteredTodos.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.marginXLarge,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 64,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: AppSpacing.marginLarge),
                        Text(
                          'No todos yet',
                          style: AppTypography.headlineSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create your first todo to get started',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredTodos.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpacing.marginMedium),
                  itemBuilder: (context, index) {
                    final todo = _filteredTodos[index];
                    return TodoCard(
                      todo: todo,
                      onTap: () {
                        // Show todo details or edit
                        _editTodo(todo);
                      },
                      onDelete: () {
                        _deleteTodo(todo.id);
                      },
                      onToggleComplete: () {
                        _toggleTodoComplete(todo);
                      },
                      onEdit: () {
                        _editTodo(todo);
                      },
                    );
                  },
                ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTodo,
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    int total = _todos.length;
    int completed = _todos.where((t) => t.isCompleted).length;
    int pending = total - completed;
    int overdue = _todos.where((t) => t.isOverdue()).length;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', total.toString()),
          _buildStatItem('Pending', pending.toString()),
          _buildStatItem('Completed', completed.toString()),
          _buildStatItem('Overdue', overdue.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.bodySmall,
        ),
      ],
    );
  }
}
