import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safe_bus/features/parent/home/data/models/parents.dart';

import 'package:safe_bus/features/parent/home/data/repo/parent_repository.dart';

part 'parent_state.dart';

class ParentCubit extends Cubit<ParentState> {
  final ParentRepository parentRepository;

  ParentCubit(this.parentRepository) : super(ParentInitial());

  Future<void> getParent() async {
    emit(ParentLoading());
    try {
      final parent = await parentRepository.getParent();
      emit(ParentLoaded(parent));
    } catch (e) {
      emit(ParentError(e.toString()));
    }
  }
}
