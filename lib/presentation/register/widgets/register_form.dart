import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/size_utils.dart';
import 'package:patient_management/presentation/register/controller/register_controller.dart';
import 'package:patient_management/presentation/register/model/treatment.dart';
import 'package:patient_management/presentation/register/widgets/choose_treatment.dart';
import 'package:patient_management/presentation/widgets/elevated_button.dart';
import 'package:patient_management/presentation/widgets/text_field.dart';

class RegisterForm extends StatelessWidget {
  final RegisterController controller;

  const RegisterForm({super.key, required this.controller});

  void _showChooseTreatmentSheet(
    BuildContext context, {
    Treatment? treatment,
    int? index,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChooseTreatmentSheet(
        controller: controller,
        treatment: treatment,
        index: index,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.treatmentDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0A7C3A)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.setTreatmentDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context, bool isHour) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.treatmentTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0A7C3A)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.setTreatmentTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(SizeUtils.w(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                labelText: 'Name',
                hintText: 'Enter your full name',
                controller: controller.nameController,
              ),
              SizedBox(height: SizeUtils.h(16)),
              AppTextField(
                labelText: 'Whatsapp Number',
                hintText: 'Enter your WhatsApp number',
                controller: controller.whatsappController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: SizeUtils.h(16)),
              AppTextField(
                labelText: 'Address',
                hintText: 'Enter your full address',
                controller: controller.addressController,
                maxLines: 3,
              ),
              SizedBox(height: SizeUtils.h(16)),
              _buildDropdownField(
                label: 'Location',
                hint: 'Choose your location',
                value: controller.selectedLocation,
                items: ['Kozhikode', 'Malappuram', 'Kannur', 'Wayanad'],
                onChanged: controller.setLocation,
              ),
              SizedBox(height: SizeUtils.h(16)),
              _buildDropdownField(
                label: 'Branch',
                hint: 'Select the branch',
                value: controller.selectedBranch,
                items: controller.branches
                    .map((b) => b.name ?? '')
                    .toSet()
                    .toList(),
                onChanged: controller.setBranch,
              ),
              SizedBox(height: SizeUtils.h(16)),
              Text(
                'Treatments',
                style: TextStyle(
                  fontSize: SizeUtils.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: SizeUtils.h(8)),
              ...List.generate(
                controller.treatments.length,
                (index) => _buildTreatmentCard(context, index),
              ),
              SizedBox(height: SizeUtils.h(8)),
              InkWell(
                onTap: () => _showChooseTreatmentSheet(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: SizeUtils.h(14)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(SizeUtils.w(8)),
                  ),
                  child: Center(
                    child: Text(
                      '+ Add Treatments',
                      style: TextStyle(
                        fontSize: SizeUtils.sp(14),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0A7C3A),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeUtils.h(16)),
              AppTextField(
                labelText: 'Total Amount',
                hintText: '',
                controller: controller.totalAmountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: SizeUtils.h(16)),
              AppTextField(
                labelText: 'Discount Amount',
                hintText: '',
                controller: controller.discountAmountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: SizeUtils.h(16)),
              Text(
                'Payment Option',
                style: TextStyle(
                  fontSize: SizeUtils.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: SizeUtils.h(8)),
              Row(
                children: [
                  _buildPaymentOption('Cash'),
                  SizedBox(width: SizeUtils.w(12)),
                  _buildPaymentOption('Card'),
                  SizedBox(width: SizeUtils.w(12)),
                  _buildPaymentOption('UPI'),
                ],
              ),
              SizedBox(height: SizeUtils.h(16)),
              AppTextField(
                labelText: 'Advance Amount',
                hintText: '',
                controller: controller.advanceAmountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: SizeUtils.h(16)),
              AppTextField(
                labelText: 'Balance Amount',
                hintText: '',
                controller: controller.balanceAmountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: SizeUtils.h(16)),
              AppTextField(
                labelText: 'Treatment Date',
                hintText: controller.treatmentDate != null
                    ? '${controller.treatmentDate!.day}/${controller.treatmentDate!.month}/${controller.treatmentDate!.year}'
                    : '',
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  size: SizeUtils.w(18),
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: SizeUtils.h(16)),
              Text(
                'Treatment Time',
                style: TextStyle(
                  fontSize: SizeUtils.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: SizeUtils.h(8)),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: SizeUtils.h(48),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(SizeUtils.w(8)),
                      ),
                      child: InkWell(
                        onTap: () => _selectTime(context, true),
                        child: Center(
                          child: Text(
                            controller.treatmentTime != null
                                ? controller.treatmentTime!.format(context)
                                : 'Hour',
                            style: TextStyle(
                              fontSize: SizeUtils.sp(12),
                              color: controller.treatmentTime != null
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeUtils.w(12)),
                  Expanded(
                    child: Container(
                      height: SizeUtils.h(48),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(SizeUtils.w(8)),
                      ),
                      child: InkWell(
                        onTap: () => _selectTime(context, false),
                        child: Center(
                          child: Text(
                            controller.treatmentTime != null
                                ? '${controller.treatmentTime!.minute} min'
                                : 'Minutes',
                            style: TextStyle(
                              fontSize: SizeUtils.sp(12),
                              color: controller.treatmentTime != null
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeUtils.h(24)),
              SizedBox(
                width: double.infinity,
                height: SizeUtils.h(48),
                child: CustomElevatedButton(
                  label: 'Save',
                  isLoading: controller.isSaving,
                  onPressed: controller.isSaving
                      ? null
                      : controller.savePatient,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: SizeUtils.sp(14),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: SizeUtils.h(8)),
        Container(
          height: SizeUtils.h(48),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(SizeUtils.w(8)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils.w(14)),
                child: Text(
                  hint,
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
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeUtils.w(14)),
                    child: Text(
                      item,
                      style: TextStyle(fontSize: SizeUtils.sp(14)),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String option) {
    final isSelected = controller.paymentOption == option;
    return Expanded(
      child: InkWell(
        onTap: () => controller.setPaymentOption(option),
        child: Container(
          height: SizeUtils.h(40),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0A7C3A) : Colors.white,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF0A7C3A)
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(SizeUtils.w(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeUtils.w(16),
                height: SizeUtils.h(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.grey.shade400,
                    width: 2,
                  ),
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: SizeUtils.w(8),
                          height: SizeUtils.h(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0A7C3A),
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: SizeUtils.w(6)),
              Text(
                option,
                style: TextStyle(
                  fontSize: SizeUtils.sp(13),
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTreatmentCard(BuildContext context, int index) {
    final treatment = controller.treatments[index];
    return Container(
      margin: EdgeInsets.only(bottom: SizeUtils.h(8)),
      padding: EdgeInsets.all(SizeUtils.w(12)),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(SizeUtils.w(8)),
      ),
      child: Row(
        children: [
          Text(
            '${index + 1}.',
            style: TextStyle(
              fontSize: SizeUtils.sp(14),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: SizeUtils.w(8)),
          Expanded(
            child: Text(
              treatment.name,
              style: TextStyle(
                fontSize: SizeUtils.sp(14),
                color: const Color(0xFF0A7C3A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildGenderBadge('Male', treatment.male),
          SizedBox(width: SizeUtils.w(8)),
          _buildGenderBadge('Female', treatment.female),
          SizedBox(width: SizeUtils.w(8)),
          InkWell(
            onTap: () => _showChooseTreatmentSheet(
              context,
              treatment: treatment,
              index: index,
            ),
            child: Icon(
              Icons.edit_outlined,
              size: SizeUtils.w(18),
              color: const Color(0xFF0A7C3A),
            ),
          ),
          SizedBox(width: SizeUtils.w(8)),
          InkWell(
            onTap: () => controller.removeTreatment(index),
            child: Icon(Icons.close, size: SizeUtils.w(18), color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderBadge(String label, int count) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.w(8),
        vertical: SizeUtils.h(4),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeUtils.w(4)),
      ),
      child: Text(
        '$label $count',
        style: TextStyle(
          fontSize: SizeUtils.sp(12),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
