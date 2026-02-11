import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/app_route.dart';
import 'package:patient_management/core/utils/size_utils.dart';
import 'package:patient_management/presentation/home/controller/home_controller.dart';
import 'package:patient_management/presentation/home/widgets/booking_card.dart';
import 'package:patient_management/presentation/home/widgets/booking_card_shimmer.dart';
import 'package:patient_management/presentation/home/widgets/empty_card.dart';
import 'package:patient_management/presentation/widgets/elevated_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.fetchPatients();
  }

  @override
  void dispose() {
    _searchController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await controller.fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.pop(context),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          if (controller.errorMessage != null && controller.patients.isEmpty) {
            return _buildErrorState();
          }

          return Column(
            children: [
              _buildHeader(),
              SizedBox(height: SizeUtils.h(16)),
              Expanded(child: _buildPatientsList()),
              if (controller.hasPatients) _buildRegisterButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeUtils.w(32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: SizeUtils.w(64),
              color: Colors.red.shade300,
            ),
            SizedBox(height: SizeUtils.h(16)),
            Text(
              controller.errorMessage!,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: SizeUtils.sp(16),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeUtils.h(24)),
            ElevatedButton(
              onPressed: controller.fetchPatients,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A7C3A),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.w(32),
                  vertical: SizeUtils.h(12),
                ),
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontSize: SizeUtils.sp(14),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeUtils.w(16)),
      child: Column(
        children: [
          SizedBox(height: SizeUtils.h(8)),
          _buildSearchBar(),
          SizedBox(height: SizeUtils.h(16)),
          _buildSortByFilter(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: SizeUtils.h(48),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(SizeUtils.w(8)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: controller.searchPatients,
              decoration: InputDecoration(
                hintText: 'Search for treatments',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: SizeUtils.sp(14),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: SizeUtils.w(20),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.w(12),
                  vertical: SizeUtils.h(12),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: SizeUtils.w(12)),
        InkWell(
          onTap: () => controller.searchPatients(_searchController.text),
          child: Container(
            height: SizeUtils.h(48),
            width: SizeUtils.w(90),
            decoration: BoxDecoration(
              color: const Color(0xFF0A7C3A),
              borderRadius: BorderRadius.circular(SizeUtils.w(8)),
            ),
            child: Center(
              child: Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeUtils.sp(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSortByFilter() {
    return Row(
      children: [
        Text(
          'Sort by :',
          style: TextStyle(
            fontSize: SizeUtils.sp(14),
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),
        Container(
          height: SizeUtils.h(40),
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.w(12)),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(SizeUtils.w(24)),
          ),
          child: DropdownButton<String>(
            value: controller.sortBy,
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, size: SizeUtils.w(20)),
            items: ['Date', 'Name', 'Time'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: SizeUtils.sp(14)),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {},
          ),
        ),
      ],
    );
  }

  Widget _buildPatientsList() {
    if (controller.isLoading) {
      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.w(16)),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: SizeUtils.h(12)),
        itemBuilder: (context, index) {
          return const BookingCardShimmer();
        },
      );
    }

    if (!controller.hasPatients) {
      return RefreshIndicator(
        color: const Color(0xFF0A7C3A),
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: const EmptyBookingState(),
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: const Color(0xFF0A7C3A),
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: SizeUtils.w(16)),
        itemCount: controller.filteredPatients.length,
        separatorBuilder: (context, index) => SizedBox(height: SizeUtils.h(12)),
        itemBuilder: (context, index) {
          final patient = controller.filteredPatients[index];
          return BookingCard(
            number: index + 1,
            patientName: patient.name ?? 'Unknown',
            packageName: controller.getTreatmentNames(patient),
            date: controller.formatDate(patient.dateAndTime),
            time: controller.formatTime(patient.dateAndTime),
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.all(SizeUtils.w(16)),
      child: SizedBox(
        width: double.infinity,
        height: SizeUtils.h(48),
        child: CustomElevatedButton(
          label: 'Register Now',
          isLoading: false,
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              AppRoutes.register,
            );

            if (result == true) {
              controller.fetchPatients();
            }
          },
        ),
      ),
    );
  }
}
