class DailyWorkModel {
  final String id;
  final String workerName;
  final String taskDescription;
  final String location;
  final double hoursWorked;
  final DateTime date;
  final String status; // 'Completed', 'In Progress', 'Pending Review'
  final List<String> attachments;
  final String supervisorApproval;
  final String notes;

  DailyWorkModel({
    required this.id,
    required this.workerName,
    required this.taskDescription,
    required this.location,
    required this.hoursWorked,
    required this.date,
    this.status = 'In Progress',
    this.attachments = const [],
    this.supervisorApproval = 'Pending',
    this.notes = '',
  });

  factory DailyWorkModel.fromJson(Map<String, dynamic> json) {
    return DailyWorkModel(
      id: json['id'] as String,
      workerName: json['workerName'] as String,
      taskDescription: json['taskDescription'] as String,
      location: json['location'] as String,
      hoursWorked: json['hoursWorked'] as double,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String? ?? 'In Progress',
      attachments: List<String>.from(json['attachments'] as List? ?? []),
      supervisorApproval: json['supervisorApproval'] as String? ?? 'Pending',
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerName': workerName,
      'taskDescription': taskDescription,
      'location': location,
      'hoursWorked': hoursWorked,
      'date': date.toIso8601String(),
      'status': status,
      'attachments': attachments,
      'supervisorApproval': supervisorApproval,
      'notes': notes,
    };
  }

  DailyWorkModel copyWith({
    String? id,
    String? workerName,
    String? taskDescription,
    String? location,
    double? hoursWorked,
    DateTime? date,
    String? status,
    List<String>? attachments,
    String? supervisorApproval,
    String? notes,
  }) {
    return DailyWorkModel(
      id: id ?? this.id,
      workerName: workerName ?? this.workerName,
      taskDescription: taskDescription ?? this.taskDescription,
      location: location ?? this.location,
      hoursWorked: hoursWorked ?? this.hoursWorked,
      date: date ?? this.date,
      status: status ?? this.status,
      attachments: attachments ?? this.attachments,
      supervisorApproval: supervisorApproval ?? this.supervisorApproval,
      notes: notes ?? this.notes,
    );
  }
}
