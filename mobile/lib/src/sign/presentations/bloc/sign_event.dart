part of 'sign_bloc.dart';

sealed class SignEvent extends Equatable {
  const SignEvent();

  @override
  List<Object> get props => [];
}

class GetSignsEvent extends SignEvent {
  const GetSignsEvent();
}