part of 'parent_cubit.dart';

@immutable
sealed class ParentState {}

final class ParentInitial extends ParentState {}

final class ParentLoading extends ParentState {}

final class ParentLoaded extends ParentState {
  final Parents parent;

  ParentLoaded(this.parent);

  List<Object?> get props => [parent];
}

final class ParentError extends ParentState {
  final String message;

  ParentError(this.message);
}