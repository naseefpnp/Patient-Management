import 'package:patient_management/presentation/home/model/branch.dart';
import 'package:patient_management/presentation/home/model/patient_details.dart';

class PatientBookingModel {
  final int? id;
  final List<PatientDetails>? patientDetailsSet;
  final Branch? branch;
  final String? user;
  final String? payment;
  final String? name;
  final String? phone;
  final String? address;
  final double? price;
  final double? totalAmount;
  final double? discountAmount;
  final double? advanceAmount;
  final double? balanceAmount;
  final DateTime? dateAndTime;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientBookingModel({
    this.id,
    this.patientDetailsSet,
    this.branch,
    this.user,
    this.payment,
    this.name,
    this.phone,
    this.address,
    this.price,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateAndTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientBookingModel.fromJson(Map<String, dynamic> json) {
    return PatientBookingModel(
      id: json['id'],
      patientDetailsSet: (json['patientdetails_set'] as List?)
          ?.map((e) => PatientDetails.fromJson(e))
          .toList(),
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
      user: json['user'],
      payment: json['payment'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      price: (json['price'] as num?)?.toDouble(),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      advanceAmount: (json['advance_amount'] as num?)?.toDouble(),
      balanceAmount: (json['balance_amount'] as num?)?.toDouble(),
      dateAndTime: json['date_nd_time'] != null
          ? DateTime.parse(json['date_nd_time'])
          : null,
      isActive: json['is_active'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientdetails_set': patientDetailsSet?.map((e) => e.toJson()).toList(),
      'branch': branch?.toJson(),
      'user': user,
      'payment': payment,
      'name': name,
      'phone': phone,
      'address': address,
      'price': price,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': dateAndTime?.toIso8601String(),
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
