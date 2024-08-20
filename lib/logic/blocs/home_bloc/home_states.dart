import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeLoadedState extends HomeStates {}

class HomeLogoutState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String error;

  HomeErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
