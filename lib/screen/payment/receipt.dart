
import 'package:coffeeurge/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../apis/cart_api.dart';
import '../../apis/payment_api.dart';
import '../../components/app_properties.dart';
import '../../components/error _snackbar.dart';
import '../../components/route.dart';
import '../../components/user_input_feild.dart';
import '../Order/order_screen.dart';
import '../Product/product_screen.dart';

class OrderDetails extends StatefulWidget {
  final bool cod;
  final bool online;
  final List<ProductPageclass> product;
  final Map<String, dynamic> adr;

  OrderDetails(
      {required this.cod,
      required this.online,
      required this.product,
      required this.adr});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late Razorpay _razorpay;
  final UserInputFeild feild = UserInputFeild();
  bool isloading = false;
  String paymentID = "";

Future<void> pay()async{
   if (widget.product[0].desc == "carttofork") {
     bool order =  await CartAPI.addCartOrder(aid: widget.adr['aID'],
          paymentID: "$paymentID",
          paymentStatus: "success");

          if(order){
             InputComponent.showErrorDialogBox(
        context, "Order Placed", "Order");
          Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        RouterClass.AddScreen(context, Order());
                  
       
          }else{
            InputComponent.showErrorDialogBox(
        context, "Order Failed", "Order");
          }


    } else {
      Map<dynamic, dynamic> order = await PaymentAPI.order(
          bookID: widget.product[0].bid,
          aID: widget.adr['aID'],
          paymentID: "$paymentID",
          paymentStatus: "success");
          if(order['success']){
             InputComponent.showErrorDialogBox(
        context, "Order Placed", "Order");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        RouterClass.AddScreen(context, Order());
          }else{
            InputComponent.showErrorDialogBox(
        context, "Order Failed", "Order");
          }
    }
}


  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    
   await pay();
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    if (widget.product[0].desc == "carttofork") {
     bool order =  await CartAPI.addCartOrder(aid: widget.adr['aID'],
          paymentID: "$paymentID",
          paymentStatus: "Failed");

          if(order){
             InputComponent.showErrorDialogBox(
        context, "Payment Failed Please wait for 24 hours before making pauymetn again ", "Cart Payment");
          }else{
         InputComponent.showErrorDialogBox(
        context, "Payment Failed Please wait for 24 hours before making pauymetn again ", "Cart Payment");
          }


    } else {
      Map<dynamic, dynamic> order = await PaymentAPI.order(
          bookID: widget.product[0].bid,
          aID: widget.adr['aID'],
          paymentID: "$paymentID",
          paymentStatus: "Failed");

          if(order['success']){
             InputComponent.showErrorDialogBox(
        context, "Payment success", "Payment");
          }else{
            InputComponent.showErrorDialogBox(
        context, "Payment Failed", "Order Payment Failed");
          }
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
// Do something when an external wallet is selected
  }

  void checkout(dynamic amount, String orderID, String key) {
    amount = (amount + 40) * 100;
    var options = {
      "key": key,
      "amount": amount,
      "name": "ExBook",
      'order_id': orderID,
      "timeout": 600,
      'prefill': {"contact": "1234567890", "email": "ad@gmail.com"},
      "external": {
        "wallets": ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (error) {
      InputComponent.showWarningSnackBar(context, "$error");
    }
  }

  Future<void> createOrder() async {
    try {
      Map<dynamic, dynamic> order = await PaymentAPI.gerOrderDetails(
          amount: (widget.product[0].price + 40) * 100);

      if (order['success']) {
        setState(() {
          paymentID = order['order']['id'];
          checkout(widget.product[0].price, order['order']['id'], order['key']);
        });
      } else {
        InputComponent.showWarningSnackBar(context, "Server Error");
      }
    } catch (error) {
      InputComponent.showWarningSnackBar(context, "$error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:BackgroundColor,
      appBar: CustomAppBar.screenAppbar("Order", context),
      body: Padding(
        padding: EdgeInsets.zero, // Remove padding from all sides
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                width: 315,
                // alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "${widget.adr["country"]}, ${widget.adr['state']}, ${widget.adr['city']}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.adr['location']} - ${widget.adr['pin']}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      decoration: const BoxDecoration(
                        color: Color(0xffEAEAEA),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: mediaQuery.height * 0.3,
                          width: mediaQuery.width * .6,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset: Offset(
                                    0, 1), // Offset in x and y directions
                              ),
                            ],
                          ),
                          child: Image.network(
                            "$apilink/${widget.product[0].imageUrl}",
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.product[0].name}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${widget.product[0].author}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 4,
                decoration: const BoxDecoration(color: Color(0xffF4F4F4)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 315,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Summary",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "\₹ ${widget.product[0].price}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Fee",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "\₹ 150",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "\₹ 40",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Payment",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "\₹ ${widget.product[0].price + 40}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 376,
                height: 161,
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 315,
                      height: 62,
                      child: feild.buttonContainer(context, "Order", () async {
                        if (widget.cod) {
                          pay();
                         
                        } else if (widget.online) {
                          await createOrder();

                          // Navigate to Online payment screen
                        }
                      }, isloading),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
