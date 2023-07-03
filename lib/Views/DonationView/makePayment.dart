// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// class MakePayment {
//   static Future<void> initializeStripe() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Stripe.instance.applySettings(
//       StripeSettings.publishableKey('pk_test_51L7gEWHCNwHv6amdoazGLKNAE80S8wJcwcBLLqTpyrMyAB8UUVVTjrPRygbd89a3REo6Mwu735CVLBWYNzZ0Myuj00pClhmSwT'),
//     );
//     await Stripe.instance.applySettings(
//       StripeSettings.setAndroidSettings(
//         StripeAndroidSettings(
//           stripeAccountId: 'YOUR_STRIPE_ACCOUNT_ID',
//           publishableKey: 'pk_test_51L7gEWHCNwHv6amdoazGLKNAE80S8wJcwcBLLqTpyrMyAB8UUVVTjrPRygbd89a3REo6Mwu735CVLBWYNzZ0Myuj00pClhmSwT',
//         ),
//       ),
//     );
//     await Stripe.instance.applySettings(
//       StripeSettings.setIosSettings(
//         StripeIosSettings(
//           publishableKey: 'pk_test_51L7gEWHCNwHv6amdoazGLKNAE80S8wJcwcBLLqTpyrMyAB8UUVVTjrPRygbd89a3REo6Mwu735CVLBWYNzZ0Myuj00pClhmSwT',
//         ),
//       ),
//     );
//   }
//
//   static Future<void> createPaymentMethod() async {
//     final paymentMethod = await Stripe.instance.createPaymentMethod(
//       PaymentMethodData.card(
//         billingDetails: BillingDetails(
//           email: 'johndoe@example.com',
//           name: 'John Doe',
//         ),
//       ),
//     );
//
//     // Process the payment method (e.g., send it to your server)
//     // You can access the payment method ID with paymentMethod.id
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Stripe Payment',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PaymentScreen(),
//     );
//   }
// }
//
// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   CardFieldInputDetails _cardInputDetails;
//
//   @override
//   void initState() {
//     super.initState();
//     MakePayment.initializeStripe();
//   }
//
//   Future<void> _makePayment() async {
//     if (_cardInputDetails?.complete ?? false) {
//       await MakePayment.createPaymentMethod();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stripe Payment'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CardField(
//               onCardChanged: (card) {
//                 setState(() {
//                   _cardInputDetails = card;
//                 });
//               },
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _makePayment,
//               child: Text('Pay'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
