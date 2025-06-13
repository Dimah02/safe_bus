import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import '../../../data/models/teacher_home/trip.dart';

class RecentTripItem extends StatelessWidget {
  final Trip trip;
  final VoidCallback onDetailsPressed;

  const RecentTripItem({
    super.key,
    required this.trip,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = trip.status!.color;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip.zoneName!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
          const SizedBox(height: 5),
          _buildInfoRow(Icons.access_time, trip.getFormattedDate()),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildInfoRow(Icons.tag, trip.tripNumber!)),
              Expanded(
                child: _buildInfoRow(
                  Icons.route,
                  '${trip.distance!.toInt()} Km',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(
                  Icons.directions_bus_filled_sharp,
                  "Bus ${trip.bus?.busNumber ?? ''}",
                ),
              ),
              Expanded(
                child: _buildInfoRow(
                  Icons.person,
                  "Driver ${trip.driver?.name ?? ''}",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildInfoRow(
                  Icons.people,
                  '${trip.studentCount} Students',
                ),
              ),
              Expanded(
                child: _buildInfoRow(Icons.timer, trip.getDurationString()),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge("Completed", KColors.fontBlue),
              // _buildDetailsButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade700),
        const SizedBox(width: 5),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 13,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDetailsButton() {
    return TextButton.icon(
      onPressed: onDetailsPressed,
      icon: const Text(
        'Details',
        style: TextStyle(fontSize: 14, color: Colors.blue),
      ),
      label: const Icon(Icons.chevron_right, size: 18, color: Colors.blue),
    );
  }
}
