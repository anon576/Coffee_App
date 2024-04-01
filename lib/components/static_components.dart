
import "package:flutter/material.dart";

import "app_properties.dart";


class Components{

  static Widget poweredBy(){
    return BottomAppBar(
    color: BackgroundColor,
    child: Text('Powered by\nCodestream.tech',
    textAlign: TextAlign.center,
  style: TextStyle( 
    color: Colors.black54
  ),),
    elevation: 0,
  );
  }
}