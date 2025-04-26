import 'package:flutter/material.dart';

import 'attendance_overview_screen.dart';
import 'models/trip.dart';

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

    _recentTrips = _allTrips.where((trip) =>
    trip.status == TripStatus.completed || trip.status == TripStatus.pending
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildTripCards(),
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

  Widget _buildTripCards() {
    return Column(
      children: [
        Row(
          children: [
            _buildTripTab('CURRENT TRIP', isSelected: _isCurrentTabSelected,
                onTap: () => setState(() => _isCurrentTabSelected = true)),
            _buildTripTab('UPCOMING TRIP', isSelected: !_isCurrentTabSelected,
                onTap: () => setState(() => _isCurrentTabSelected = false)),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _currentTrip != null ? _buildTripCard(
                trip: _currentTrip!,
                isActive: _isCurrentTabSelected,
              ) : _buildEmptyTripCard(isActive: _isCurrentTabSelected),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _upcomingTrip != null ? _buildTripCard(
                trip: _upcomingTrip!,
                isActive: !_isCurrentTabSelected,
              ) : _buildEmptyTripCard(isActive: !_isCurrentTabSelected),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTripTab(String text, {required bool isSelected, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.green
                  : Colors.orange,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard({
    required Trip trip,
    required bool isActive,
  }) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            trip.zoneName,
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
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceOverviewScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? Colors.white.withOpacity(0.3)
                    : Colors.grey.shade300,
                foregroundColor: isActive ? Colors.white : Colors.grey,
                minimumSize: const Size(120, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Trip Details',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTripCard({required bool isActive}) {
    return Container(
      height: 130,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green
            : Colors.grey.shade200,
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

  Widget _buildRecentTripsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Trips',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
              padding: EdgeInsets.only(bottom: index < _recentTrips.length - 1 ? 15.0 : 0),
              child: _buildTripHistoryItem(trip: trip),
            );
          }),
      ],
    );
  }

  Widget _buildTripHistoryItem({
    required Trip trip,
  }) {
    final String status = trip.status.name;
    final Color statusColor = trip.status.color;

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
            trip.zoneName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 5),
              Text(
                trip.getFormattedDate(),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.tag, size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 5),
                    Text(
                      trip.tripNumber,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.route, size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 5),
                    Text(
                      '${trip.distance.toInt()} Km',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 5),
                    Text(
                      '${trip.studentCount} Students',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.timer, size: 16, color: Colors.grey.shade700),
                    const SizedBox(width: 5),
                    Text(
                      trip.getDurationString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceOverviewScreen(),
                    ),
                  );
                },
                icon: const Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                label: const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
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