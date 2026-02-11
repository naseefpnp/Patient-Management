import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/size_utils.dart';

class EmptyBookingState extends StatelessWidget {
  final String? title;
  final String? description;

  const EmptyBookingState({super.key, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeUtils.w(32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_outlined,
              size: SizeUtils.w(120),
              color: Colors.grey.shade300,
            ),
            SizedBox(height: SizeUtils.h(24)),
            Text(
              title ?? 'No Bookings Found',
              style: TextStyle(
                fontSize: SizeUtils.sp(20),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeUtils.h(12)),
            Text(
              description ??
                  'You don\'t have any bookings yet.\nStart booking your appointments now!',
              style: TextStyle(
                fontSize: SizeUtils.sp(14),
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
