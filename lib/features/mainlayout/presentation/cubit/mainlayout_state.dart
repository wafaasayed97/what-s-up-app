import 'package:equatable/equatable.dart';


abstract class MainLayoutState extends Equatable {
  const MainLayoutState();

  @override
  List<Object> get props => [];
}

class MainLayoutInitial extends MainLayoutState {}

class AppBottomNavState extends MainLayoutState {
  final int currentIndex;

  const AppBottomNavState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}