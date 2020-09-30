import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/screens/base/base_screen.dart';
import 'package:ventura_rh/screens/login/login_screen.dart';


import 'SplashScreen.dart';
import 'models/users/user_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  runApp(MyApp());
}

Future<void> initializeParse() async{
  await Parse().initialize(
    'qGZcg2jD43HfFw6YAbpcfN7RQgFB0udZIgtWWvw6',
    'https://parseapi.back4app.com/',
    clientKey: 'nZbpDwex4JsskmE02Lp9oEpzlD6vQWeEnFCZ54P3',
    autoSendSessionId: true,
    debug: true,
  );

}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ventura HR',
        theme: ThemeData(

          primaryColor: const Color.fromARGB(255, 0, 131 , 143),
          scaffoldBackgroundColor: const Color.fromARGB(255, 197, 200, 200),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/base':
              return MaterialPageRoute(builder: (_) => SplashScreen());

            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}












