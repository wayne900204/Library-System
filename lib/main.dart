import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_system/rent_system/bloc/qr_code_bloc.dart';
import 'package:library_system/rent_system/repository/qr_code_repository.dart';
import 'package:library_system/rent_user_info/bloc/renter_data_bloc.dart';


import 'book_info/bloc/book_info_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => QrCodeBloc(new QrCodeRepository()),
        ),
        BlocProvider(create: (context)=> RenterDataBloc()),
        BlocProvider(create: (context)=> BookInfoBloc())
      ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.cyan,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            "/": (context) => MainPage(),
            "/mainPage": (context) => MainPage()
          },
        ),
    );
  }
}
