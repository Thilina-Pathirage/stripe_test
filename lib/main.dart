import 'package:flutter/material.dart';
import 'package:stripe_test/screens/dashboard_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  Stripe.publishableKey = 'pk_test_51KlQoZAqcUTu4S7FFXyimJYyISazMZQQIEDIT3oNR3Kv2sKGUp2xpTtSzJijd0un6HSNiJQAHpc9HWlPqdd1ScLg00RB6LqNZE';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}
