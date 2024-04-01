import 'package:flutter/material.dart';

import '../../apis/order_api.dart';
import '../../components/app_properties.dart';
import '../../components/custom_appbar.dart';
import '../../components/order_build.dart';
import '../../components/shimmer_effect.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
   List orderList = [];
  bool iscoffeeLoaded = false;

   Future<void> fetchOrder() async {
  List<dynamic> newListCategory = await OrderAPI.getUserOrderss();
  if (mounted) { // Check if the widget is still moun
    if (newListCategory.isNotEmpty) {
      setState(() {
        orderList.addAll(newListCategory);
        print(orderList);
        iscoffeeLoaded = true;
      });
    }else{
      setState(() {
        iscoffeeLoaded = true;
      });
    }
  }
}


List<Widget> screen() {
    if (iscoffeeLoaded) {
       if(orderList.isEmpty){

        List<Widget> data = [];
         data.add(  Center(
                    child: Text('No Coffee Found',
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  ));
        return data;
      }
      return OrderBuild.buildOrder(context, orderList);
    } else {
      return ShimmerEffect.yourcoffeesShimmer(context);
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar.screenAppbar("Orders",context),
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
          
        ],
      ),
    );
  }
}