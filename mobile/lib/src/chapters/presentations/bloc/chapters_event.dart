part of 'chapters_bloc.dart';

abstract class ChaptersEvent extends Equatable{

  const ChaptersEvent();

  @override
  List<Object> get props => [];

}

class GetChaptersEvent extends ChaptersEvent {
  const GetChaptersEvent();
}