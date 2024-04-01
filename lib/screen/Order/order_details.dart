
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

import '../../components/app_properties.dart';
import '../../components/custom_appbar.dart';
import '../../components/user_input_feild.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String bookname;
  final String imageUrl;
  final String author;
  final int price;
  final String date; // Keep the date as a String
  final String paymentStatus;
  final String country;
  final String state;
  final String city;
  final int pin;
  final String location;

  const OrderDetailsScreen({
    required this.bookname,
    required this.imageUrl,
    required this.author,
    required this.price,
    required this.date,
    required this.paymentStatus,
    required this.country,
    required this.state,
    required this.city,
    required this.pin,
    required this.location,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isloading = false;
  final UserInputFeild feild = UserInputFeild();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    // Format the date in the desired format (day month year)
   DateTime dateTime = DateTime.parse(widget.date);

  // Format the DateTime object into the desired format (day month year)
   DateTime newDateTime = dateTime.add(Duration(days: 8));
   String dd = DateFormat('dd MMMM yyyy').format(newDateTime);// 
  String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);// Assuming date format is already correct

    return Scaffold(
      appBar: CustomAppBar.screenAppbar("Order Detail",context),
      body: Padding(
        padding: EdgeInsets.zero, // Remove padding from all sides
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                width: 315,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Address",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "${widget.country}, ${widget.state}, ${widget.city}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.location} - ${widget.pin}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      decoration: const BoxDecoration(
                        color: Color(0xffEAEAEA),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          height: mediaQuery.height * 0.3,
                          width: mediaQuery.width * .6,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Image.network(
                            "$apilink/${widget.imageUrl}",
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.bookname}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff2F2D2C),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${widget.author}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 4,
                decoration: const BoxDecoration(color: Color(0xffF4F4F4)),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 315,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Date",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          formattedDate, // Use the formatted date
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Expected Delivery Date",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          dd, // Use the formatted date
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "\₹ ${widget.price}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Fee",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "\₹ 150",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "\₹ 40",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Payment",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "\₹ ${widget.price + 40}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 376,
                height: 161,
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 315,
                      height: 62,
                      child: feild.buttonContainer(context, "Back ", () async {
                      Navigator.pop(context);
                      }, isloading),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
