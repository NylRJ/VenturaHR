import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/models/vaga/vaga.dart';
import 'package:ventura_rh/models/vaga/vaga_manager.dart';
import 'package:ventura_rh/screens/address/address_creen.dart';
import 'package:ventura_rh/screens/base/base_screen.dart';
import 'package:ventura_rh/screens/login/login_page.dart';
import 'package:ventura_rh/screens/splash/splash_screen.dart';
import 'package:ventura_rh/screens/vaga/vaga_details/vaga_details.dart';
import 'package:ventura_rh/screens/vaga/vaga_details/vaga_details2.dart';
import 'package:ventura_rh/screens/vaga/vaga_edit/vaga_edit.dart';


import 'models/users/user_manager.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventura HR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans',
        primaryColor: const Color.fromARGB(255, 0, 146, 164),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color.fromARGB(255, 118, 207, 218),
      ),
      home: const MyHomePage(title: 'Ventura HR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => VagaManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ventura HR',
        theme: ThemeData(
          fontFamily: 'sans',
          primaryColor: const Color.fromARGB(255, 0, 146, 164),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color.fromARGB(255, 118, 207, 218),
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
        ),
        initialRoute: '/splash',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginPage());
            case '/base':
              return MaterialPageRoute(builder: (_) => BaseScreen());
            case '/address':
              return MaterialPageRoute(
                  builder: (_) => AddressScreen());

            case '/splash':
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case '/vagaDetails':
              return MaterialPageRoute(
                  builder: (_) => VagaDetails2(settings.arguments as Vaga));

            case '/vaga_edit':
              return MaterialPageRoute(
                  builder: (_) => VagaEdit(settings.arguments as Vaga));

            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
