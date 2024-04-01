
import 'package:coffeeurge/components/app_properties.dart';
import 'package:flutter/material.dart';

import '../../apis/product_api.dart';
import '../../components/custom_appbar.dart';
import '../../components/screen_builder.dart';
import '../../components/shimmer_effect.dart';
import '../../components/user_input_feild.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = TextEditingController();
  UserInputFeild feild = UserInputFeild();
  bool carsoulLoaded = false;
  bool productLoaded = false;
  List<dynamic> carsoulProduct = [];
  List<dynamic> listProduct = [];
  int lastbookid = 0;
  ScrollController _scrollController = ScrollController();

  Future<void> fetchCarsoul() async {
    carsoulProduct = await ProductAPI.fetchCarsoul();
    if (mounted) {
      setState(() {
        carsoulLoaded = true;
      });
    }
  }

  Future<void> fetchProducts() async {
    Map<String, dynamic> newProduct =
        await ProductAPI.fetchProducts(range: lastbookid);

    List<dynamic> newListProduct = [];
    if (newProduct['books'] == null) {
      newListProduct = [];
    } else {
      newListProduct = newProduct['books'];
      lastbookid = newProduct['lastbookid'];
    }

    if (mounted) {
      print("heel");
      if (newListProduct.isNotEmpty) {
        setState(() {
          listProduct.addAll(newListProduct);
          lastbookid++;
          productLoaded = true;
        });
      } else {
        setState(() {
          productLoaded = true;
        });
      }
    }
  }

  Widget screen() {
    if (carsoulLoaded & productLoaded) {
      if (listProduct.isEmpty) {
        List<Widget> returnData = [];
        returnData.add(Center(
            child: Container(
          margin: EdgeInsets.all(100),
          child: Text(
            'No Coffee Found',
          style: TextStyle(
              color: Colors.white
          ),
            ),
        )));

        return returnData[0];
      }
      return Products.buildHomeScreen(context, carsoulProduct, listProduct);
    } else {
      return ShimmerEffect.ShimmerHomeScreen(context);
    }
  }

  @override
  void initState() {
    fetchCarsoul();
    fetchProducts();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more products
      fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            feild.searchContainerText(
                context, _searchController, "Search coffee", Icon(Icons.search)),
            screen(),
          ],
        ),
      ),
    );
  }
}
