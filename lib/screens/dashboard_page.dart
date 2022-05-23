// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              makePayment();
            },
            child: const Text('Pay now!'),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    final url = Uri.parse(
        'https://us-central1-fastmart-a8959.cloudfunctions.net/stripePayment');
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    paymentIntentData = json.decode(response.body);

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'US',
            merchantDisplayName: 'ACCELR'));
    setState(() {});

    displayPaymentSheet();
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['PaymentIntent'],
              confirmPayment: true));
      setState(() {
        paymentIntentData = null;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(content: Text('Paid Successfully')));
    } catch (e) {
      print(e);
    }
  }
}
