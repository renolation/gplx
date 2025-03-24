part of 'sign_bloc.dart';

sealed class SignState extends Equatable {
  const SignState();
  @override
  List<Object> get props => [];
}

final class SignInitial extends SignState {
}

final class SignLoading extends SignState {
}

final class SignLoaded extends SignState {
  final List<SignModel> signs;

  const SignLoaded(this.signs);

  @override
  List<Object> get props => [signs];
}

final class SignError extends SignState {
  final String message;

  const SignError(this.message);

  @override
  List<Object> get props => [message];
}