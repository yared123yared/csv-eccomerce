import 'package:app/Blocs/cart/bloc/add-client/bloc/add_client_bloc.dart';
import 'package:app/Blocs/Payments/bloc/bankslip_bloc.dart';
import 'package:app/Blocs/Payments/payments_cubit.dart';
import 'package:app/Blocs/categories/bloc/categories_bloc.dart';
import 'package:app/Blocs/credit/bloc/credit_bloc.dart';
import 'package:app/Blocs/dashBoard/dailyChart/bloc/daily_chart_bloc.dart';
import 'package:app/Blocs/dashBoard/monthlyChart/bloc/monthly_chart_bloc.dart';
import 'package:app/Blocs/dashBoard/numbers/bloc/number_dashboard_bloc.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/bloc/allorderr_bloc.dart';
import 'package:app/Blocs/orderDrawer/AllOrder/cubit/allorders_cubit.dart';
import 'package:app/Blocs/orderDrawer/OrderByDebt/bloc/orderbydebt_bloc.dart';
import 'package:app/Blocs/orders/bloc/orders_bloc.dart';
import 'package:app/data_provider/categories_data_provider.dart';
import 'package:app/data_provider/credit_data_provider.dart';
import 'package:app/data_provider/dashboard/daliy_chart_data_provider.dart';
import 'package:app/data_provider/dashboard/monthly_chart_data_provider.dart';
import 'package:app/data_provider/dashboard/recent_data_provider.dart';
import 'package:app/data_provider/orderDrawer/all_order_data_provider.dart';
import 'package:app/data_provider/orders_data_provider.dart';
import 'package:app/data_provider/reports/custom_debt_data_provider.dart';
import 'package:app/repository/categories_repository.dart';
import 'package:app/repository/credit_repository.dart';
import 'package:app/repository/location_repository.dart';
import 'package:app/repository/orders_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'Blocs/cart/bloc/cart_bloc.dart';
import 'Blocs/client_address/address/bloc/address_id_bloc.dart';
import 'Blocs/client_address/bloc/client_address_bloc.dart';
import 'Blocs/currency/bloc/currencysymbol_bloc.dart';
import 'Blocs/dashBoard/recentOrder/bloc/recent_order_bloc.dart';
import 'Blocs/location/bloc/location_bloc.dart';
import 'Blocs/orderDrawer/AllOrderDetails/bloc/allorderdetails_bloc.dart';
import 'Blocs/orderDrawer/OrderByDebt/orderByDebt_cubit.dart';
import 'Blocs/reports/CollectionReport_cubit/bloc/collection_bloc.dart';
import 'Blocs/reports/CollectionReport_cubit/collectionreport_cubit.dart';
import 'Blocs/reports/CustomerDebt/bloc/custom_debt_bloc.dart';
import 'Blocs/reports/SalesRepor_cubit/bloc/sales_report_bloc.dart';
import 'data_provider/client_address_data_provider/client_address_data_provider.dart';
import 'data_provider/currencySymbol/symbolDataProvider.dart';
import 'data_provider/dashboard/numbers_data_provider.dart';
import 'data_provider/orderDrawer/order_details_data_provider.dart';
import 'data_provider/orderDrawer/orderbyDebt_data_provider.dart';
import 'data_provider/payments/payment_data_provider.dart';
import 'data_provider/product_data_provider.dart';
import 'data_provider/reports/collection_data_provider.dart';
import 'data_provider/reports/salesReport_data_provider.dart';
import 'language/bloc/cubit/language_cubit.dart';
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

