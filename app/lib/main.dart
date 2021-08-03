import 'package:app/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'data_provider/product_data_provider.dart';
import 'models/product/product.dart';
import 'route/route.dart';
import 'screens/login.dart';
import 'data_provider/user_data_provider.dart';
import 'repository/user_repository.dart';
import 'preferences/user_preference_data.dart';
import 'Blocs/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  http.Client httpClient = http.Client();

  final UserPreferences userPreferences = UserPreferences();
  final UserRepository userRepository = UserRepository(
    userDataProvider: UserDataProvider(
      httpClient: httpClient,
      userPreferences: userPreferences,
    ),
  );
  // final ProductRepository prodcutRepository = ProductRepository(
  //   productDataProvider: ProductDataProvider(
  //     httpClient: httpClient,
  //   ),
  // );
  // Products products = await prodcutRepository.getProducts();
  // print(products.data);

  runApp(App(
    userPreferences: userPreferences,
    userRepository: userRepository,
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final UserPreferences userPreferences;
  App({
    required this.userRepository,
    required this.userPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => this.userRepository,
        ),
        RepositoryProvider<UserPreferences>(
          create: (_) => this.userPreferences,
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
        ],
        child: MaterialApp(
          title: 'CSV',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color(0xFF015777),
            // primaryColor: Color.fromRGBO(146, 40, 105, 1),
            accentColor: Color(0xFFf2f6f9),
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
