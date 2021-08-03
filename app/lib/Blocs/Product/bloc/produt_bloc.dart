import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'produt_event.dart';
part 'produt_state.dart';

class ProdutBloc extends Bloc<ProdutEvent, ProdutState> {
  ProdutBloc() : super(ProdutInitial());

  @override
  Stream<ProdutState> mapEventToState(
    ProdutEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
