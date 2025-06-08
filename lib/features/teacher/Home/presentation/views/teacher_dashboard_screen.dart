import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_bus/core/styles/colors.dart';
import 'package:safe_bus/core/utils/app_routes.dart';
import 'package:safe_bus/core/utils/toast.dart';
import 'package:safe_bus/features/shared/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:safe_bus/features/shared/login/presentation/views/profile.dart';
import 'package:safe_bus/features/shared/login/presentation/views/widgets/bottom_nav_bar.dart';
import 'package:safe_bus/features/teacher/Home/presentation/managers/cubit/teacher_home_cubit.dart';
import 'package:safe_bus/features/teacher/Home/presentation/views/widgets/trip_card.dart';
import 'package:safe_bus/features/teacher/Home/presentation/views/widgets/recent_trip_item.dart';
import 'package:safe_bus/features/teacher/Home/data/models/teacher_home/trip.dart';

import '../../../attendance_overview/presentation/views/attendance_overview_screen.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  int _currentIndex = 0;
  Trip? _currentTrip;
  Trip? _upcomingTrip;
  List<Trip> _recentTrips = [];

  void _loadTripData({
    required List<Trip> recent,
    required Trip? current,
    required Trip? upcoming,
  }) {
    _currentTrip = current;
    _upcomingTrip = upcoming;
    _recentTrips = recent;

    _upcomingTrip?.status = TripStatus.upcoming;
    _currentTrip?.status = TripStatus.current;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeacherHomeCubit()..getHome(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: BlocConsumer<TeacherHomeCubit, TeacherHomeState>(
                  listener: (context, state) {
                    if (state is TeacherHomeFailure) {
                      print(state.errMessage);
                      Toast(context).showToast(
                        message: state.errMessage,
                        color: KColors.fadedRed,
                      );
                    }
                    if (state is TeacherHomeSuccess) {
                      _loadTripData(
                        recent: state.home.recentTrips ?? [],
                        current:
                            state.home.currentTrips!.isNotEmpty
                                ? state.home.currentTrips!.first
                                : null,
                        upcoming:
                            state.home.upcomingTrips!.isNotEmpty
                                ? state.home.upcomingTrips!.first
                                : null,
                      );
                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
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
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: BottomNavBar(
                  currentIndex: _currentIndex,
                  userType: context.read<AuthCubit>().user.userType ?? 0,
                  onTap: (index) {
                    setState(() => _currentIndex = index);
                    if (index == 1) {
                      context.go(AppRouter.profile);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
            Text(
              BlocProvider.of<AuthCubit>(context).user.name ?? "Ahmad",
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
                      onPressed:
                          () =>
                              _navigateToAttendanceScreen(trip: _currentTrip!),
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
                      onPressed:
                          () =>
                              _navigateToAttendanceScreen(trip: _upcomingTrip!),
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
                onDetailsPressed: () => _navigateToAttendanceScreen(trip: trip),
              ),
            );
          }),
      ],
    );
  }

  void _navigateToAttendanceScreen({required Trip trip}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceOverviewScreen(trip: trip),
      ),
    );
  }
}
