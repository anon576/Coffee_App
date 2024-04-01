
import 'package:coffeeurge/components/app_properties.dart';
import 'package:flutter/material.dart';
import '../../components/custom_appbar.dart';
import '../../components/error _snackbar.dart';
import '../../components/route.dart';
import '../../components/user_input_feild.dart';
import '../Address/select_address.dart';
import '../Product/product_screen.dart';


class PaymentOption extends StatefulWidget {
  final dynamic totalprice;
  final List<ProductPageclass> product;
  PaymentOption(
      {required this.totalprice,
       required this.product});

  @override
  _PaymentOptionState createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  List payment = [
    {
      "option":"COD(Cash On Delivery)",
      "condition":"Minimum amount for the COD should be 500 Rs."
    },
     {
      "option":"Online Payment",
      "condition":"Minimum amount for the Online Payment should be 250 Rs."
    },
    {
      "option":"Get by  your self",
      "condition":"If seller is from your city then you can get by yourself"
    }

    ]; 
  int _selectpaymentoption = -1;
  





void _onPaymentselected(int index) {
  setState(() {
    // Update the selected address index
    _selectpaymentoption = index;
  });
}

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar.screenAppbar("Payment Option",context),
      body: SingleChildScrollView( 
        child: Column(
        children: [
         Column(
          children:UserInputFeild.paymentOptionSelectContainer(
       context, payment, _selectpaymentoption, _onPaymentselected)
         ),
      Padding(
  padding: const EdgeInsets.all(16.0),
  child: TextButton(
    onPressed: _selectpaymentoption != -1 ? () {
      // Check conditions based on selected payment option
      if (_selectpaymentoption == 0) {
        // If Cash On Delivery is selected, check the condition
        if (widget.totalprice >= 500) {
          // Condition met, navigate to the next screen
          RouterClass.AddScreen(context, SelectAddress(cod: true,online: false,product: widget.product,));
        } else {
          // Condition not met, show an error message or handle accordingly
          InputComponent.showErrorDialogBox(context,"Minimum amount for Cash On Delivery should be 500 Rs.","Amount Required");
          
        }
      } else if (_selectpaymentoption == 1) {
        // If Online Payment is selected, check the condition
        if (widget.totalprice >= 250) {
          // Condition met, navigate to the next screen
  RouterClass.AddScreen(context, SelectAddress(cod: false,online: true,product:widget.product));
        } else {
          InputComponent.showErrorDialogBox(context,"Minimum amount for Online Payment should be 250 Rs.","Amount Required");
        }
      } else {
        // For other payment options, navigate to the next screen
        // RouterClass.AddScreen(context, NextScreen());
      }
    } : null,
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
      backgroundColor: _selectpaymentoption != -1 ? MaterialStateProperty.all<Color>(const Color(0xffC67C4E),) : MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
    ),
    child: Text(
      _selectpaymentoption != -1 ? 'Next' : 'Select Option',
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
