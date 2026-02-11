// lib/presentation/register/controller/register_controller.dart
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:patient_management/infrastructure/register_repository.dart';
import 'package:patient_management/presentation/home/model/branch.dart';
import 'package:patient_management/presentation/register/model/register_request.dart';
import 'package:patient_management/presentation/register/model/treatment.dart';
import 'package:patient_management/presentation/register/model/treatments_response.dart';

class RegisterController extends ChangeNotifier {
  final RegisterRepository _repository = RegisterRepository();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountAmountController =
      TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  final TextEditingController balanceAmountController = TextEditingController();

  String? selectedLocation;
  String? selectedBranch;
  String? selectedBranchId;
  String paymentOption = 'Cash';
  DateTime? treatmentDate;
  TimeOfDay? treatmentTime;

  List<Treatment> treatments = [];
  List<Branch> branches = [];
  List<TreatmentService> treatmentServices = [];

  bool _isLoading = false;
  bool _isSaving = false;

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;

  String? errorMessage;
  bool isRegistrationSuccess = false;

  void setLocation(String? value) {
    selectedLocation = value;
    notifyListeners();
  }

  void setBranch(String? value) {
    selectedBranch = value;
    selectedBranchId = branches
        .firstWhere((branch) => branch.name == value, orElse: () => Branch())
        .id
        ?.toString();
    notifyListeners();
  }

  void setPaymentOption(String value) {
    paymentOption = value;
    notifyListeners();
  }

  void setTreatmentDate(DateTime date) {
    treatmentDate = date;
    notifyListeners();
  }

  void setTreatmentTime(TimeOfDay time) {
    treatmentTime = time;
    notifyListeners();
  }

  void addTreatment(Treatment treatment) {
    treatments.add(treatment);
    notifyListeners();
  }

  void removeTreatment(int index) {
    treatments.removeAt(index);
    notifyListeners();
  }

  void updateTreatment(int index, Treatment treatment) {
    treatments[index] = treatment;
    notifyListeners();
  }

  Future<void> loadBranches() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _repository.loadBranches();
      branches = (response.data['branches'] as List)
          .map((json) => Branch.fromJson(json))
          .toList();

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load branches: $e';
      log(errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadTreatments() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _repository.loadTreatments();
      treatmentServices = (response.data['treatments'] as List)
          .map((json) => TreatmentService.fromJson(json))
          .toList();

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load treatments: $e';
      log(errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String? validateForm() {
    if (nameController.text.trim().isEmpty) return 'Please enter name';
    if (whatsappController.text.trim().isEmpty) {
      return 'Please enter WhatsApp number';
    }
    if (whatsappController.text.trim().length < 10) {
      return 'Please enter valid WhatsApp number';
    }
    if (addressController.text.trim().isEmpty) return 'Please enter address';
    if (selectedLocation == null) return 'Please select location';
    if (selectedBranch == null) return 'Please select branch';
    if (treatments.isEmpty) return 'Please add at least one treatment';
    if (totalAmountController.text.trim().isEmpty) {
      return 'Please enter total amount';
    }
    if (advanceAmountController.text.trim().isEmpty) {
      return 'Please enter advance amount';
    }
    if (treatmentDate == null) return 'Please select treatment date';
    if (treatmentTime == null) return 'Please select treatment time';
    return null;
  }

  String _formatDateTime(DateTime date, TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');

    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}-$hour:$minute $period';
  }

  Future<void> savePatient() async {
    final validationError = validateForm();
    if (validationError != null) {
      errorMessage = validationError;
      notifyListeners();
      return;
    }

    try {
      _isSaving = true;
      errorMessage = null;
      notifyListeners();

      final treatmentIds = <String>[];
      final maleCounts = <String>[];
      final femaleCounts = <String>[];

      for (var treatment in treatments) {
        final treatmentService = treatmentServices.firstWhere(
          (ts) => ts.name == treatment.name,
          orElse: () => TreatmentService(),
        );

        final treatmentId = treatmentService.id?.toString();
        if (treatmentId != null && treatmentId.isNotEmpty) {
          treatmentIds.add(treatmentId);
          maleCounts.add(treatment.male.toString());
          femaleCounts.add(treatment.female.toString());
        }
      }

      final formattedDateTime = _formatDateTime(treatmentDate!, treatmentTime!);

      final request = PatientBookingRequest(
        name: nameController.text.trim(),
        excecutive: '',
        id: '',
        payment: paymentOption,
        phone: whatsappController.text.trim(),
        address: addressController.text.trim(),
        totalAmount: double.tryParse(totalAmountController.text) ?? 0,
        discountAmount: double.tryParse(discountAmountController.text) ?? 0,
        advanceAmount: double.tryParse(advanceAmountController.text) ?? 0,
        balanceAmount: double.tryParse(balanceAmountController.text) ?? 0,
        dateAndTime: formattedDateTime,
        male: maleCounts.join(','),
        female: femaleCounts.join(','),
        treatments: treatmentIds.join(','),
        branch: selectedBranchId ?? '',
      );

      log('request data : ${jsonEncode(request.toJson())}');
      await _repository.register(requestdata: request);
      log('Patient registered successfully');

      isRegistrationSuccess = true;
    } catch (e) {
      errorMessage = 'Failed to register patient: $e';
      log(errorMessage!);
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    whatsappController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    advanceAmountController.dispose();
    balanceAmountController.dispose();
    super.dispose();
  }
}
