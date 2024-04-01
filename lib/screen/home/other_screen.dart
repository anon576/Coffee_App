
import "package:coffeeurge/components/app_properties.dart";
import "package:flutter/material.dart";

import "../../components/custom_appbar.dart";
import "../../components/route.dart";
import "../../components/share_prefs.dart";
import "../../components/user_input_feild.dart";
import "../Address/address.dart";
import '../Coffee/coffee_screen.dart';
import "../Order/order_screen.dart";
import "../User/profile_screen.dart";

class OtherScreen extends StatefulWidget {
  const OtherScreen({super.key});

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  UserInputFeild feild = UserInputFeild();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          feild.buttonContainer(context, "Profile", () async {
           RouterClass.AddScreen(context,ProfileScreen());
          }, _isLoading),
          const SizedBox(height: 20),
          feild.buttonContainer(context, "Your Orders", () async {
            RouterClass.AddScreen(context, Order());
          }, _isLoading),
           const SizedBox(height: 20),
          feild.buttonContainer(context, "Your Coffee", () async {
            RouterClass.AddScreen(context, coffees());
          }, _isLoading),
          const SizedBox(height: 20),
          feild.buttonContainer(context, "Your Addreses", () async {
             RouterClass.AddScreen(context,AddressListScreen());
          }, _isLoading),
          const SizedBox(height: 20),
          feild.buttonContainer(context, "About Us", () async {}, _isLoading),
          const SizedBox(height: 20),
          feild.buttonContainer(context, "Sign Out", (
          ) async {
            SharePrefs.clearPrefs();
             SharePrefs.storePrefs("isLogin", false, 'bool');
             RouterClass.ReplaceScreen(context, "/startup");
          }, _isLoading)
        ],
      ),
    );
  }
}
