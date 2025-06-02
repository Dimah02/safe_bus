part of 'absence_cubit.dart';

@immutable
sealed class AbsenceState {}

final class AbsenceInitial extends AbsenceState {}

final class AbsenceSent extends AbsenceState {}

final class AbsenceDeleted extends AbsenceState {
  final int absenceId;

  AbsenceDeleted(this.absenceId);

  List<Object?> get props => [absenceId];
}

final class AbsenceError extends AbsenceState {
  final String message;

  AbsenceError(this.message);
}