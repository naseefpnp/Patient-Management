import 'package:patient_management/presentation/home/model/branch.dart';

class TreatmentService {
  final int? id;
  final List<Branch>? branches;
  final String? name;
  final String? duration;
  final String? price;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  TreatmentService({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory TreatmentService.fromJson(Map<String, dynamic> json) {
    return TreatmentService(
      id: json['id'] as int?,
      branches: (json['branches'] as List<dynamic>?)
          ?.map((item) => Branch.fromJson(item as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      duration: json['duration'] as String?,
      price: json['price'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branches': branches?.map((branch) => branch.toJson()).toList(),
      'name': name,
      'duration': duration,
      'price': price,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
