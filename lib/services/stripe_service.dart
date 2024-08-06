import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_payment/consts.dart';

class StripeService{
StripeService._();
static final StripeService instance = StripeService._();

Future<void> makePayment() async{
  try{
String? paymentIntentClientSecret = await createPayment(10, "usd");
if(paymentIntentClientSecret ==null) return;
await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
  paymentIntentClientSecret: paymentIntentClientSecret,
  merchantDisplayName: "Abir Bin Billal"
),);
await _processPayment();
  }catch(e){
    print(e);
  }
}
Future<String?> createPayment(int amount , String currency) async{
  try{
    final Dio dio = Dio();
    Map<String , dynamic> data = {
      "amount": _calculatedAmount(amount),
      "currency":  currency,
    };
    var response = await dio.post("https://api.stripe.com/v1/payment_intents",
    data: data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Authorization" : "Bearer ${stripeSecretKey}",
          "Content-Type" : 'application/x-www-form-urlencoded'
        }
      )
    );
    if(response.data != null){
      print(response.data);
      return response.data["client_secret"];
    }else{
      print("null");
    }
    await _processPayment();
  }catch(e){
    print(e);
  }
  return null;
}
Future<void> _processPayment()async{
  try{
    await Stripe.instance.presentPaymentSheet();
  }catch(e){
    print(e);
  }
}
String _calculatedAmount(int amount){
  int calculatedAmount = amount * 100 ;
  return calculatedAmount.toString();
}
}