import 'package:mvc_shopper/src/view.dart';

class ShopperApp extends AppState {
  ShopperApp()
      : super(
          title: 'MVC Demo',
          initialRoute: '/',
          routes: {
            '/': (context) => const MyLogin(),
            '/catalog': (context) => MyCatalog(),
            '/cart': (context) => const MyCart(),
          },
          debugShowCheckedModeBanner: false,
        );

  @override
  ThemeData onTheme() => ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'Corben',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      );
}
