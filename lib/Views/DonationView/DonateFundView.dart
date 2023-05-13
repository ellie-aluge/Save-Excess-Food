import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class DonateFundView extends StatefulWidget {
  const DonateFundView({Key? key}) : super(key: key);

  @override
  State<DonateFundView> createState() => _DonateFundViewState();
}

class _DonateFundViewState extends State<DonateFundView> {
  String? _paymentIntentClientSecret;

  Map <String, dynamic>? paymentIntent;
  int selected =0;
  final donationAmountController = TextEditingController();
  String fund= "Enter the amount manually";
  double? donationAmount;
  final _formKey = GlobalKey<FormState>();
  bool _showPrefix = false;
  Widget customRadio(String amount, int index){

    return SizedBox(
      height: 50,
        width:100,
        child :OutlinedButton
        (
        onPressed: (){
      setState(() {
        selected=index;
        fund = amount.replaceAll(RegExp('[^0-9]'), '');
        donationAmountController.text = fund;

      });
    }, child: Text(amount, style: TextStyle(
    color: (selected==index)? GlobalColors.titleHeading : Colors.black
    ),),

    style: ButtonStyle(
    side: MaterialStateProperty.all<BorderSide>(
    BorderSide(color:(selected==index)? GlobalColors.titleHeading: GlobalColors.inputBorder )
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    ),
    ),
    );

  }


  Future <void> donate() async {
    try {

      print ("here");
      //STEP 1: Create Payment Intent
      WidgetsFlutterBinding.ensureInitialized();
      Stripe.publishableKey =
      "pk_test_51L7gEWHCNwHv6amdoazGLKNAE80S8wJcwcBLLqTpyrMyAB8UUVVTjrPRygbd89a3REo6Mwu735CVLBWYNzZ0Myuj00pClhmSwT";
      await Stripe.instance.applySettings();
      final response = await http.post(
          Uri.parse(
              'https://us-central1-save-excess-food.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': "alugeelinor@gmail.com",
            'amount': "10000",
          });

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());

      //2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
        ),
      );


    } catch (err) {
      throw Exception(err);
    }
    displayPaymentSheet();
  }

//   createPaymentIntent(String amount, String currency) async {
//     try {
//        //Request body
//
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//       };
// print ("next");
//       //Make post request to Stripe
//
//       var response = await http.post(
//         Uri.parse('https://us-central1-save-excess-food.cloudfunctions.net/stripePaymentIntentRequest'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['stripeSecretKey']}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

  displayPaymentSheet() async {
    try {

      print("four");
      await Stripe.instance.presentPaymentSheet().then((value) {

        print ("foir");
        //Clear paymentIntent variable after successful payment
        paymentIntent = null;

      })
          .onError((error, stackTrace) {
        throw Exception(error);
      });
    }
    on StripeException catch (e) {
      print('Error is:---> $e');
    }
    catch (e) {
      print('$e');
    }
  }


  @override
  void initState() {
    super.initState();
    donationAmountController.addListener(() {
      setState(() {
        _showPrefix = donationAmountController.text.isNotEmpty;
        donationAmount = double.tryParse(donationAmountController.text);
       final d=this.donationAmount;
        print(donationAmount);
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color:GlobalColors.titleHeading ,),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Donation", style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: SingleChildScrollView(

      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
                // padding: EdgeInsets.only(top:30, left:20, right:20),
                margin: EdgeInsets.only(top: 10, left:20, right:20 ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height *0.24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    scale: 3.5,
                    image: AssetImage('assets/admin/donateFund.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                )
            ),

            SizedBox(height:20),
            Container(
              padding: EdgeInsets.only(left:20, right:20),
              // margin: EdgeInsets.only(left: 30),
              // width: MediaQuery.of(context).size.width * 0.7,
              child :Text("Donations help to feed several people living in vulnerable situations",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
            ),

            //Making image to icons
            // ImageIcon(AssetImage('assets/admin/SEF_white.png'),

            Container(
              padding: EdgeInsets.only(left:20, right:20),
              child:  Row(

                children: [
                  Image.asset(
                    'assets/admin/ngoLogo.png',
                    height: 50,
                    width: 30,
                  ),
                  Text("The Lost Food Project", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12),),
                ],
              ),
            ),

            SizedBox(height:20),
            Container(
              padding: EdgeInsets.only(left:20),
              child:   Text("Choose Amount", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
            ),
            SizedBox(height: 30),
            Container(
                padding: EdgeInsets.only(left:25, right:25),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  customRadio("MYR50", 1),

                  customRadio("MYR100", 2),

                  customRadio("MYR500", 3),
                ],

              )
            ),

            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 20.0, right:20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            Center(
              child :Container(

              alignment: Alignment.center,
              width: 200,
              // margin: EdgeInsets.symmetric(horizontal: 30),
              // padding: EdgeInsets.only(left:40, right:40),
              child: Form(
                key: _formKey,
                child: TextFormField(

                    controller: donationAmountController,
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      if (donationAmount == null) {
                        return 'Please enter a number only';
                      }

                      final donation = this.donationAmount;
                       if (donation!=null) {
                        if(donation<=10)
                        return 'Donation must be above MYR10';
                      }
                    },


                    onChanged: (value) {
                        donationAmount = double.tryParse(donationAmountController.text);
                        print(donationAmount);
                    },


                    textAlign: TextAlign.center,
                    decoration:  InputDecoration(

                      prefix: _showPrefix ?  Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text('MYR ', style: TextStyle(fontSize: 15,
                                    color: GlobalColors.orangeColor)),
                      ) : null,

                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: GlobalColors.inputBorder),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: GlobalColors.orangeColor),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 1),
                      counterText: "",
                      hintText: "Enter the amount manually",
                      hintStyle: TextStyle(
                          color:GlobalColors.formLabel,
                          fontWeight: FontWeight.w500,
                          fontSize: 10
                      ),

                    ),
                  style: TextStyle(fontSize: 15, color: GlobalColors.orangeColor, fontWeight: FontWeight.bold),
                ),


              ),


            ),
            ),

            Center(
              child: Container(
                  margin: const EdgeInsets.all(28),
                  width:300,
                  height:40,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: GlobalColors.titleHeading,

                    ),

                    onPressed: ()
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        donate();
                      }


                    },
                    child: const Text('DONATE NOW',
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  )
              ),
            ),

          ],
        ),
      ),
      )
      );

  }
}
