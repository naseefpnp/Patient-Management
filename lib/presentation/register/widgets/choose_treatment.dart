import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/size_utils.dart';
import 'package:patient_management/presentation/register/controller/register_controller.dart';
import 'package:patient_management/presentation/register/model/treatment.dart';

class ChooseTreatmentSheet extends StatefulWidget {
  final RegisterController controller;
  final Treatment? treatment;
  final int? index;

  const ChooseTreatmentSheet({
    super.key,
    required this.controller,
    this.treatment,
    this.index,
  });

  @override
  State<ChooseTreatmentSheet> createState() => _ChooseTreatmentSheetState();
}

class _ChooseTreatmentSheetState extends State<ChooseTreatmentSheet> {
  String? selectedTreatment;
  int maleCount = 0;
  int femaleCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.treatment != null) {
      selectedTreatment = widget.treatment!.name;
      maleCount = widget.treatment!.male;
      femaleCount = widget.treatment!.female;
    }
  }

  void _increment(bool isMale) {
    setState(() {
      if (isMale) {
        maleCount++;
      } else {
        femaleCount++;
      }
    });
  }

  void _decrement(bool isMale) {
    setState(() {
      if (isMale && maleCount > 0) {
        maleCount--;
      } else if (!isMale && femaleCount > 0) {
        femaleCount--;
      }
    });
  }

  void _save() {
    if (selectedTreatment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a treatment')),
      );
      return;
    }

    final treatment = Treatment(
      name: selectedTreatment!,
      male: maleCount,
      female: femaleCount,
    );

    if (widget.index != null) {
      widget.controller.updateTreatment(widget.index!, treatment);
    } else {
      widget.controller.addTreatment(treatment);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeUtils.w(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SizeUtils.w(20)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Treatment',
            style: TextStyle(
              fontSize: SizeUtils.sp(18),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: SizeUtils.h(20)),
          Container(
            height: SizeUtils.h(48),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(SizeUtils.w(8)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedTreatment,
                hint: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeUtils.w(14)),
                  child: Text(
                    'Choose preferred treatment',
                    style: TextStyle(
                      fontSize: SizeUtils.sp(12),
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                isExpanded: true,
                icon: Padding(
                  padding: EdgeInsets.only(right: SizeUtils.w(14)),
                  child: Icon(Icons.keyboard_arrow_down, size: SizeUtils.w(20)),
                ),
                items: widget.controller.treatmentServices
                    .map((service) => service.name ?? '')
                    .toSet()
                    .toList()
                    .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeUtils.w(14),
                          ),
                          child: Text(
                            value,
                            style: TextStyle(fontSize: SizeUtils.sp(14)),
                          ),
                        ),
                      );
                    })
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTreatment = newValue;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: SizeUtils.h(20)),
          Text(
            'Add Patients',
            style: TextStyle(
              fontSize: SizeUtils.sp(14),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: SizeUtils.h(12)),
          _buildPatientCounter('Male', maleCount, true),
          SizedBox(height: SizeUtils.h(12)),
          _buildPatientCounter('Female', femaleCount, false),
          SizedBox(height: SizeUtils.h(24)),
          SizedBox(
            width: double.infinity,
            height: SizeUtils.h(48),
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A7C3A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeUtils.w(8)),
                ),
                elevation: 0,
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: SizeUtils.sp(15),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildPatientCounter(String label, int count, bool isMale) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: SizeUtils.sp(14),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          width: SizeUtils.w(32),
          height: SizeUtils.h(32),
          decoration: BoxDecoration(
            color: const Color(0xFF0A7C3A),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.remove,
              color: Colors.white,
              size: SizeUtils.w(16),
            ),
            onPressed: () => _decrement(isMale),
          ),
        ),
        SizedBox(width: SizeUtils.w(12)),
        Container(
          width: SizeUtils.w(40),
          height: SizeUtils.h(32),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(SizeUtils.w(6)),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: SizeUtils.sp(14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: SizeUtils.w(12)),
        Container(
          width: SizeUtils.w(32),
          height: SizeUtils.h(32),
          decoration: BoxDecoration(
            color: const Color(0xFF0A7C3A),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.add, color: Colors.white, size: SizeUtils.w(16)),
            onPressed: () => _increment(isMale),
          ),
        ),
      ],
    );
  }
}
