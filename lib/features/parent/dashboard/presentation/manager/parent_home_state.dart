part of 'parent_home_cubit.dart';

@immutable
sealed class ParentHomeState {}

final class ParentHomeInitial extends ParentHomeState {}

final class ParentHomeLoading extends ParentHomeState {}

final class ParentHomeLoaded extends ParentHomeState {}

final class ParentHomeError extends ParentHomeState {
  final String message;

  ParentHomeError(this.message);
}

final class ParentHomeStudentSelected extends ParentHomeState {}
