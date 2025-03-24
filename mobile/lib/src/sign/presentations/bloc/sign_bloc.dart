import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_signs.dart';

import '../../../../core/common/features/data/models/sign_model.dart';

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc({
    required GetSigns getSigns,
}) : _getSigns = getSigns,
        super(SignInitial()) {
    on<GetSignsEvent>(_onGetSignsHandler);
  }

  final GetSigns _getSigns;

  Future<void> _onGetSignsHandler(GetSignsEvent event, Emitter<SignState> emit) async {
    emit(SignLoading());
    final signs = await _getSigns();
    signs.fold(
      (failure) => emit(SignError(failure.message)),
      (signs) => emit(SignLoaded(signs as List<SignModel>)),
    );
  }
}
