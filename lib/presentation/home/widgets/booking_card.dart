import 'package:flutter/material.dart';
import 'package:patient_management/core/utils/size_utils.dart';

class BookingCard extends StatelessWidget {
  final int number;
  final String patientName;
  final String packageName;
  final String date;
  final String time;
  final VoidCallback? onTap;

  const BookingCard({
    super.key,
    required this.number,
    required this.patientName,
    required this.packageName,
    required this.date,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeUtils.w(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(SizeUtils.w(12)),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$number.',
                style: TextStyle(
                  fontSize: SizeUtils.sp(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: SizeUtils.w(8)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: TextStyle(
                        fontSize: SizeUtils.sp(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: SizeUtils.h(4)),
                    Text(
                      packageName,
                      style: TextStyle(
                        fontSize: SizeUtils.sp(14),
                        color: const Color(0xFF0A7C3A),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.h(12)),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: SizeUtils.w(16),
                color: Colors.red,
              ),
              SizedBox(width: SizeUtils.w(6)),
              Text(
                date,
                style: TextStyle(
                  fontSize: SizeUtils.sp(14),
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: SizeUtils.w(24)),
              Icon(Icons.access_time, size: SizeUtils.w(16), color: Colors.red),
              SizedBox(width: SizeUtils.w(6)),
              Text(
                time,
                style: TextStyle(
                  fontSize: SizeUtils.sp(14),
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.h(12)),
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View Booking details',
                  style: TextStyle(
                    fontSize: SizeUtils.sp(14),
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: SizeUtils.w(14),
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
