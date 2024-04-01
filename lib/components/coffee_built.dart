
import "package:flutter/material.dart";

import '../apis/coffee_api.dart';
import '../screen/Coffee/coffee_screen.dart';
import '../screen/Coffee/updatecoffee.dart';
import "app_properties.dart";
import "error _snackbar.dart";
import "route.dart";

class CoffeeBuild {
  static List<Widget> buildcoffee(BuildContext context, List<dynamic> data) {
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
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: Offset(0, 3), // Offset in x and y directions
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
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                height: mediaQuery.height * .07,
                width: mediaQuery.width * .5,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(12)),
                child: TextButton(
                  onPressed: () {
                    RouterClass.AddScreen(context,Updatecoffee(initialcoffeeName: item['coffeename'], 
                    initialcoffeePrice: item['price'], initialcoffeeAuthor: item['author'], initialcoffeeDesc: item['description'], initialcoffeeImage: item['imagepath'], category: item['category'],
                    bid: item["bID"],));
                  },
                  child: Text(
                    "Edit coffee",
                    style: TextStyle(color: Colors.black),
                  ),
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
                  onPressed: () async{
                    bool coffee = await  CoffeeAPI.deletecoffee(bid: item["bID"]);
                    if(coffee){
  Navigator.pop(context);
  RouterClass.AddScreen(context, coffees());
                    }else{
  InputComponent.showWarningSnackBar(context, "Server Error");
                    }
                  },
                  child: Text(
                    "Remove coffee",
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
