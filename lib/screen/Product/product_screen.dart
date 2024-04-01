
import 'package:flutter/material.dart';

import '../../apis/cart_api.dart';
import '../../components/app_properties.dart';
import '../../components/custom_appbar.dart';
import '../../components/error _snackbar.dart';
import '../../components/route.dart';
import '../payment/payment_option.dart';

class ProductPageclass {
  final String name;
  final String imageUrl;
  final dynamic price;
  final String author;
  final String desc;
  final String category;
  final dynamic uid;
  final dynamic bid;


  ProductPageclass(
      {required this.name, required this.imageUrl, required this.price, required this.author, required this.desc, required this.category, required this.uid, required this.bid});
}

class ProductPage extends StatelessWidget {

  final List<ProductPageclass> product;

  ProductPage({required this.product});

  Future<void> addtocart(BuildContext context)async{
    try{
      Map<dynamic,dynamic> cart = await CartAPI.addToCart(bookID: product[0].bid);
      if(cart['success']){
        InputComponent.showErrorDialogBox(context, "Added to cart", "Cart");
      }else{
        InputComponent.showWarningSnackBar(context, "Server Error");
      }
    }catch(er){
      InputComponent.showWarningSnackBar(context, "$er");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar:CustomAppBar.screenAppbar("Product",context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: mediaQuery.height * 0.5,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 1, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: Offset(0, 1), // Offset in x and y directions
                        ),
                      ],
                    ),
                    child: Image.network(
                      "$apilink/${product[0].imageUrl}",
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    product[0].name,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Auhor/Publication : ${product[0].author}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '${product[0].desc}',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                     color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Price: ₹${product[0].price}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white,
                          fontSize: 17),
                    ),
                   
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: mediaQuery.height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffC67C4E),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await addtocart(context);
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
                      height: mediaQuery.height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffC67C4E),
                      ),
                      child: TextButton(
                        onPressed: () {
                          RouterClass.AddScreen(context, PaymentOption(totalprice:product[0].price,product:product));
                        },
                        child: Text(
                          'Buy Now',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
