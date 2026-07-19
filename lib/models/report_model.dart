class ReportModel {
  final String id;
  final String projectId;
  final String projectName;
  final DateTime reportDate;
  final double totalMaterialCost;
  final double totalLabourCost;
  final double totalExpenses;
  final int totalWorkers;
  final double totalWorkingHours;
  final List<MaterialBreakdown> materialBreakdown;
  final String generatedBy;
  final String period; // 'Daily', 'Weekly', 'Monthly'

  ReportModel({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.reportDate,
    required this.totalMaterialCost,
    required this.totalLabourCost,
    required this.totalExpenses,
    required this.totalWorkers,
    required this.totalWorkingHours,
    required this.materialBreakdown,
    required this.generatedBy,
    this.period = 'Monthly',
  });

  double get grandTotal => totalMaterialCost + totalLabourCost + totalExpenses;

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      projectName: json['projectName'] as String,
      reportDate: DateTime.parse(json['reportDate'] as String),
      totalMaterialCost: json['totalMaterialCost'] as double,
      totalLabourCost: json['totalLabourCost'] as double,
      totalExpenses: json['totalExpenses'] as double,
      totalWorkers: json['totalWorkers'] as int,
      totalWorkingHours: json['totalWorkingHours'] as double,
      materialBreakdown: (json['materialBreakdown'] as List)
          .map((e) => MaterialBreakdown.fromJson(e))
          .toList(),
      generatedBy: json['generatedBy'] as String,
      period: json['period'] as String? ?? 'Monthly',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'projectName': projectName,
      'reportDate': reportDate.toIso8601String(),
      'totalMaterialCost': totalMaterialCost,
      'totalLabourCost': totalLabourCost,
      'totalExpenses': totalExpenses,
      'totalWorkers': totalWorkers,
      'totalWorkingHours': totalWorkingHours,
      'materialBreakdown': materialBreakdown.map((e) => e.toJson()).toList(),
      'generatedBy': generatedBy,
      'period': period,
    };
  }
}

class MaterialBreakdown {
  final String materialName;
  final double quantity;
  final String unit;
  final double unitPrice;
  final double totalCost;

  MaterialBreakdown({
    required this.materialName,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    required this.totalCost,
  });

  factory MaterialBreakdown.fromJson(Map<String, dynamic> json) {
    return MaterialBreakdown(
      materialName: json['materialName'] as String,
      quantity: json['quantity'] as double,
      unit: json['unit'] as String,
      unitPrice: json['unitPrice'] as double,
      totalCost: json['totalCost'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materialName': materialName,
      'quantity': quantity,
      'unit': unit,
      'unitPrice': unitPrice,
      'totalCost': totalCost,
    };
  }
}
