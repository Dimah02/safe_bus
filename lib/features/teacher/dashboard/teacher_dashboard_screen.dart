import 'package:flutter/material.dart';
import 'package:safe_bus/features/teacher/dashboard/trip_card.dart';
import 'package:safe_bus/features/teacher/dashboard/recent_trip_item.dart';
import 'package:safe_bus/features/teacher/dashboard/trip_tab_selector.dart';

import '../attendance_overview/attendance_overview_screen.dart';
import '../models/trip.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  int _currentIndex = 1;
  late List<Trip> _allTrips;
  late Trip? _currentTrip;
  late Trip? _upcomingTrip;
  late List<Trip> _recentTrips;
  bool _isCurrentTabSelected = true;

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
              horizontal: 20.0,
              vertical: 10.0,
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
                color: Colors.black.withOpacity(0.7),
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
    return Column(
      children: [
        TabSelector(
          tabs: const ['CURRENT TRIP', 'UPCOMING TRIP'],
          selectedIndex: _isCurrentTabSelected ? 0 : 1,
          onTabSelected: (index) {
            setState(() => _isCurrentTabSelected = index == 0);
          },
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child:
                  _currentTrip != null
                      ? TripCard(
                        trip: _currentTrip!,
                        isActive: _isCurrentTabSelected,
                        onPressed: _navigateToAttendanceScreen,
                      )
                      : EmptyTripCard(isActive: _isCurrentTabSelected),
            ),
            const SizedBox(width: 15),
            Expanded(
              child:
                  _upcomingTrip != null
                      ? TripCard(
                        trip: _upcomingTrip!,
                        isActive: !_isCurrentTabSelected,
                        onPressed: _navigateToAttendanceScreen,
                      )
                      : EmptyTripCard(isActive: !_isCurrentTabSelected),
            ),
          ],
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
              padding: EdgeInsets.only(
                bottom: 15.0,
              ),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AttendanceOverviewScreen()),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
