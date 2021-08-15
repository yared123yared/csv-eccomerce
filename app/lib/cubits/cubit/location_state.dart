part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}


class LocationFetchingState extends LocationState {
  
  LocationFetchingState();

}

class LocationFetchingSuccessState extends LocationState {
  final Placemark? p;
  late final String status;

  LocationFetchingSuccessState({this.p, required this.status});

}

class LocationFetchingFailedState extends LocationState {
  late final String message;
  LocationFetchingFailedState({required this.message});

}
