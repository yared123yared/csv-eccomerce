import 'dart:async';

import 'package:app/Blocs/cart/bloc/cart_bloc.dart';
import 'package:app/db/db.dart';
import 'package:app/logic/cart_logic.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/models/client.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/cart.dart';
import 'package:app/models/request/payment.dart';
import 'package:app/models/request/request.dart';
import 'package:app/repository/orders_repository.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:bloc/bloc.dart';
// import 'package:flutter_sms/flutter_sms.dart';
part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  // late Request request;
  final OrderRepository orderRepository;
  OrdersBloc({required this.orderRepository}) : super(OrdersInitial());
  // CartBloc cartbloc;

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    if (event is CreateOrderEvent) {
      print("Entered to the order event");
      print("Request arrived: ${state.request.toJson()}");
      bool connected = await ConnectionChecker.CheckInternetConnection();
      print("-create order--connected--${connected}");

      yield OrderIsBeingCreating(request: state.request);
      if (connected) {
        bool value = (await this.orderRepository.createOrder(event.request));
        if (value == true) {
          print("Order---Successfully created");
          // cartbloc=BlocProvider.of(context)<CartBloc>();
          // InitializeCart
          //
          // String _result =
          //     await sendSMS(message: "Test", recipients: ['0916897173'])
          //         .catchError((onError) {
          //   print(onError);
          // });
          // print(_result);
//
          yield (OrderCreatedSuccess(request: state.request));
        } else {
          print("failed to create--order");
          yield (OrderCreatingFailed(message: "Failed to create order"));
        }
      } else {
        if (event.request != null) {
          bool value =
              (await CsvDatabse.instance.createRequest(event.request!));
          if (value == true) {
            print("Order Successfully created locally");
            yield (OrderCreatedSuccess(request: state.request));
          } else {
            print("failed to create order locally");
            yield (OrderCreatingFailed(message: "Failed to create order"));
          }
        } else {
          yield (OrderCreatingFailed(message: "Failed to create order"));
        }
      }
    } else if (event is CartCheckoutEvent) {
      Request request = state.request;

      // CartLogic cartLogic = new CartLogic(products: event.cartProducts);
      request.total = this.getTotalPrice(event.cartProducts).toInt();
      request.paymentWhen = 'Pay Later';
      request.paymentMethod = 'Wallet';
      request.typeOfWallet = 'Smilepay';
      request.amountPaid = 0;
      request.transactionId = "";
      request.amountRemaining = (request.total! - (request.amountPaid as int));
      print("Total Value: ${this.getTotalPrice(event.cartProducts).toInt()}");
      List<Cart> carts = [];
      for (int i = 0; i < event.cartProducts.length; i++) {
        print("Cart Value: ${event.cartProducts[i].id}");
        print("Prodcut Attributes: ${event.cartProducts[i].selectedAttributes}");
        carts.add(
          Cart(
              id: event.cartProducts[i].id,
              amountInCart: event.cartProducts[i].order,
              selectedAttributes:event.cartProducts[i].selectedAttributes
              ),
        );
      }
      request.cart = carts;

      print(request.toJson());
      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is ClientAddEvent) {
      Request request = state.request;
      request.clientId = event.client.id;
      print('Request: ${state.request.toJson()}');
      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is PaymentAddEvent) {
      // Request request = state.request;
      // Payment payment = event.payment;
      // request.amountPaid = payment.AmountPaid;
      // request.amountRemaining = payment.AmountRemaining;
      // request.paymentMethod = payment.PaymentMethod;
      // request.transactionId = payment.TransactionId;
      // request.paymentWhen = payment.PaymentWhen;
      // request.typeOfWallet = payment.TypeOfWallet;
      // print('Request: ${state.request.toString()}');
      // // ordersbloc.add(
      // //                           CreateOrderEvent(request: state_old.request));
      // yield RequestUpdateSuccess(request: request);
    } else if (event is AddPaymentWhenEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.paymentWhen = event.when;
      print("When:${event.when}");

      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is AddPaymentMethodEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.paymentMethod = event.method;
      print("When:${event.method}");

      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is AddTotalEvent) {
      Request request = state.request;
      // print("Entered to the payment bloc");
      // print(state.request.toJson());
      request.total = event.total;
      // print("When:${event.method}");

      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is AddPaymentTypeEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.typeOfWallet = event.type;
      print("When:${event.type}");

      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is AddTransactionIdEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.transactionId = event.transactionId;
      print("When:${event.transactionId}");

      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is AddPaidAmountEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.amountPaid = event.amount;
      request.amountRemaining = (request.total! - (request.amountPaid as int));
      print("When:${event.amount}");

      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is AddRemainingAmountEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.amountRemaining = event.amount;
      print("When:${event.amount}");

      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is FetchOrderToBeUpdated) {
      yield FetchingOrderToBeUpdated(request: state.request);
      try {
        List<OrderToBeUpdated> data =
            await this.orderRepository.OrderData(event.id);
        yield FetchingOrderToBeUpdatedSuccess(
            data: data, request: state.request);
        return;
      } catch (e) {
        yield FetchingOrderToBeUpdatedFailed();
      }
      return;
    } else if (event is SetRequestEvent) {
      print("setting request");
      Request request = state.request;
      request = event.request;
      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is AddToCart) {
      print("----add to cart --invoked--");
      Request request = state.request;
      List<CartItem>? carts = request.cartItem;
      if (carts != null) {
        try {
          CartItem car = carts
              .where((element) => element.productId == event.cart.productId)
              .first;

          carts.remove(car);
          if (car.quantity != null) {
            int x = car.quantity;
            ++x;
            car.quantity = x;
          }
          car.id = -1;
          carts.add(car);
          request.cartItem = carts;
          yield RequestUpdateSuccess(request: request);
        } catch (e) {
          CartItem car = event.cart;
          car.id = -1;
          carts.add(event.cart);
          request.cartItem = carts;
          yield RequestUpdateSuccess(request: request);
        }
      }
      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is RemoveFromCart) {
      Request request = state.request;
      List<CartItem>? carts = request.cartItem;
      if (carts != null) {
        try {
          CartItem car = carts
              .where((element) => element.productId == event.cart.productId)
              .first;
          carts.remove(car);
          if (car.quantity != null) {
            int x = car.quantity;
            --x;
            car.quantity = x;
          }
          carts.add(car);
          request.cartItem = carts;
        } catch (e) {
          // carts.add(event.cart);
          request.cartItem = carts;
        }
      }
      yield RequestUpdateSuccess(request: request);
      return;
    } else if (event is UpdateOrderEvent) {
      print("Entered to the update order event");
      print("State Request: ${state.request.toJson()}");
      print("Eve Request: ${event.request.toJson()}");

      bool connected = await ConnectionChecker.CheckInternetConnection();
      // print("-update order--connected--${connected}");

      yield OrderUpdating(request: state.request);
      if (connected) {
        // yield OrderUpdateSuccess(request: event.request);
        // return;

        bool value = await this.orderRepository.UpdateOrder(event.request);
        if (value == true) {
          print("Order---Successfully created");
          // cartbloc=BlocProvider.of(context)<CartBloc>();
          // InitializeCart
          yield (OrderUpdateSuccess(request: event.request));
        } else {
          print("failed to create--order");
          yield (OrderUpdatingFailed(
              request: state.request, message: "Failed to update order"));
        }
        return;
      } else {
        bool value =
            (await CsvDatabse.instance.createUpdateOrderRequest(event.request));
        if (value == true) {
          print("Order Successfully updated locally");
          yield (OrderCreatedSuccess(request: state.request));
          return;
        } else {
          print("failed to updated order locally");
          // yield (OrderCreatingFailed(message: "Failed to updated order"));
          yield (OrderCreatedSuccess(request: state.request));
          return;
        }
      }

      // }
    }
  }

  double getTotalPrice(List<Data> products) {
    double total = 0;

    for (int i = 0; i < products.length; i++) {
      String value = products[i].price as String;
      total += double.parse(value) * products[i].order;
    }

    // double taxedValue = total - 20;
    return total;
  }
}
