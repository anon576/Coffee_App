
import 'package:coffeeurge/components/app_properties.dart';
import 'package:flutter/material.dart';

import '../../apis/user_api.dart';
import '../../components/custom_appbar.dart';
import '../../components/route.dart';
import '../../components/shimmer_effect.dart';
import '../../components/user_input_feild.dart';
import '../Product/product_screen.dart';
import '../payment/receipt.dart';



class SelectAddress extends StatefulWidget {
  final bool cod;
  final bool online;
  final List<ProductPageclass> product;
  SelectAddress({
    required this.cod,
    required this.online,
    required this.product  });

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  List _addresses = []; // List to store fetched addresses
  bool addressloaded = false;
  int _selectedAddressIndex = -1;
  
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
      
       return UserInputFeild.addressSelectContainer(
       context, _addresses, _selectedAddressIndex, _onAddressSelected);
    } else {
      return ShimmerEffect.categoryShimmer(context);
    }
  }
void _onAddressSelected(int index) {
  setState(() {
    // Update the selected address index
    _selectedAddressIndex = index;
  });
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
      appBar: CustomAppBar.screenAppbar("Select Address",context),
      body: SingleChildScrollView( 
        child: Column(
        children: [
         Column(
          children: screen(),
         ),
      Padding(
  padding: const EdgeInsets.all(16.0),
  child: TextButton(
    onPressed: _selectedAddressIndex != -1 ? () {
  if (widget.cod) {
    // Navigate to COD screen
    RouterClass.AddScreen(context, OrderDetails(cod: true,online: false,product: widget.product,adr: _addresses[_selectedAddressIndex],));
  } else if (widget.online) {
    // Navigate to Online payment screen
   RouterClass.AddScreen(context, OrderDetails(cod: false,online: true,product: widget.product,adr: _addresses[_selectedAddressIndex]
    ));
  }
} : null,

    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(Size(150.0, 50.0)), // Set the minimum size of the button
      backgroundColor: _selectedAddressIndex != -1 ? MaterialStateProperty.all<Color>(const Color(0xffC67C4E)) : MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
    ),
    child: Text(
      _selectedAddressIndex != -1 ? 'Next' : 'Select Address',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
)



        ],
      ),
      )
    );
  }
}
