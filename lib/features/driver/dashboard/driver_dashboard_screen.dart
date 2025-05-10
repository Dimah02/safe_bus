import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/features/teacher/dashboard/trip_card.dart';
import 'package:safe_bus/features/teacher/dashboard/recent_trip_item.dart';
import 'package:safe_bus/features/teacher/models/trip.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  int _currentIndex = 1;
  late List<Trip> _allTrips;
  late Trip? _currentTrip;
  late Trip? _upcomingTrip;
  late List<Trip> _recentTrips;

  @override
  void initState() {
    super.initState();
    _loadTripData();
  }

  void _loadTripData() {
    final now = DateTime.now();

    _allTrips = [
      Trip(
        id: '1',
        zoneName: 'Zone Three',
        date: now,
        tripNumber: '129384',
        distance: 40,
        studentCount: 10,
        duration: const Duration(hours: 2, minutes: 30),
        status: TripStatus.current,
        startTime: now.add(const Duration(hours: 2, minutes: 30)),
      ),
      Trip(
        id: '2',
        zoneName: 'Zone Eight',
        date: now.add(const Duration(hours: 5)),
        tripNumber: '129385',
        distance: 35,
        studentCount: 12,
        duration: const Duration(hours: 2, minutes: 30),
        status: TripStatus.upcoming,
        startTime: now.add(const Duration(hours: 2, minutes: 30)),
      ),
      Trip(
        id: '3',
        zoneName: 'Zone One',
        date: DateTime(2024, 2, 6),
        tripNumber: '129384',
        distance: 40,
        studentCount: 10,
        duration: const Duration(hours: 2, minutes: 30),
        status: TripStatus.pending,
      ),
      Trip(
        id: '4',
        zoneName: 'Zone Three',
        date: DateTime(2024, 2, 6),
        tripNumber: '129384',
        distance: 40,
        studentCount: 10,
        duration: const Duration(hours: 2, minutes: 30),
        status: TripStatus.completed,
      ),
    ];

    _currentTrip = _allTrips.firstWhere(
      (trip) => trip.status == TripStatus.current,
      orElse: () => _allTrips.first,
    );

    _upcomingTrip = _allTrips.firstWhere(
      (trip) => trip.status == TripStatus.upcoming,
    );

    _recentTrips =
        _allTrips
            .where(
              (trip) =>
                  trip.status == TripStatus.completed ||
                  trip.status == TripStatus.pending,
            )
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildTripCardsSection(),
                const SizedBox(height: 30),
                _buildRecentTripsSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: TextStyle(
                fontSize: 16,
                color: KColors.darkGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Ahmad',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, size: 26),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTripCardsSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: KColors.greenSecondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CURRENT TRIP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                _currentTrip != null
                    ? TripCard(
                      trip: _currentTrip!,
                      isActive: true, // Keep green styling
                      onPressed: _navigateToAttendanceScreen,
                    )
                    : const EmptyTripCard(isActive: true),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'UPCOMING TRIP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),
                _upcomingTrip != null
                    ? TripCard(
                      trip: _upcomingTrip!,
                      isActive: false, // Keep grey styling
                      onPressed: _navigateToAttendanceScreen,
                    )
                    : const EmptyTripCard(isActive: false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTripsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Trips',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        if (_recentTrips.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(Icons.history, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 10),
                  Text(
                    'No recent trips found',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          )
        else
          ...List.generate(_recentTrips.length, (index) {
            final trip = _recentTrips[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: RecentTripItem(
                trip: trip,
                onDetailsPressed: _navigateToAttendanceScreen,
              ),
            );
          }),
      ],
    );
  }

  void _navigateToAttendanceScreen() {
    GoRouter.of(context).push(AppRouter.driverMap);
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(5, 0, 0, 0),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.view_list, 0),
          _buildNavItem(Icons.home, 1),
          _buildNavItem(Icons.more_horiz, 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
          size: 26,
        ),
      ),
    );
  }
}