String language = "????????";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  http.Client httpClient = http.Client();

  final UserPreferences userPreferences = UserPreferences();

  await userPreferences.getLanguagePref("language");

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
        httpClient: httpClient, userPreferences: userPreferences),
  );
  final CreditRepository creditRepository = CreditRepository(
    creditDataProvider: CreditDataProvider(
        httpClient: httpClient, userPreferences: userPreferences),
  );
  final LocationRepository locationRepository = LocationRepository();

  runApp(
    App(
      userPreferences: userPreferences,
      productRepository: productRepository,
      userRepository: userRepository,
      clientsRepository: clientRepository,
      categoryRepository: categoryRepository,
      orderRepository: orderRepository,
      locationRepository: locationRepository,
      creditRepository: creditRepository,
      // scrollController: scrollController,
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final ProductRepository productRepository;
  final UserPreferences userPreferences;
  final ClientsRepository clientsRepository;
  final CategoryRepository categoryRepository;
  final OrderRepository orderRepository;
  final CreditRepository creditRepository;

  App({
    required this.userRepository,
    required this.productRepository,
    required this.userPreferences,
    required this.clientsRepository,
    required this.categoryRepository,
    required this.orderRepository,
    required this.locationRepository,
    required this.creditRepository,
  });

  final LocationRepository locationRepository;

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
          BlocProvider<CreditBloc>(
            create: (_) => CreditBloc(creditRepository: this.creditRepository),
          ),
          BlocProvider<ClientsBloc>(
            create: (_) => ClientsBloc(
              clientsRepository: this.clientsRepository,
              orderRepository: this.orderRepository,
            )..add(FetchClientsEvent(loadMore: true)),
          ),
          BlocProvider<CategoriesBloc>(
            create: (_) =>
                CategoriesBloc(categoryRepository: this.categoryRepository)
                  ..add(FetchCategories()),
          ),
          BlocProvider<OrdersBloc>(
            create: (_) => OrdersBloc(
              orderRepository: this.orderRepository,
              preferences: this.userPreferences,
            )..add(PaymentInitialization()),
          ),
          //
          BlocProvider<AddClientBloc>(
            create: (_) => AddClientBloc(),
          ),
          //
          BlocProvider<LocationBloc>(
            create: (_) =>
                LocationBloc(locationRepository: this.locationRepository),
          ),
          BlocProvider<SalesReportBloc>(
            create: (_) => SalesReportBloc(
              SalesReportDataProvider(userPreferences),
            ),
          ),
          BlocProvider<CollectionReportCubit>(
              create: (BuildContext context) =>
                  CollectionReportCubit(userPreferences)),
          BlocProvider<CollectionBloc>(
            create: (_) => CollectionBloc(
              CollectionDataProvider(userPreferences),
            ),
          ),

          BlocProvider<CustomDebtBloc>(
            create: (_) => CustomDebtBloc(
              CustomDebtDataProvider(userPreferences),
            ),
          ),
          BlocProvider<AllOrdersCubit>(
              create: (_) => AllOrdersCubit(userPreferences)),
          BlocProvider<AllorderrBloc>(
            create: (_) => AllorderrBloc(
              AllOrderDataProvider(userPreferences),
            )..add(FeatcAllorderrEvent()),
          ),
          BlocProvider<OrderByDebtCubit>(
              create: (_) => OrderByDebtCubit(userPreferences)),
          BlocProvider<OrderbydebtBloc>(
              create: (_) => OrderbydebtBloc(
                    OrderByDebtDataProvider(userPreferences),
                  )..add(FeatchOrderbydebtEvent())),

          BlocProvider<PaymentsCubit>(
              create: (_) => PaymentsCubit(userPreferences)),
          BlocProvider<BankslipBloc>(
            create: (_) => BankslipBloc(
              PaymentDataProvider(userPreferences),
            ),
          ),
          BlocProvider<NumberDashboardBloc>(
            create: (_) => NumberDashboardBloc(
              NumbersDataProvider(userPreferences),
            ),
          ),
          BlocProvider<RecentOrderBloc>(
              create: (_) => RecentOrderBloc(
                    RecentDataProvider(userPreferences),
                  )),
                  
          BlocProvider<DailyChartBloc>(
              create: (_) => DailyChartBloc(
                    DailyChartDataProvider(userPreferences),
                  )),
          BlocProvider<MonthlyChartBloc>(
            create: (_) => MonthlyChartBloc(
              MOnthlyChartDataProvider(userPreferences),
            ),
          ),

          BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
          BlocProvider<AllorderdetailsBloc>(
            create: (_) => AllorderdetailsBloc(
              OrderDetailsDataProvider(userPreferences),
            ),
          ),
          BlocProvider<ClientAddressBloc>(
            create: (_) => ClientAddressBloc(
              ClientAddressDataProvider(userPreferences),
            ),
          ),
          BlocProvider<AddressIdBloc>(
            create: (_) => AddressIdBloc(
              ClientAddressDataProvider(userPreferences),
            ),
          ),
          BlocProvider<CurrencySymbolbloc>(
            create: (_) => CurrencySymbolbloc(
              SymbolDataProvider(userPreferences),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'CSV',
          debugShowCheckedModeBanner: false,
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

//flutter run --no-sound-null-safety
//adrain.beahan@mailinator.com  