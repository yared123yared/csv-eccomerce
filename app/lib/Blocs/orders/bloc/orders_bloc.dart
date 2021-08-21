import 'dart:async';

import 'package:app/logic/cart_logic.dart';
import 'package:app/models/client.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/cart.dart';
import 'package:app/models/request/payment.dart';
import 'package:app/models/request/request.dart';
import 'package:app/repository/orders_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  // late Request request;
  final OrderRepository orderRepository;
  OrdersBloc({required this.orderRepository}) : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is CreateOrderEvent) {
      print("Entered to the order event");
      yield OrderIsBeingCreating();
      bool value = (await this.orderRepository.createOrder(event.request));
      if (value == true) {
        print("Successfully created");
        yield (OrderCreatedSuccess());
      } else {
        print("failed to create");
        yield (OrderCreatingFailed(message: "Failed to create order"));
      }
    } else if (event is CartCheckoutEvent) {
      Request request = state.request;

      // CartLogic cartLogic = new CartLogic(products: event.cartProducts);
      // request.total = cartLogic.getTaxedPrice().toInt();
      List<Cart> carts = [];
      for (int i = 0; i < event.cartProducts.length; i++) {
        print("Cart Value: ${event.cartProducts[i].id}");
        carts.add(
          Cart(
              id: event.cartProducts[i].id,
              amountInCart: event.cartProducts[i].order,
              selectedAttributes: []),
        );
      }
      request.cart = carts;
      print(request.toJson());
      yield RequestUpdateSuccess(request: request);
    } else if (event is ClientAddEvent) {
      Request request = state.request;
      request.clientId = event.client.id;
      print('Request: ${state.request.toJson()}');
      yield RequestUpdateSuccess(request: request);
    } else if (event is PaymentAddEvent) {
      Request request = state.request;
      Payment payment = event.payment;
      request.amountPaid = payment.AmountPaid;
      request.amountRemaining = payment.AmountRemaining;
      request.paymentMethod = payment.PaymentMethod;
      request.transactionId = payment.TransactionId;
      request.paymentWhen = payment.PaymentWhen;
      request.typeOfWallet = payment.TypeOfWallet;
      print('Request: ${state.request.toString()}');
      yield RequestUpdateSuccess(request: request);
    }
  }
}
