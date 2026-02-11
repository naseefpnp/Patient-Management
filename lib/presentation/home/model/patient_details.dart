class PatientDetails {
  final int? id;
  final String? male;
  final String? female;
  final int? patient;
  final int? treatment;
  final String? treatmentName;

  PatientDetails({
    this.id,
    this.male,
    this.female,
    this.patient,
    this.treatment,
    this.treatmentName,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      id: json['id'],
      male: json['male'],
      female: json['female'],
      patient: json['patient'],
      treatment: json['treatment'],
      treatmentName: json['treatment_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'male': male,
      'female': female,
      'patient': patient,
      'treatment': treatment,
      'treatment_name': treatmentName,
    };
  }
}
