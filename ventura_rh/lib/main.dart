import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventura_rh/screen/address/address_creen.dart';
import 'package:ventura_rh/screen/base/base_screen.dart';
import 'package:ventura_rh/screen/login/login_page.dart';
import 'package:ventura_rh/screen/splash/splash_screen.dart';
import 'package:ventura_rh/screen/vaga/vaga_details/vaga_details2.dart';
import 'package:ventura_rh/screen/vaga/vaga_edit/vaga_edit.dart';
import 'package:ventura_rh/screen/vaga/vagas_respondidas/user_vaga_details2.dart';
import 'models/users/user_manager.dart';
import 'models/vaga/resposta_vaga/vacancies_answered.dart';
import 'models/vaga/vaga.dart';
import 'models/vaga/vaga_manager.dart';

void main() async {
  runApp(MyApp());
  //final QuerySnapshot doc1 = await Firestore.instance.document('users/k3TMcoVPXbdTXrGMhCrLg7zl31p1').collection('vacanciesAnswered').getDocuments();
  //final QuerySnapshot doc2 = await Firestore.instance.document('users/B4RFyDIQmIVCCYsfirTqSFQcWxi1').collection('vacancyResponse').getDocuments();
  //final DocumentSnapshot doc2 = await Firestore.instance.document('users/k3TMcoVPXbdTXrGMhCrLg7zl31p1').collection('vacancyResponse').document('UXLmUvgzRmFCtovMw1VT').get();
  //final DocumentSnapshot doc3 = await Firestore.instance.document('users/k3TMcoVPXbdTXrGMhCrLg7zl31p1').collection('vacancyResponse').document('UXLmUvgzRmFCtovMw1VT').get();
 // print(doc1.documents.map((e) => print(e.data)));
  //print(doc2.documents.map((e) => print(e.data)));
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
        ChangeNotifierProxyProvider<UserManager, VagaManager>(
          create: (_) => VagaManager(),
          update: (_,userManager, vagaManager) =>
          vagaManager..updateUser(userManager),
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
                  builder: (_) => VagaDetails2(settings.arguments as Vaga,vagaRespondida: false,));

            case '/vaga_edit':
              return MaterialPageRoute(
                  builder: (_) => VagaEdit(settings.arguments as Vaga,));
            case '/userVagaDetails':
              return MaterialPageRoute(
                  builder: (_) => UserVagaDetails2(settings.arguments as VacanciesAnswered,));

            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
