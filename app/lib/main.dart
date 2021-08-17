import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/categories/bloc/categories_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/data_provider/categories_data_provider.dart';
import 'package:app/data_provider/orders_data_provider.dart';
import 'package:app/repository/categories_repository.dart';
import 'package:app/repository/location_repository.dart';
import 'package:app/repository/orders_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'Blocs/cart/bloc/cart_bloc.dart';
import 'Blocs/location/bloc/location_bloc.dart';
import 'Blocs/reports/cubit/report_cubit.dart';
import 'data_provider/product_data_provider.dart';
import 'route/route.dart';
import 'screens/login.dart';
import 'data_provider/user_data_provider.dart';
import 'repository/user_repository.dart';
import 'preferences/user_preference_data.dart';
import 'Blocs/auth/bloc/auth_bloc.dart';
import 'package:app/Blocs/Product/bloc/produt_bloc.dart';
import 'package:app/Blocs/clients/bloc/clients_bloc.dart';
import 'package:app/data_provider/clients_data_provider.dart';
import 'package:app/repository/clients_repository.dart';
import 'package:app/repository/product_repository.dart';

void main() {
  http.Client httpClient = http.Client();

  final UserPreferences userPreferences = UserPreferences();
  final UserRepository userRepository = UserRepository(
    userDataProvider: UserDataProvider(
      httpClient: httpClient,
      userPreferences: userPreferences,
    ),
  );
  final ClientsRepository clientRepository = ClientsRepository(
    clientsDataProvider: ClientsDataProvider(
      httpClient: httpClient,
      userPreferences: userPreferences,
    ),
  );
  final ProductRepository productRepository = ProductRepository(
    productDataProvider: ProductDataProvider(
        httpClient: httpClient, userPreferences: userPreferences),
  );

  final CategoryRepository categoryRepository = CategoryRepository(
    categoryDataProvider: CategoriesDataProvider(
        httpClient: httpClient, userPreferences: userPreferences),
  );
  final OrderRepository orderRepository = OrderRepository(
      orderDataProvider: OrderDataProvider(
          httpClient: httpClient, userPreferences: userPreferences));
  final LocationRepository locationRepository = LocationRepository();
  // Products products = await productRepository.getProducts(1);
  // print(products.currentPage);

  runApp(App(
    userPreferences: userPreferences,
    productRepository: productRepository,
    userRepository: userRepository,
    clientsRepository: clientRepository,
    categoryRepository: categoryRepository,
    orderRepository: orderRepository,
    locationRepository: locationRepository,
  ));
  // runApp(MyApp());
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final ProductRepository productRepository;
  final UserPreferences userPreferences;
  final ClientsRepository clientsRepository;
  final CategoryRepository categoryRepository;
  final OrderRepository orderRepository;
  App(
      {required this.userRepository,
      required this.productRepository,
      required this.userPreferences,
      required this.clientsRepository,
      required this.categoryRepository,
      required this.orderRepository,
      required this.locationRepository});

  final LocationRepository locationRepository;
  // App({
  //   required this.userRepository,
  //   required this.productRepository,
  //   required this.userPreferences,
  //   required this.clientsRepository,
  //   required this.locationRepository,
  // });
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => this.userRepository,
        ),
        RepositoryProvider<ProductRepository>(
          create: (_) => this.productRepository,
        ),
        RepositoryProvider<UserPreferences>(
          create: (_) => this.userPreferences,
        ),
        RepositoryProvider<ClientsRepository>(
          create: (_) => this.clientsRepository,
        ),
        RepositoryProvider<LocationRepository>(
          create: (_) => this.locationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              userRepository: this.userRepository,
              userPreference: this.userPreferences,
            )..add(AutoLoginEvent()),
          ),
          BlocProvider<ProductBloc>(
            create: (_) =>
                ProductBloc(productRepository: this.productRepository)
                  ..add(FetchProduct()),
          ),
          BlocProvider<CartBloc>(
            create: (_) => CartBloc(),
          ),
          BlocProvider<ClientsBloc>(
            create: (_) => ClientsBloc(
              clientsRepository: this.clientsRepository,
            )..add(FetchClientsEvent(loadMore: true)),
          ),
          BlocProvider<CategoriesBloc>(
            create: (_) =>
                CategoriesBloc(categoryRepository: this.categoryRepository)
                  ..add(FetchCategories()),
          ),
          BlocProvider<OrdersBloc>(
              create: (_) => OrdersBloc(orderRepository: this.orderRepository)),
          //
          BlocProvider<AddClientBloc>(create: (_) => AddClientBloc()),
          //
          BlocProvider<LocationBloc>(
            create: (_) =>
                LocationBloc(locationRepository: this.locationRepository),
          ),
          BlocProvider<ReportCubit>(
            create: (BuildContext context) => ReportCubit(userPreferences)
              ..postSalesReport(
                nameSearch: "",
                dateFrom: "",
              ),
          ),
        ],
        child: MaterialApp(
          title: 'CSV',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color(0xFF015777),
            // primaryColor: Color.fromRGBO(146, 40, 105, 1),
            accentColor: Color(0xFFF2F6F9),
            // accentColor: Color(0xFFf2f6f9),
            canvasColor: Color.fromRGBO(225, 254, 229, 1),
            errorColor: Colors.redAccent,
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(255, 231, 255, 1),
                  ),
                  bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 31, 51, 1),
                  ),
                  headline6: TextStyle(
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                  ),
                ),
          ),
          initialRoute: '/',
          onGenerateRoute: AppRoutes.generateRoute,
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => Login());
          },
        ),
      ),
    );
  }
}
