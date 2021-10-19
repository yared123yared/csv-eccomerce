import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:app/Blocs/credit/bloc/credit_bloc.dart';
import 'package:app/data_provider/orders_data_provider.dart';
import 'package:app/db/db.dart';
import 'package:app/models/OrdersDrawer/all_orders_model.dart';
import 'package:app/models/client.dart';
import 'package:app/models/login_info.dart';
import 'package:app/models/product/data.dart';
import 'package:app/models/request/cart.dart';
import 'package:app/models/request/payment.dart';
import 'package:app/models/request/request.dart';
import 'package:app/models/response.dart';
import 'package:app/models/users.dart';
import 'package:app/preferences/user_preference_data.dart';
import 'package:app/repository/orders_repository.dart';
import 'package:app/utils/connection_checker.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_sms/flutter_sms.dart';
part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  // late Request request;
  // late CreditBloc creditBloc;
  final OrderRepository orderRepository;
  final UserPreferences preferences;
  OrdersBloc({
    required this.orderRepository,
    required this.preferences,
  }) : super(OrdersInitial());
  // CartBloc cartbloc;
  int total = 0;
  List<Cart> carts = [];
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
        APIResponse value =
            (await this.orderRepository.createOrder(event.request));
        if (value.IsSuccess == true) {
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
          LoggedUserInfo? info = await this.preferences.getUserInformation();
          int previosCredit =
              double.parse(info?.user?.credit as String).toInt();
          print("previos credit---${previosCredit}");
          int updatedCredit =
              previosCredit - (event.request?.amountPaid as int);
          info?.user?.credit = updatedCredit.toString();
          await this.preferences.storeUserInformation(info!);
          carts = [];
          yield (OrderCreatedSuccess(request: state.request));
          yield (OrdersInitial());
        } else {
          print("failed to create--order");
          print("Message from the servre: ${value.Message}");
          yield (OrderCreatingFailed(message: value.Message));
        }
      } else {
        if (event.request != null) {
          bool value =
              (await CsvDatabse.instance.createRequest(event.request!));
          print("is created");
          print(value);
          if (value == true) {
            if (event.request?.paymentWhen == "now") {
              try {
                LoggedUserInfo? info =
                    await this.preferences.getUserInformation();
                int previosCredit =
                    double.parse(info?.user?.credit as String).toInt();
                print("previos credit---${previosCredit}");
                int updatedCredit =
                    previosCredit - (event.request?.amountPaid as int);
                info?.user?.credit = updatedCredit.toString();
                await this.preferences.storeUserInformation(info!);
                info = await this.preferences.getUserInformation();
                int currentCredit =
                    double.parse(info?.user?.credit as String).toInt();
                print("current credit---${currentCredit}");
              } catch (e) {
                print("error offline order create");
                print(e);
              }
            }
            print("Order Successfully created locally");
            yield (OrderCreatedSuccess(request: state.request));
            return;
          } else {
            yield (OrderCreatingFailed(message: "Failed to create order"));
          }
        } else {
          yield (OrderCreatingFailed(message: "Failed to create order"));
        }
      }
    } else if (event is CartCheckoutEvent) {
      //
      carts = [];
      print("Credit state:${state.credit}");
      //
      Request request = state.request;

      // CartLogic cartLogic = new CartLogic(products: event.cartProducts);
      total = this.getTotalPrice(event.cartProducts).toInt();
      request.total = total;
      request.paymentWhen = 'later';
      request.paymentMethod = 'wallet';
      request.typeOfWallet = 'smilepay';
      request.amountPaid = 0;
      request.transactionId = "";
      request.amountRemaining = (request.total! - (request.amountPaid as int));
      request.cart = carts;
      print("Total Value: ${this.getTotalPrice(event.cartProducts).toInt()}");
      // List<Cart> carts = [];
      for (int i = 0; i < event.cartProducts.length; i++) {
        print("Cart Value: ${event.cartProducts[i].id}");
        print(
            "Prodcut Attributes: ${event.cartProducts[i].selectedAttributes}");

        List<int> selectedAttributes = [];

        for (int j = 0;
            j < event.cartProducts[i].selectedAttributes!.length;
            j++) {
          selectedAttributes.add(
              event.cartProducts[i].selectedAttributes![j].pivot!.id as int);
        }
        carts.add(Cart(
          id: event.cartProducts[i].id,
          amountInCart: event.cartProducts[i].order,
          selectedAttributes: selectedAttributes,
        ));
      }

      request.cart = carts;

      print(request.toJson());
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is PaymentInitialization) {
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo loggedUserInfo =
          await userPreference.getUserInformation() as LoggedUserInfo;
      User user = loggedUserInfo.user as User;
      double credit = double.parse(user.credit as String);
      Request request = state.request;
      request.total = total;
      request.paymentWhen = 'later';
      request.paymentMethod = 'wallet';
      request.typeOfWallet = 'smilepay';
      request.amountPaid = 0;
      request.transactionId = "";
      request.amountRemaining = (request.total! - (request.amountPaid as int));
      yield RequestUpdateSuccess(request: request, credit: credit);
    } else if (event is ClientAddEvent) {
      print("ClientAddEvent bloc");
      Request request = state.request;
      request.clientId = event.client.id;
      // int addressId=event.client.addresses.map((e) => e.isBilling)

      // for (int i = 0; i < event.client.addresses!.length; i++) {
      // print("Address:${event.client.addresses![i].id} and ");
      // if (event.client.addresses![i].isBilling == 0) {
      //   print("CLIENT ADDRESS ID: ${event.client.addresses![i]}");
      //   // request.addressId = event.client.addresses![i].id;
      // }
      // print("hi");
      // }
      // List<int> addressId = [];
      // addressId.add(int.parse(event.client.addresses!.map((e) => e.id) as String));
      // event.client.addresses??
      //     [].map((e) => addressId.add(int.parse(e.id as String)));

      // print("Adress length: ${addressId.length}");
      // for (int i = 0; i < addressId.length; i++) {
      //   print("Adress Id: ${addressId[i]}");
      // }
      // event.client.addresses!.map((e) => {print("Hi")});
      // print('Request: ${state.request.toJson()}');
      print("credit--:--${state.credit}");
      yield RequestUpdateSuccess(request: request, credit: state.credit);
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
      //yield RequestUpdateSuccess(request: request, credit:state.credit);
    } else if (event is AddPaymentWhenEvent) {
      Request request = state.request;
      print("Add payment when");
      print(state.request.toJson());
      request.paymentWhen = event.when;
      print("When:${event.when}");
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is AddPaymentMethodEvent) {
      Request request = state.request;
      print("Add payment method");
      print(state.request.toJson());
      request.paymentMethod = event.method;
      print("method:${event.method}");

      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is AddTotalEvent) {
      print("AddTotalEvent bloc");
      Request request = state.request;
      // print("Entered to the payment bloc");
      // print(state.request.toJson());
      request.total = event.total;
      // print("When:${event.method}");

      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is AddPaymentTypeEvent) {
      Request request = state.request;
      print("Add payment type");
      print(state.request.toJson());
      request.typeOfWallet = event.type;
      print("Type :${event.type}");
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is AddTransactionIdEvent) {
      Request request = state.request;
      print("Add transaction Id");
      // print(state.request.toJson());
      request.transactionId = event.transactionId;
      print("transaction is:${event.transactionId}");
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is AddPaidAmountEvent) {
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo loggedUserInfo =
          await userPreference.getUserInformation() as LoggedUserInfo;
      User user = loggedUserInfo.user as User;
      double credit = double.parse(user.credit ?? 0 as String);
      print("---${credit}");
      Request request = state.request;
      print("Adding paid amount");
      print(state.request.toJson());
      request.amountPaid = event.amount;
      request.amountRemaining = (request.total! - (request.amountPaid as int));
      // print("Remaining");
      // request.amountRemaining = (request.total! - (request.amountPaid as int));
      // print("When:${event.amount}");
      print("credit--:--${state.credit}");

      yield RequestUpdateSuccess(request: request, credit: credit);
      return;
    } else if (event is AddRemainingAmountEvent) {
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo loggedUserInfo =
          await userPreference.getUserInformation() as LoggedUserInfo;
      User user = loggedUserInfo.user as User;
      double credit = double.parse(user.credit ?? 0 as String);
      print("---${credit}");
      Request request = state.request;
      print("Adding remaining amount");
      // print(state.request.toJson());
      request.amountRemaining = event.amount;
      print("remaining amount :${event.amount}");
      print("credit--:--${state.credit}");

      yield RequestUpdateSuccess(request: request, credit: credit);
      return;
    } else if (event is FetchOrderToBeUpdated) {
      print("FetchOrderToBeUpdated bloc");
      yield FetchingOrderToBeUpdated(request: state.request);
      try {
        UserPreferences userPreference = new UserPreferences();
        LoggedUserInfo? loggedUserInfo =
            await userPreference.getUserInformation();
        User user = loggedUserInfo?.user as User;
        double credit = double.parse(user.credit ?? 0 as String);
        print("credit---${credit}");
        // bool connected = await ConnectionChecker.CheckInternetConnection();
        // if (!connected) {
        //   Data? data = await CsvDatabse.instance.readProduct(int.parse(event.id));
        //   yield FetchingOrderToBeUpdatedSuccess(
        //     data: data,
        //     addressId: data.addressId,
        //     request: state.request,
        //     client: data.client,
        //     credit: credit,
        //   );
        // }
        OrderDetail data = await this.orderRepository.OrderData(event.id);
        yield FetchingOrderToBeUpdatedSuccess(
          data: data,
          addressId: data.addressId,
          request: state.request,
          client: data.client,
          credit: credit,
        );
        return;
      } catch (e) {
        yield FetchingOrderToBeUpdatedFailed();
      }
      return;
    } else if (event is SetRequestEvent) {
      print("setting request");
      // state.request = event.request;
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo? loggedUserInfo =
          await userPreference.getUserInformation();
      User user = loggedUserInfo?.user as User;
      double credit = double.parse(user.credit ?? 0 as String);
      print("credit---${credit}");
      Request request = state.request;
      request = event.request;
      yield RequestUpdateSuccess(request: request, credit: credit);
      return;
    } else if (event is AddToCart) {
      print("----add to cart --invoked--");
      Request request = state.request;
      List<CartItem>? carts = request.cartItem;
      if (carts != null) {
        try {
          List<CartItem> filtered = carts
              .where((element) => element.productId == event.cart.productId)
              .toList();
          List<int> eventIds = getSelectedAttrId2(event.cart.slectedIds);
          Function eq = const ListEquality().equals;
          for (var car in filtered) {
            List<int> itemIds = getSelectedAttrId2(car.slectedIds);
            if (eq(eventIds == itemIds)) {
              carts.remove(car);
              if (car.quantity != null) {
                int x = car.quantity;
                ++x;
                car.quantity = x;
              }
              car.id = -1;
              carts.add(car);
              request.cartItem = carts;
              yield RequestUpdateSuccess(
                request: request,
                credit: state.credit,
              );
              break;
            }
          }

          // CartItem car = carts
          //     .where(
          //       (element) => (element.productId == event.cart.productId &&
          //           element.slectedIds == event.cart.slectedIds),
          //     )
          //     .first;

          // carts.remove(car);
          // if (car.quantity != null) {
          //   int x = car.quantity;
          //   ++x;
          //   car.quantity = x;
          // }
          // car.id = -1;
          // carts.add(car);
          // request.cartItem = carts;
          yield RequestUpdateSuccess(
            request: request,
            credit: state.credit,
          );
        } catch (e) {
          CartItem car = event.cart;
          car.id = -1;
          carts.add(event.cart);
          request.cartItem = carts;
          yield RequestUpdateSuccess(
            request: request,
            credit: state.credit,
          );
        }
      }
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is DecreaseAmountInCart) {
      Request request = state.request;
      List<CartItem>? carts = request.cartItem;
      if (carts != null) {
        try {
          List<CartItem> filtered = carts
              .where((element) => element.productId == event.cart.productId)
              .toList();
          List<int> eventIds = getSelectedAttrId2(event.cart.slectedIds);
          Function eq = const ListEquality().equals;
          for (var car in filtered) {
            List<int> itemIds = getSelectedAttrId2(car.slectedIds);
            if (eq(eventIds == itemIds)) {
              carts.remove(car);
              int x = car.quantity;
              --x;
              car.quantity = x;
              carts.add(car);
              request.cartItem = carts;
              break;
            }
          }
          // CartItem car = carts
          //     .where((element) =>
          //         element.productId == event.cart.productId &&
          //         element.slectedIds == event.cart.slectedIds)
          //     .first;
          // carts.remove(car);
          // int x = car.quantity;
          // --x;
          // car.quantity = x;
          // carts.add(car);
          // request.cartItem = carts;
        } catch (e) {
          // carts.add(event.cart);
          request.cartItem = carts;
        }
      }
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is RemoveFromCart) {
      Request request = state.request;
      List<CartItem>? carts = request.cartItem;
      if (carts != null) {
        try {
          List<CartItem> filtered = carts
              .where((element) => element.productId == event.cart.productId)
              .toList();
          List<int> eventIds = getSelectedAttrId2(event.cart.slectedIds);
          Function eq = const ListEquality().equals;
          for (var car in filtered) {
            List<int> itemIds = getSelectedAttrId2(car.slectedIds);
            if (eq(eventIds == itemIds)) {
              carts.remove(car);
              request.cartItem = carts;
              break;
            }
          }
          // CartItem car = carts
          //     .where((element) =>
          //         element.productId == event.cart.productId &&
          //         element.slectedIds == event.cart.slectedIds)
          //     .first;
          // carts.remove(car);
          // request.cartItem = carts;
        } catch (e) {
          request.cartItem = carts;
        }
      }
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
    } else if (event is UpdateOrderEvent) {
      UserPreferences userPreference = new UserPreferences();
      LoggedUserInfo loggedUserInfo =
          await userPreference.getUserInformation() as LoggedUserInfo;
      User user = loggedUserInfo.user as User;
      double credit = double.parse(user.credit ?? 0 as String);
      print("Entered to the update order event");
      // print("State Request: ${state.request.toJson()}");
      // print("Eve Request: ${event.request.toJson()}");

      bool connected = await ConnectionChecker.CheckInternetConnection();
      // print("-update order--connected--${connected}");
      if (state.request.paymentWhen == "later") {
        state.request.amountRemaining = 0;
        state.request.amountPaid = 0;
        state.request.transactionId = "";
      }
      yield OrderUpdating(request: state.request, credit: credit);
      if (connected) {
        // yield OrderUpdateSuccess(request: event.request);
        // return;

        APIResponse value =
            await this.orderRepository.UpdateOrder(event.request);
        if (value.IsSuccess == true) {
          print("Order---Successfully created");
          // cartbloc=BlocProvider.of(context)<CartBloc>();
          // InitializeCart
          LoggedUserInfo? info = await this.preferences.getUserInformation();
          int previosCredit =
              double.parse(info?.user?.credit as String).toInt();
          print("previos credit---${previosCredit}");
          int updatedCredit = previosCredit - (event.request.amountPaid as int);
          info?.user?.credit = updatedCredit.toString();
          await this.preferences.storeUserInformation(info!);
          yield (OrderUpdateSuccess(request: event.request, credit: credit));
          return;
        } else {
          print("failed to create--order");
          yield (OrderUpdatingFailed(
              request: state.request, credit: credit, message: value.Message));
        }
        return;
      } else {
        bool value =
            (await CsvDatabse.instance.createUpdateOrderRequest(event.request));
        if (value == true) {
          print("Order Successfully updated locally");
          LoggedUserInfo? info = await this.preferences.getUserInformation();
          int previosCredit =
              double.parse(info?.user?.credit as String).toInt();
          print("previos credit---${previosCredit}");
          int updatedCredit = previosCredit - (event.request.amountPaid as int);
          info?.user?.credit = updatedCredit.toString();
          await this.preferences.storeUserInformation(info!);
          yield (OrderCreatedSuccess(
            request: state.request,
          ));
          return;
        } else {
          print("failed to updated order locally");
          // yield (OrderCreatingFailed(message: "Failed to updated order"));
          yield (OrderUpdatingFailed(
              credit: credit,
              request: state.request,
              message: "Failed to update order"));
          return;
        }
      }

      // }
    } else if (event is AddAddressIdEvent) {
      Request request = state.request;
      print("Add adress Id");
      print(state.request.toJson());
      request.addressId = event.id;
      print("address-id:${event.id}");
      print("credit--:--${state.credit}");
      yield RequestUpdateSuccess(request: request, credit: state.credit);
      return;
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

List<int> getSelectedAttrId2(List<ProductAttribute>? atr) {
  List<int> ids = [];
  if (atr != null) {
    for (var item in atr) {
      ids.add(item.id);
    }
  }
  return ids;
}
