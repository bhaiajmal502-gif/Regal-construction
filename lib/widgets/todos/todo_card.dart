import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../models/todo_model.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;
  final VoidCallback onEdit;

  const TodoCard({
    Key? key,
    required this.todo,
    required this.onTap,
    required this.onDelete,
    required this.onToggleComplete,
    required this.onEdit,
  }) : super(key: key);

  Color _getPriorityColor() {
    switch (todo.priority) {
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

  Color _getCategoryColor() {
    switch (todo.category) {
      case 'Work':
        return AppColors.primary;
      case 'Personal':
        return AppColors.accent;
      case 'Shopping':
        return const Color(0xFF6366F1);
      case 'Health':
        return AppColors.success;
      default:
        return AppColors.info;
    }
  }

  IconData _getCategoryIcon() {
    switch (todo.category) {
      case 'Work':
        return Icons.work_outline_rounded;
      case 'Personal':
        return Icons.person_outline_rounded;
      case 'Shopping':
        return Icons.shopping_bag_outlined;
      case 'Health':
        return Icons.health_and_safety_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: todo.isCompleted
                ? AppColors.success.withOpacity(0.3)
                : (todo.isOverdue()
                    ? AppColors.error.withOpacity(0.3)
                    : AppColors.textLight.withOpacity(0.2)),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with checkbox and actions
            Row(
              children: [
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => onToggleComplete(),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: AppTypography.titleMedium.copyWith(
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: todo.isCompleted
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (todo.description.isNotEmpty) ...
                        const SizedBox(height: 4),
                      if (todo.description.isNotEmpty)
                        Text(
                          todo.description,
                          style: AppTypography.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.edit_outlined),
                          const SizedBox(width: 8),
                          const Text('Edit'),
                        ],
                      ),
                      onTap: onEdit,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.delete_outline, color: AppColors.error),
                          const SizedBox(width: 8),
                          const Text('Delete', style: TextStyle(color: AppColors.error)),
                        ],
                      ),
                      onTap: onDelete,
                    ),
                  ],
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.marginSmall),

            // Tags and category
            if (todo.tags.isNotEmpty || todo.category.isNotEmpty)
              Wrap(
                spacing: AppSpacing.marginSmall,
                runSpacing: 4,
                children: [
                  if (todo.category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getCategoryIcon(),
                            size: 12,
                            color: _getCategoryColor(),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            todo.category,
                            style: AppTypography.labelSmall.copyWith(
                              color: _getCategoryColor(),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ...todo.tags.map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.info,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: AppSpacing.marginSmall),

            // Footer with priority, due date, and reminder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Priority badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getPriorityColor().withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        todo.priority,
                        style: AppTypography.labelSmall.copyWith(
                          color: _getPriorityColor(),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Reminder icon
                    if (todo.hasReminder)
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.notifications_active_rounded,
                          size: 14,
                          color: AppColors.accent,
                        ),
                      ),
                    // Due date
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: todo.isOverdue()
                          ? AppColors.error
                          : (todo.isDueToday()
                              ? AppColors.warning
                              : AppColors.textSecondary),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(todo.dueDate),
                      style: AppTypography.labelSmall.copyWith(
                        color: todo.isOverdue()
                            ? AppColors.error
                            : (todo.isDueToday()
                                ? AppColors.warning
                                : AppColors.textSecondary),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(DateTime(now.year, now.month, now.day));

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else if (difference.inDays == -1) {
      return 'Yesterday';
    } else if (difference.inDays < 0) {
      return 'Overdue';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
