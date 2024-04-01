import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../apis/coffee_api.dart';
import '../../components/app_properties.dart';
import '../../components/custom_appbar.dart';
import '../../components/error _snackbar.dart';
import '../../components/route.dart';
import '../../components/user_input_feild.dart';
import '../Product/product_screen.dart';

class AddNewcoffee extends StatefulWidget {
 

  @override
  State<AddNewcoffee> createState() => _AddNewcoffeeState();
}

class _AddNewcoffeeState extends State<AddNewcoffee> {
   TextEditingController coffeenamecontroller = TextEditingController();
 TextEditingController coffeepricecontroller= TextEditingController();
   TextEditingController coffeeauthorcontroller= TextEditingController();
   TextEditingController coffeedesccontroller= TextEditingController();
  UserInputFeild feild = UserInputFeild();
  bool isLoading = false;
  String dropdownvalue = "Select Category";
  XFile? image;
  String imagebuttontext = "Upload";

  // List of items in our dropdown menu
  var items = categoriesOfcoffees;
  @override
  void initState() {
    super.initState();
   
  }

  @override
  void dispose() {
    coffeenamecontroller.dispose();
    coffeepricecontroller.dispose();
    coffeeauthorcontroller.dispose();
    coffeedesccontroller.dispose();
    super.dispose();
  }

 Future<void> handleImagePicker(context,) async {
  final ImagePicker _picker = ImagePicker();
  
  // Show options for choosing from the gallery or capturing from the camera
  final action = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      );
    },
  );

  if (action != null) {
    XFile? pickedfile = (await _picker.pickImage(source: action));

    if (pickedfile != null) {
      image = pickedfile;
      setState(() {
                        imagebuttontext = "Uploaded";
                      });
      // Handle the picked image
      // For example, you can display the image or upload it to a server
    }
  }
}

  Future<void> addcoffee() async {
    try {

      Uint8List? _bytes = await image?.readAsBytes();
      String base64Image = base64Encode(_bytes!);
        Map<dynamic,dynamic>   response = await CoffeeAPI.addcoffee(
        coffeename: coffeenamecontroller.text,
        price: int.parse(coffeepricecontroller.text),
        description: coffeedesccontroller.text,
        author: coffeeauthorcontroller.text,
        image:base64Image,
        category: dropdownvalue
      );
      if (response["success"]) {
        List<ProductPageclass> product = [];
        product.add(ProductPageclass(name: response["coffeename"], imageUrl: response["image"], price: response["price"],uid: response['uID'],bid: response['bID'],desc: response['description'],category: response['category'],author: response['author'])) ;
        Navigator.pop(context);
           RouterClass.AddScreen(context,ProductPage(product:product));
           
        // InputComponent.showWarningSnackBar(context, "coffee Added Successfully");
      } else {
        InputComponent.showWarningSnackBar(context, "Server Error");
      }
    } catch (error) {
      print(error);
      InputComponent.showWarningSnackBar(context, error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: BackgroundColor,
      appBar: CustomAppBar.screenAppbar("New coffee",context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              feild.inputContainerText(context, coffeenamecontroller,
                  "Enter coffee Name", Icon(Icons.coffee)),
              SizedBox(
                height: 12,
              ),
              feild.inputContainerText(context, coffeeauthorcontroller,
                  "coffee Author Name", Icon(Icons.person)),
              SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                width: mediaQuery.width * .71,
                height: mediaQuery.height * .06,
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              feild.inputContainerText(context, coffeepricecontroller,
                  "Enter Price ", Icon(Icons.price_change)),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  width: mediaQuery.width * .71,
                  // height: mediaQuery.height * .06,
                  decoration: BoxDecoration(
                  color:Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: coffeedesccontroller,
                    maxLines: 8,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Description",
                      // suffixIcon: Icon(Icons.description),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload Image of coffee",
                    style: TextStyle(
                        color:Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.width * .05,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      handleImagePicker(context);
                      
                    },
                    child: Text(
                      "$imagebuttontext",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              feild.buttonContainer(context, "Submit", () async {
                if (coffeeauthorcontroller.text.isEmpty ||
                    coffeedesccontroller.text.isEmpty ||
                    coffeenamecontroller.text.isEmpty ||
                    coffeepricecontroller.text.isEmpty) {
                  InputComponent.showWarningSnackBar(
                      context, "Enter All Information");
                } else if (image == null) {
                  InputComponent.showWarningSnackBar(
                      context, "Select an Image");
                }else if(dropdownvalue == "Select Category"){
                  InputComponent.showWarningSnackBar(
                      context, "Choose Category");
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  addcoffee();
                }
              }, isLoading)
            ],
          ),
        ),
      ),
    );
  }
}
