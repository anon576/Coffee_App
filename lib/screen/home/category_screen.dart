
import "package:flutter/material.dart";

import "../../components/app_properties.dart";
import "../../components/custom_appbar.dart";
import "../../components/user_input_feild.dart";

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController _searchController = TextEditingController();
  UserInputFeild feild = UserInputFeild();
  List categoryList = categoriesOfcoffees;




  List<Widget> screen() {
    
      return UserInputFeild.categoryContainer(
         context, "assets/welcome.png", categoryList);
    
  }

  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              feild.searchContainerText(context, _searchController,
                  "Seach coffees", Icon(Icons.search)),
                 Column(
                  children: screen()
                 ) 
            ],
          ),
        ),
      ),
    );
  }
}
