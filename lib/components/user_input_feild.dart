
import 'package:flutter/material.dart';

import '../apis/user_api.dart';
import '../screen/Address/address.dart';
import '../screen/Address/update_address.dart';
import 'route.dart';


class UserInputFeild {
Widget inputContainerText(BuildContext context, TextEditingController inputController,
    String hinttext, Icon icon, {bool readOnly = false}) {
  final mediaQuery = MediaQuery.of(context).size;
  return Center(
    child: Container(
      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      width: mediaQuery.width * .71,
      height: mediaQuery.height * .06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: inputController,
        readOnly: readOnly,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hinttext,
          suffixIcon: icon,
        ),
      ),
    ),
  );
}


  Widget searchContainerText(BuildContext context,
      TextEditingController inputController, String hinttext, Icon icon) {
    final mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: mediaQuery.width * .76,
          height: mediaQuery.height * .06,
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: inputController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hinttext,
              suffixIcon: icon,
            ),
          ),
        ),
        SizedBox(
          width: mediaQuery.width * .01,
        ),
        Container(
          height: mediaQuery.height * .06,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xffC67C4E),
          ),
          child: IconButton(
            icon: Icon(Icons.filter_list_outlined),
            onPressed: () {
              print('Filter button pressed');
            },
            iconSize: mediaQuery.height * .04,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget buttonContainer(BuildContext context, String hintText,
      Future<void> Function() onPressed, bool isLoading) {
    final mediaQuery = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: mediaQuery.width * .71,
        height: mediaQuery.height * .06,
        decoration: BoxDecoration(
          color:const Color(0xffC67C4E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  hintText,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }

 
  static List<Widget> categoryContainer(
      BuildContext context, String image, List categoryName) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> data = [];
    for (var item in categoryName) {
      if(item == "Select Category"){
        continue;
      }
      data.add(Container(
        margin: EdgeInsets.fromLTRB(25, 10, 0, 10),
        height: mediaQuery.height * 0.2,
        width: mediaQuery.width * 0.88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors
              .white, // Set a background color to see if the container is visible
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover, // Adjust the image fit as needed
              ),
              Center(
                // bottom: 10,
                // right: 15,
                child: Container(
                  height: mediaQuery.height*.06,
                  width: mediaQuery.width*.5,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return data;
  }


static List<Widget> addressContainer(
      BuildContext context, List addresss) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> data = [];
    for (var item in addresss) {
      data.add(Container(
  margin: EdgeInsets.fromLTRB(25, 10, 0, 10),
  width: mediaQuery.width * 0.88,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item["country"]}, ${item['state']}, ${item['city']}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "${item['location']} - ${item['pin']}",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            print(item['aID']);
            RouterClass.AddScreen(context,
           UpdateAddress(defaultCountry: item['country'], defaultState: item['state'], defaultCity: item['city'], defaultPin: item['pin'], defaultNear: item['location'], aid: item['aID']));
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            ApiService.deleteAddress(aid: item['aID']);
           Navigator.pop(context);
            RouterClass.AddScreen(context, AddressListScreen());
          },
        ),
      ],
    ),
  ),
));
;
      
    }
    return data;
  }


static List<Widget> addressSelectContainer(
  BuildContext context, List addresss, int selectedAddressIndex, Function(int) onChanged) {
  final mediaQuery = MediaQuery.of(context).size;
  List<Widget> data = [];
  for (int index = 0; index < addresss.length; index++) {
    var item = addresss[index];
    data.add(
      ListTile(
        title: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: mediaQuery.width * 0.88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["country"]}, ${item['state']}, ${item['city']}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${item['location']} - ${item['pin']}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
        leading: Radio(
          value: index, // Set the index as the value for the radio button
          groupValue: selectedAddressIndex,
          onChanged: (value) {
            onChanged(value!); // Call the provided onChanged function
          },
        ),
      ),
    );
  }
  return data;
}


static List<Widget> paymentOptionSelectContainer(
  BuildContext context, List<dynamic> paymentOptions, int selectedAddressIndex, Function(int) onChanged) {
  final mediaQuery = MediaQuery.of(context).size; // Move MediaQuery here
  List<Widget> data = [];
  for (int index = 0; index < paymentOptions.length; index++) {
    var item = paymentOptions[index];
    data.add(
      ListTile(
        title: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: mediaQuery.width * 0.88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item['option']}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       SizedBox(height: 8),
                      Text(
                       "${item['condition']}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
      
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
      
        leading: Radio(
          value: index, // Set the index as the value for the radio button
          groupValue: selectedAddressIndex,
          onChanged: (value) {
            onChanged(value!); // Call the provided onChanged function
          },
        ),
      ),
    );
  }
  return data;
}


}
