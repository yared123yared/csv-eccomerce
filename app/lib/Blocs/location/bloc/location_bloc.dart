import 'dart:async';

import 'package:app/repository/location_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;
  LocationBloc({required this.locationRepository}) : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchCurrentLocationEvent) {
      yield* _mapFetchCurrentLocationToState();
    }
  }

  Stream<LocationState> _mapFetchCurrentLocationToState() async* {
    print("locaion entered");
    var currTime = DateTime.now();
    var timeStamp = currTime.millisecondsSinceEpoch;
    yield LocationFetchingState(status: timeStamp.toString());
    Placemark? p;
    try {
      p = await this.locationRepository.getCurrentLocation();
      yield LocationFetchingSuccessState(
        status: timeStamp.toString(),
        p: p,
      );
      print("fetch success");

      return;
    } catch (e) {
      print("from location bloc");
      print(e);
      yield LocationFetchingFailedState(
        status: timeStamp.toString(),
        message: 'Cannot Fetch Current Address',
      );
      return;
    }
  }
}
