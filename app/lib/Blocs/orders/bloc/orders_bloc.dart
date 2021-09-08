import 'dart:async';

import 'package:app/db/db.dart';
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
    } else if (event is ClientAddEvent) {
      Request request = state.request;
      request.clientId = event.client.id;
      print('Request: ${state.request.toJson()}');
      yield RequestUpdateSuccess(request: request);
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
    } else if (event is AddPaymentMethodEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.paymentMethod = event.method;
      print("When:${event.method}");

      yield RequestUpdateSuccess(request: request);
    } else if (event is AddPaymentTypeEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.typeOfWallet = event.type;
      print("When:${event.type}");

      yield RequestUpdateSuccess(request: request);
    } else if (event is AddTransactionIdEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.transactionId = event.transactionId;
      print("When:${event.transactionId}");

      yield RequestUpdateSuccess(request: request);
    } else if (event is AddPaidAmountEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.amountPaid = event.amount;
      request.amountRemaining = (request.total! - (request.amountPaid as int));
      print("When:${event.amount}");

      yield RequestUpdateSuccess(request: request);
    } else if (event is AddRemainingAmountEvent) {
      Request request = state.request;
      print("Entered to the payment bloc");
      print(state.request.toJson());
      request.amountRemaining = event.amount;
      print("When:${event.amount}");

      yield RequestUpdateSuccess(request: request);
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
