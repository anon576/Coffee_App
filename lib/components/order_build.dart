
import 'package:flutter/material.dart';
import '../screen/Order/order_details.dart';
import 'app_properties.dart';
import 'route.dart';

class OrderBuild {
  static List<Widget> buildOrder(BuildContext context, List<dynamic> data) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> returnData = [];

    for (var item in data) {
      returnData.add(Container(
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            height: mediaQuery.height * .245,
            width: mediaQuery.width * .4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.network(
              "$apilink/${item['imagepath']}",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                height: mediaQuery.height * .07,
                width: mediaQuery.width * .5,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "${item['bookname']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                height: mediaQuery.height * .07,
                width: mediaQuery.width * .5,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "${item['price']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                height: mediaQuery.height * .07,
                width: mediaQuery.width * .5,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12)),
                child: TextButton(
                  onPressed: () {
                   RouterClass.AddScreen(context, OrderDetailsScreen(
                          bookname: item['bookname'],
                          imageUrl: item['imagepath'],
                          author: item['author'],
                          price: item['price'],
                          date: item['order_date'],
                          paymentStatus: item['paymentStatus'],
                          country: item['country'],
                          state: item['state'],
                          city: item['city'],
                          pin: item['pin'],
                          location: item['location']
                   ));
                   
                  },
                  child: Text(
                    "View Order",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ]),
      ));
    }
    return returnData;
  }

  static Widget buildInfoContainer(BuildContext context, dynamic data) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: mediaQuery.height * .03,
      width: mediaQuery.width * .5,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(2)),
      child: Text(
        "${data}",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
