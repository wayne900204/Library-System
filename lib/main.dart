import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/bloc/qr_code_bloc.dart';
import 'package:library_system/repository/qr_code_repository.dart';

import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrCodeBloc(new QrCodeRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/": (context) => MainPage(),
          "/mainPage": (context) => MainPage()
        },
      ),
    );
  }
}
