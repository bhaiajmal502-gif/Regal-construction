class MaterialModel {
  final String id;
  final String name;
  final String category;
  final double quantity;
  final String unit;
  final double unitPrice;
  final double totalPrice;
  final DateTime date;
  final String notes;
  final String status; // 'Received', 'Pending', 'Damaged'

  MaterialModel({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    required this.totalPrice,
    required this.date,
    required this.notes,
    this.status = 'Received',
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      quantity: json['quantity'] as double,
      unit: json['unit'] as String,
      unitPrice: json['unitPrice'] as double,
      totalPrice: json['totalPrice'] as double,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String,
      status: json['status'] as String? ?? 'Received',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'unit': unit,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'date': date.toIso8601String(),
      'notes': notes,
      'status': status,
    };
  }

  MaterialModel copyWith({
    String? id,
    String? name,
    String? category,
    double? quantity,
    String? unit,
    double? unitPrice,
    double? totalPrice,
    DateTime? date,
    String? notes,
    String? status,
  }) {
    return MaterialModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
