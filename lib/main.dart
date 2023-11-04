import 'package:appbook/module/cart/cart_screen.dart';
import 'package:appbook/module/detail/detail_page.dart';
import 'package:appbook/module/home/home_page.dart';
import 'package:appbook/module/signin/signin_page.dart';
import 'package:appbook/module/signup/signup_page.dart';
import 'package:appbook/shared/constants.dart';
import 'package:appbook/shared/widget/app_color.dart';
import 'package:appbook/shared/widget/menubottom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColor.green,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
       '/': (context) => SignInPage(),
        '/sign-in':(context) => SignInPage(),
        '/sign-up':(context) => SignUpPage(),
        '/home':(context) => Home(),
        '/detail':(context) => DetailPage(),
        '/:tab':(context) => MenuBottom(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}


