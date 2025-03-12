import 'dart:async';

import 'package:bloc/bloc.dart';





class CounterCubit extends Cubit<int> {
  static const int initialTime = 20 * 60; // 20 minutes in seconds
  Timer? _timer;

  CounterCubit() : super(initialTime) {
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    emit(initialTime);
    startTimer();
  }

  get time => state;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}