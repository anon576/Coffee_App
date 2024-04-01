
import 'package:coffeeurge/components/app_properties.dart';
import 'package:flutter/material.dart';

import '../../apis/user_api.dart';
import '../../components/custom_appbar.dart';
import '../../components/route.dart';
import '../../components/shimmer_effect.dart';
import '../../components/user_input_feild.dart';
import 'add_address.dart';


class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List _addresses = []; // List to store fetched addresses
  bool addressloaded = false;

  Future<void> fetchAddresses() async {
    List address = await ApiService.getAddress();

   if (mounted) { // Check if the widget is still mounted
    if (address.isNotEmpty) {
      setState(() {
        _addresses.addAll(address);
        addressloaded = true;
      });
    }else{
      setState(() {
        addressloaded = true;
      });
    }
  }
  }

    List<Widget> screen() {
    if (addressloaded) {
      if(_addresses.isEmpty){
        List<Widget> data = [];
         data.add(  Center(
                    child: Text('No addresses found',
                    style: TextStyle( 
                      color: Colors.white
                    ),),
                  ));
        return data;
      }
      
      return UserInputFeild.addressContainer(
         context, _addresses);
    } else {
      return ShimmerEffect.categoryShimmer(context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAddresses(); // Fetch addresses when screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar.screenAppbar("Address",context),
      body: SingleChildScrollView( 
        child: Column(
        children: [
         Column(
          children: screen(),
         ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              backgroundColor: const Color(0xffC67C4E),
              onPressed: () {
               RouterClass.AddScreen(context, AddAddress());
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      )
    );
  }
}
