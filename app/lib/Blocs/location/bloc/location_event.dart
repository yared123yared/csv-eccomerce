part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class FetchCurrentLocationEvent extends LocationEvent {
  final String status;
  FetchCurrentLocationEvent({required this.status});
  @override
  List<Object> get props => [status];
}
