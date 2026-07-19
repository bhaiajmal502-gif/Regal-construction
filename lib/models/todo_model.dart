class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority; // 'Low', 'Medium', 'High', 'Urgent'
  final String category; // 'Work', 'Personal', 'Shopping', 'Health', 'Other'
  final bool isCompleted;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? reminderTime;
  final bool hasReminder;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.priority = 'Medium',
    this.category = 'Other',
    this.isCompleted = false,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
    this.reminderTime,
    this.hasReminder = false,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: json['priority'] as String? ?? 'Medium',
      category: json['category'] as String? ?? 'Other',
      isCompleted: json['isCompleted'] as bool? ?? false,
      tags: List<String>.from(json['tags'] as List? ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      reminderTime: json['reminderTime'] as String?,
      hasReminder: json['hasReminder'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'category': category,
      'isCompleted': isCompleted,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'reminderTime': reminderTime,
      'hasReminder': hasReminder,
    };
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? priority,
    String? category,
    bool? isCompleted,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? reminderTime,
    bool? hasReminder,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reminderTime: reminderTime ?? this.reminderTime,
      hasReminder: hasReminder ?? this.hasReminder,
    );
  }

  bool isOverdue() {
    return !isCompleted && dueDate.isBefore(DateTime.now());
  }

  bool isDueToday() {
    final now = DateTime.now();
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }

  bool isDueTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return dueDate.year == tomorrow.year &&
        dueDate.month == tomorrow.month &&
        dueDate.day == tomorrow.day;
  }
}
