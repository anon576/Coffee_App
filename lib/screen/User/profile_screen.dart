
import "package:flutter/material.dart";

import "../../apis/user_api.dart";
import "../../components/app_properties.dart";
import "../../components/custom_appbar.dart";
import "../../components/error _snackbar.dart";
import "../../components/share_prefs.dart";
import "../../components/user_input_feild.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  UserInputFeild feild = UserInputFeild();
    TextEditingController namecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController adresscontroller = TextEditingController();
  bool isLoading = false;
  bool readOnly = true;
  String buttonText = "Edit Profile";

  void getSharedPref() async{

    namecontroller.text = await SharePrefs.readPrefs("name", "string");
      lastnamecontroller.text = await SharePrefs.readPrefs("lastname", "string");
        mobilecontroller.text = await SharePrefs.readPrefs("mobile", "string");
          adresscontroller.text = await SharePrefs.readPrefs("city", "string");

  }


Future<void> UpdateUser() async {
  try {
      bool response = await ApiService.updateUser(
          name: namecontroller.text,
          lastname: lastnamecontroller.text,
          mobileNo: mobilecontroller.text,
          city: adresscontroller.text);
      if (response) {
          InputComponent.showWarningSnackBar(context, "Updated Successfully");
      } else {
        InputComponent.showWarningSnackBar(context, "Server Error");
      }
    } catch (error) {
      InputComponent.showWarningSnackBar(context, error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
}

  @override
  void initState() {
    getSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold( 
      backgroundColor: BackgroundColor,
      appBar:CustomAppBar.screenAppbar("Profile",context),
      body: SingleChildScrollView( 
        child: Column( 
          children: [ 
               SizedBox(height: mediaQuery.height*.1,),
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 7.0),
              child: const Center(
                  child: Text(
                'Coffee Urge!',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )),
            ),
          ),
          SizedBox(height: 15),
             feild.inputContainerText(context, namecontroller, "Enter First Name",
              Icon(Icons.person_2_outlined),readOnly:readOnly),
          SizedBox(height: 25),
          feild.inputContainerText(context, lastnamecontroller,
              "Enter Last Name", Icon(Icons.last_page_outlined),readOnly:readOnly),
          SizedBox(height: 25),
          feild.inputContainerText(context, mobilecontroller, "Enter Mobile No",
              Icon(Icons.mobile_friendly_outlined),readOnly:readOnly),
          SizedBox(height: 25),
          feild.inputContainerText(context, adresscontroller, "Enter City Name",
              Icon(Icons.location_city),readOnly:readOnly),
          SizedBox(height: 25),
          feild.buttonContainer(context, buttonText, () async {
            if (namecontroller.text.isEmpty ||
                lastnamecontroller.text.isEmpty ||
                mobilecontroller.text.isEmpty ||
                adresscontroller.text.isEmpty) {
              InputComponent.showWarningSnackBar(context, "Enter Valid Data");
            } else if (mobilecontroller.text.length != 10) {
              InputComponent.showWarningSnackBar(
                  context, "Enter Valid Mobile No");
            } else {
              if(buttonText == "Save Profile"){
                setState(() {
                  isLoading = true;
                });
                  await UpdateUser();
              }
              setState(() {
                isLoading = false;
                readOnly = false;
                buttonText = "Save Profile";
              });
              
            }
          }, isLoading),
          ],
        ),
      ),
    );
  }
}