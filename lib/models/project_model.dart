class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final double totalBudget;
  final double spentAmount;
  final String status; // 'Active', 'Completed', 'On Hold'
  final String managerName;
  final String managerContact;
  final List<String> teamMembers;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.totalBudget,
    required this.spentAmount,
    this.status = 'Active',
    required this.managerName,
    required this.managerContact,
    this.teamMembers = const [],
  });

  double get remainingBudget => totalBudget - spentAmount;
  double get budgetPercentage => (spentAmount / totalBudget) * 100;
  int get daysElapsed => DateTime.now().difference(startDate).inDays;

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      totalBudget: json['totalBudget'] as double,
      spentAmount: json['spentAmount'] as double,
      status: json['status'] as String? ?? 'Active',
      managerName: json['managerName'] as String,
      managerContact: json['managerContact'] as String,
      teamMembers: List<String>.from(json['teamMembers'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'totalBudget': totalBudget,
      'spentAmount': spentAmount,
      'status': status,
      'managerName': managerName,
      'managerContact': managerContact,
      'teamMembers': teamMembers,
    };
  }

  ProjectModel copyWith({
    String? id,
    String? name,
    String? description,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    double? totalBudget,
    double? spentAmount,
    String? status,
    String? managerName,
    String? managerContact,
    List<String>? teamMembers,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalBudget: totalBudget ?? this.totalBudget,
      spentAmount: spentAmount ?? this.spentAmount,
      status: status ?? this.status,
      managerName: managerName ?? this.managerName,
      managerContact: managerContact ?? this.managerContact,
      teamMembers: teamMembers ?? this.teamMembers,
    );
  }
}
