// lib/presentation/home/controller/controller.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patient_management/infrastructure/home_repository.dart';
import 'package:patient_management/presentation/home/model/patients_response.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository _repo = HomeRepository();

  List<PatientBookingModel> patients = [];
  List<PatientBookingModel> filteredPatients = [];
  bool isLoading = false;
  String? errorMessage;
  String sortBy = 'Date';
  String searchQuery = '';

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchPatients() async {
    _setLoading(true);
    errorMessage = null;

    try {
      final res = await _repo.listPatients();
      final data = res.data;

      if (data['status'] == true && data['patient'] != null) {
        patients =
            (data['patient'] as List?)
                ?.map((e) => PatientBookingModel.fromJson(e))
                .toList() ??
            [];
        filteredPatients = List.from(patients);
        _applySorting();
      } else {
        errorMessage = data['message'] ?? 'Failed to load patients';
      }
    } on DioException catch (e) {
      errorMessage = e.response?.data['message'] ?? 'Network error';
    } catch (e) {
      errorMessage = 'Something went wrong';
    }

    _setLoading(false);
  }

  void searchPatients(String query) {
    searchQuery = query.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredPatients = List.from(patients);
    } else {
      filteredPatients = patients.where((patient) {
        final name = (patient.name ?? '').toLowerCase();
        final treatments = getTreatmentNames(patient).toLowerCase();
        final branch = (patient.branch?.name ?? '').toLowerCase();

        return name.contains(searchQuery) ||
            treatments.contains(searchQuery) ||
            branch.contains(searchQuery);
      }).toList();
    }

    _applySorting();
    notifyListeners();
  }

  void setSortBy(String value) {
    sortBy = value;
    _applySorting();
    notifyListeners();
  }

  void _applySorting() {
    switch (sortBy) {
      case 'Date':
        filteredPatients.sort((a, b) {
          if (a.dateAndTime == null && b.dateAndTime == null) return 0;
          if (a.dateAndTime == null) return 1;
          if (b.dateAndTime == null) return -1;
          return b.dateAndTime!.compareTo(a.dateAndTime!);
        });
        break;
      case 'Name':
        filteredPatients.sort((a, b) {
          final nameA = (a.name ?? '').toLowerCase();
          final nameB = (b.name ?? '').toLowerCase();
          return nameA.compareTo(nameB);
        });
        break;
      case 'Time':
        filteredPatients.sort((a, b) {
          if (a.dateAndTime == null && b.dateAndTime == null) return 0;
          if (a.dateAndTime == null) return 1;
          if (b.dateAndTime == null) return -1;
          return a.dateAndTime!.compareTo(b.dateAndTime!);
        });
        break;
    }
  }

  String getTreatmentNames(PatientBookingModel patient) {
    final details = patient.patientDetailsSet;
    if (details == null || details.isEmpty) return 'No treatment';

    return details
        .map((detail) => detail.treatmentName ?? '')
        .where((name) => name.isNotEmpty)
        .join(', ');
  }

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return '--/--/----';
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  String formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '${hour}h:${minute}min';
  }

  bool get hasPatients => filteredPatients.isNotEmpty;

  @override
  void dispose() {
    patients.clear();
    filteredPatients.clear();
    super.dispose();
  }
}
