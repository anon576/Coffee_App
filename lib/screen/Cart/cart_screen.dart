
import "package:flutter/material.dart";
import "../../apis/cart_api.dart";
import "../../components/app_properties.dart";
import "../../components/cart_buill.dart";
import "../../components/custom_appbar.dart";
import "../../components/route.dart";
import "../../components/share_prefs.dart";
import "../../components/shimmer_effect.dart";
import "../Product/product_screen.dart";
import "../payment/payment_option.dart";


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

 List cartList = [];
  bool isCartLoaded = false;
  dynamic totalprice = 0;

 Future<void> fetchCart() async {
  List<dynamic> newListCategory = await CartAPI.getAllCart();
  if (mounted) { // Check if the widget is still mounted
    if (newListCategory.isNotEmpty) {
      setState(() {
        cartList.addAll(newListCategory);
        isCartLoaded = true;
      });
    }else{
      setState(() {
        isCartLoaded = true;
      });
    }
  }
}


  List<Widget> screen() {
    if (isCartLoaded) {
      if(cartList.isEmpty){
        List<Widget> returnData = [];
        returnData.add(  
          Center(
                    child:Text(
            'No Coffee Found',
          style: TextStyle(
              color: Colors.white
           )
          )));

        return returnData;
      }
      for(var item in cartList){
        totalprice = totalprice + item['price'];
      }
      
      return CartBuild.buldCart(context, cartList,(){
        setState(() {
          
        });
      });
    } else {
      return ShimmerEffect.cartShimmer(context);
    }
  }

  @override
  void initState() {
    fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final mediaQuery = MediaQuery.of(context).size;
    return Scaffold( 
       backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: screen()
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price: $totalprice',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
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
                        onPressed: ()async {
                          List<ProductPageclass> product = [];


//  final String name;
  // final String imageUrl;
  // final dynamic price;
  // final String author;
  // final String desc;
  // final String category;
  // final dynamic uid;
  // final dynamic bid;


                          product.add((ProductPageclass(author: "Cart is ready",name: await SharePrefs.readPrefs("name", "string"),imageUrl: "uploadImage/logo.png",price: totalprice,desc: "carttofork",category: "cart",uid: await SharePrefs.readPrefs("userID", "int"),bid: 0)));
                          RouterClass.AddScreen(context, PaymentOption(totalprice: totalprice, product: product));
                        },
                        child: Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white),
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