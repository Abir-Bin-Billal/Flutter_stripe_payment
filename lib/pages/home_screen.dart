import 'package:flutter/material.dart';
import 'package:flutter_stripe_payment/services/stripe_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Stripe Payment Method",
       style: TextStyle(
         fontSize: 20,
         fontWeight: FontWeight.w400,
         color: Colors.black
       ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.green,
              child: Text("Purchase"),
                onPressed: (){
                StripeService.instance.makePayment();
                },)
          ],
        ),
      ),
    );
  }
}