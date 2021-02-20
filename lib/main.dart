import 'package:mvc_shopper/src//view.dart';

void main() => runApp(MyApp());

class MyApp extends AppStatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  AppState createView() => ShopperApp();
}

// class MyApp extends StatelessWidget {
//   MyApp({Key key}):super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Using MultiProvider is convenient when providing multiple objects.
//     return MultiProvider(
//       providers: [
//         // In this sample app, CatalogModel never changes, so a simple Provider
//         // is sufficient.
//         Provider(create: (context) => CatalogModel()),
//         // CartModel is implemented as a ChangeNotifier, which calls for the use
//         // of ChangeNotifierProvider. Moreover, CartModel depends
//         // on CatalogModel, so a ProxyProvider is needed.
//         ChangeNotifierProxyProvider<CatalogModel, CartModel>(
//           create: (context) => CartModel(),
//           update: (context, catalog, cart) {
//             cart.catalog = catalog;
//             return cart;
//           },
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Provider Demo',
//         theme: appTheme,
//         initialRoute: '/',
//         routes: {
//           '/': (context) => MyLogin(),
//           '/catalog': (context) => MyCatalog(),
//           '/cart': (context) => MyCart(),
//         },
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
