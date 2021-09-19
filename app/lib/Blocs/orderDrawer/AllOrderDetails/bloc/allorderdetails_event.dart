part of 'allorderdetails_bloc.dart';

@immutable
abstract class AllorderdetailsEvent {}

class FeatchOrderDetailsEvent extends AllorderdetailsEvent {
  final int id;

  FeatchOrderDetailsEvent(this.id);

}
