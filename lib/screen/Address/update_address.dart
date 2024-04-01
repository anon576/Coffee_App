import 'package:coffeeurge/components/app_properties.dart';
import 'package:flutter/material.dart';

import '../../apis/user_api.dart';
import '../../components/custom_appbar.dart';
import '../../components/error _snackbar.dart';
import '../../components/route.dart';
import '../../components/user_input_feild.dart';
import 'address.dart';

class UpdateAddress extends StatefulWidget {
 final String defaultCountry;
  final String defaultState;
  final String defaultCity;
  final int defaultPin;
  final String defaultNear;
  final int aid;

  const UpdateAddress({
    Key? key,
    required this.defaultCountry,
    required this.defaultState,
    required this.defaultCity,
    required this.defaultPin,
    required this.defaultNear,
    required this.aid
  }) : super(key: key);

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  final UserInputFeild feild = UserInputFeild();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _nearController = TextEditingController();
  int aid = 0;

  bool isLoading = false;

  Future UpdateAddress() async {
    try {
        bool data = await ApiService.updateAddress(aid:aid,country: _countryController.text, state: _stateController.text, city: _cityController.text, pin: int.parse(_pinController.text), near: _nearController.text);

        if(data){
          setState(() {
             isLoading = false;
          });
         
            Navigator.pop(context);
            RouterClass.AddScreen(context, AddressListScreen());
        }else{
          setState(() {
             isLoading = false;
          });
         
           InputComponent.showWarningSnackBar(context, "Server Error");
        }
    }catch(error){
      setState(() {
             isLoading = false;
          });
         
      InputComponent.showWarningSnackBar(context, "Server Error:$error");
    }
  }

  void initState() {
    super.initState();
    aid = widget.aid;
    _countryController = TextEditingController(text: widget.defaultCountry);
    _stateController = TextEditingController(text: widget.defaultState);
    _cityController = TextEditingController(text: widget.defaultCity);
    _pinController = TextEditingController(text: widget.defaultPin.toString());
    _nearController = TextEditingController(text: widget.defaultNear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar.screenAppbar("Update Address",context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            feild.inputContainerText(context, _countryController,
                "Enter Country", (Icon(Icons.flag))),
                SizedBox(height: 15),
            feild.inputContainerText(context, _stateController,
                "Enter state", (Icon(Icons.location_city))),
                SizedBox(height: 15),
            feild.inputContainerText(context, _cityController,
                "Enter City", (Icon(Icons.home))),
                SizedBox(height: 15),
            feild.inputContainerText(context, _pinController,
                "Enter PIN", (Icon(Icons.pin))),
                SizedBox(height: 15),
            feild.inputContainerText(context, _nearController,
                "Enter nearby location", (Icon(Icons.info))),
                SizedBox(height: 15),
            feild.buttonContainer(context, "Update", () async {
              if (_countryController.text.isEmpty ||
                  _cityController.text.isEmpty ||
                  _pinController.text.isEmpty ||
                  _stateController.text.isEmpty ||
                  _nearController.text.isEmpty) {
                InputComponent.showWarningSnackBar(context, "Enter Valid Data");
              } else {
                setState(() {
                  isLoading = true;
                });
                await UpdateAddress();
              }
            }, isLoading)
          ],
        ),
      ),
    );
  }
}
