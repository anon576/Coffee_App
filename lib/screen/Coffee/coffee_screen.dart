
import "package:flutter/material.dart";
import '../../apis/coffee_api.dart';
import '../../components/app_properties.dart';
import '../../components/coffee_built.dart';
import '../../components/custom_appbar.dart';
import '../../components/route.dart';
import '../../components/shimmer_effect.dart';
import 'add_coffee_screen.dart';


class coffees extends StatefulWidget {
  const coffees({super.key});

  @override
  State<coffees> createState() => _coffeesState();
}

class _coffeesState extends State<coffees> {



 List coffeeList = [];
  bool iscoffeeLoaded = false;

 Future<void> fetchCart() async {
  List<dynamic> newListCategory = await CoffeeAPI.getUsercoffees();
  if (mounted) { // Check if the widget is still mounted
    if (newListCategory.isNotEmpty) {
      setState(() {
        coffeeList.addAll(newListCategory);
        iscoffeeLoaded = true;
      });
    }else{
      setState(() {
        iscoffeeLoaded = true;
      });
    }
  }
}


  List<Widget> screen() {
    if (iscoffeeLoaded) {
       if(coffeeList.isEmpty){

        List<Widget> data = [];
         data.add(  Center(
                    child: Text('No Coffe Found',
                    style: TextStyle(
                      color: Colors.white
                    ),),
                  ));
        return data;
      }
      return CoffeeBuild.buildcoffee(context, coffeeList);
    } else {
      return ShimmerEffect.yourcoffeesShimmer(context);
    }
  }

  @override
  void initState() {
    fetchCart();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     final mediaQuery = MediaQuery.of(context).size;
    return Scaffold( 
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar.screenAppbar("Your coffees",context),
      body: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: screen()
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total coffees:${coffeeList.length}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                 
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: mediaQuery.height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffC67C4E),
                      ),
                      child: TextButton(
                        onPressed: () {
                          RouterClass.AddScreen(context, AddNewcoffee());
                        },
                        child: Text(
                          'Add coffee',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}