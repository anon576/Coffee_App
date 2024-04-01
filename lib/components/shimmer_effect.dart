import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:shimmer/shimmer.dart';

class ShimmerEffect {
  static Widget coffeeShimmer(context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mediaQuery.height * 0.23,
              width: mediaQuery.height * 0.18,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: mediaQuery.height * 0.03,
              width: mediaQuery.height * 0.18,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: mediaQuery.height * 0.03,
              width: mediaQuery.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget CarsoulShimmer(context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade300,
        child: Container(
          height: mediaQuery.height * 0.23,
          width: mediaQuery.height * 0.4,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  static Widget ShimmerHomeScreen(context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(children: [
        CarouselSlider(
          items: [
            ShimmerEffect.CarsoulShimmer(context),
            ShimmerEffect.CarsoulShimmer(context),
            ShimmerEffect.CarsoulShimmer(context),
            ShimmerEffect.CarsoulShimmer(context),
            ShimmerEffect.CarsoulShimmer(context),
          ],
          options: CarouselOptions(
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerEffect.coffeeShimmer(context),
              SizedBox(width: mediaQuery.width * .04),
              ShimmerEffect.coffeeShimmer(context)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerEffect.coffeeShimmer(context),
              SizedBox(width: mediaQuery.width * .04),
              ShimmerEffect.coffeeShimmer(context)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerEffect.coffeeShimmer(context),
              SizedBox(width: mediaQuery.width * .04),
              ShimmerEffect.coffeeShimmer(context)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerEffect.coffeeShimmer(context),
              SizedBox(width: mediaQuery.width * .04),
              ShimmerEffect.coffeeShimmer(context)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerEffect.coffeeShimmer(context),
              SizedBox(width: mediaQuery.width * .04),
              ShimmerEffect.coffeeShimmer(context)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerEffect.coffeeShimmer(context),
              SizedBox(width: mediaQuery.width * .04),
              ShimmerEffect.coffeeShimmer(context)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerEffect.coffeeShimmer(context),
              SizedBox(width: mediaQuery.width * .04),
              ShimmerEffect.coffeeShimmer(context)
            ],
          ),
        )
      ]),
    );
  }

  static List<Widget> categoryShimmer(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> data = [];
    for (int i = 0; i < 4; i++) {
      data.add(Container(
        margin: EdgeInsets.fromLTRB(25, 20, 10, 0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: mediaQuery.height * 0.23,
            width: mediaQuery.height * 0.4,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ));
    }
    return data;
  }

   static List<Widget> cartShimmer(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> data = [];
   for(int i=0;i<=4;i++){
    data.add(Container( 

      child: Shimmer.fromColors(child: Row(children: [ 

        Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.245,
          width: mediaQuery.width*.4,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
        SizedBox(width: 10,),
        Column( 
          children: [ 
          Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.03,
          width: mediaQuery.width*.5,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
        Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.03,
          width: mediaQuery.width*.5,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
        Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.03,
          width: mediaQuery.width*.5,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
        Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.03,
          width: mediaQuery.width*.5,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
         Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.07,
          width: mediaQuery.width*.5,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
          ],
        )


      ]),   baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade300),
    ));
   }
    return data;
  }

    static List<Widget> yourcoffeesShimmer(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> data = [];
   for(int i=0;i<=4;i++){
    data.add(Container( 

      child: Shimmer.fromColors(child: Row(children: [ 

        Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.245,
          width: mediaQuery.width*.4,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
        SizedBox(width: 10,),
        Column( 
          children: [ 
          Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.07,
          width: mediaQuery.width*.5,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
         Container( 
          margin: EdgeInsets.only(top: 12),
          height: mediaQuery.height*.07,
          width: mediaQuery.width*.5,
          decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        ),
          ],
        )


      ]),   baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade300),
    ));
   }
    return data;
  }
}