import 'package:flutter/material.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/styles/sizes.dart';
import '../../../data/models/teacher_home/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final bool isActive;
  final VoidCallback onPressed;

  const TripCard({
    super.key,
    required this.trip,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          trip.zoneName!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
        Text(
          trip.getTimeLeftString(),
          style: TextStyle(
            fontSize: 14,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: KSizes.spaceBtwItems),
        Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isActive
                      ? const Color.fromARGB(88, 255, 255, 255)
                      : Colors.grey.shade300,
              foregroundColor: isActive ? Colors.white : Colors.grey,
              minimumSize: const Size(120, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Trip Details', style: TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }
}

class EmptyTripCard extends StatelessWidget {
  final bool isActive;

  const EmptyTripCard({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isActive ? KColors.greenSecondary : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_bus_outlined,
            size: 36,
            color: isActive ? Colors.white : Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            'No trip scheduled',
            style: TextStyle(
              fontSize: 14,
              color: isActive ? Colors.white : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
