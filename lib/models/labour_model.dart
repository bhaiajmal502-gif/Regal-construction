class LabourModel {
  final String id;
  final String workerName;
  final double hoursWorked;
  final double ratePerHour;
  final double grossAmount;
  final double advanceGiven;
  final double netAmount;
  final DateTime date;
  final String paymentMethod; // 'Cash', 'Bank Transfer', 'Cheque', 'Online'
  final String status; // 'Completed', 'Pending', 'Delayed'
  final String notes;

  LabourModel({
    required this.id,
    required this.workerName,
    required this.hoursWorked,
    required this.ratePerHour,
    required this.grossAmount,
    required this.advanceGiven,
    required this.netAmount,
    required this.date,
    required this.paymentMethod,
    this.status = 'Completed',
    this.notes = '',
  });

  factory LabourModel.fromJson(Map<String, dynamic> json) {
    return LabourModel(
      id: json['id'] as String,
      workerName: json['workerName'] as String,
      hoursWorked: json['hoursWorked'] as double,
      ratePerHour: json['ratePerHour'] as double,
      grossAmount: json['grossAmount'] as double,
      advanceGiven: json['advanceGiven'] as double,
      netAmount: json['netAmount'] as double,
      date: DateTime.parse(json['date'] as String),
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String? ?? 'Completed',
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerName': workerName,
      'hoursWorked': hoursWorked,
      'ratePerHour': ratePerHour,
      'grossAmount': grossAmount,
      'advanceGiven': advanceGiven,
      'netAmount': netAmount,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod,
      'status': status,
      'notes': notes,
    };
  }

  LabourModel copyWith({
    String? id,
    String? workerName,
    double? hoursWorked,
    double? ratePerHour,
    double? grossAmount,
    double? advanceGiven,
    double? netAmount,
    DateTime? date,
    String? paymentMethod,
    String? status,
    String? notes,
  }) {
    return LabourModel(
      id: id ?? this.id,
      workerName: workerName ?? this.workerName,
      hoursWorked: hoursWorked ?? this.hoursWorked,
      ratePerHour: ratePerHour ?? this.ratePerHour,
      grossAmount: grossAmount ?? this.grossAmount,
      advanceGiven: advanceGiven ?? this.advanceGiven,
      netAmount: netAmount ?? this.netAmount,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
