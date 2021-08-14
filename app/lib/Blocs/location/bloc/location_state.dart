part of 'location_bloc.dart';

@immutable
abstract class LocationState extends Equatable{}

class LocationInitial extends LocationState {
  @override
  List<Object?> get props =>[];
}

class LocationFetchingState extends LocationState {
  late final String status;

  LocationFetchingState({required this.status});

  @override
  List<Object?> get props => [this.status,this.status];

}

class LocationFetchingSuccessState extends LocationState {
  final Placemark? p;
  late final String status;

  LocationFetchingSuccessState({this.p, required this.status});

  @override
  List<Object?> get props => [this.p,this.status];
}

class LocationFetchingFailedState extends LocationState {
  late final String message;
  late final String status;
  LocationFetchingFailedState({required this.message,required this.status});

  @override
  List<Object?> get props => [this.message,this.status];
}
