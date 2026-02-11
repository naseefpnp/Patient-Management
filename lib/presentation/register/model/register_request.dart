class PatientBookingRequest {
  final String name;
  final String excecutive;
  final String payment;
  final String phone;
  final String address;

  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;

  final String dateAndTime;
  final String id;

  final String male;
  final String female;
  final String treatments;
  final String branch;

  PatientBookingRequest({
    required this.name,
    required this.excecutive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    this.id = '',
    required this.male,
    required this.female,
    required this.treatments,
    required this.branch,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'excecutive': excecutive,
      'payment': payment,
      'phone': phone,
      'address': address,
      'total_amount': totalAmount.toInt(),
      'discount_amount': discountAmount.toInt(),
      'advance_amount': advanceAmount.toInt(),
      'balance_amount': balanceAmount.toInt(),
      'date_nd_time': dateAndTime,
      'id': id,
      'male': male,
      'female': female,
      'branch': branch,
      'treatments': treatments,
    };
  }
}
