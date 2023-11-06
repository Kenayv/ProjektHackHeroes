import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_hack_heroes/user.dart';


class Theme{

late Color Primarybgcolor;
late Color Secondarybgcolor;
late Color Shadowcolor;
late Color Appbarbgcolor;
late Color AppBarshadowcolor;


  Theme(Color primarybgcolor,Color secondarybgcolor,Color shadowcolor, Color appbarbgcolor, Color appBarshadowcolor){
    Primarybgcolor=primarybgcolor;
    Secondarybgcolor=secondarybgcolor;
    Shadowcolor=shadowcolor;
    Appbarbgcolor=appbarbgcolor;
    AppBarshadowcolor=appBarshadowcolor;
  }





AppBar getAppBar(String pagetitle) {
  late AppBar appbar = AppBar(
    shadowColor: AppBarshadowcolor, // barely visible black shadow
    backgroundColor: Appbarbgcolor,
    automaticallyImplyLeading: false,
    flexibleSpace: FlexibleSpaceBar(

      background: Container(
        margin: EdgeInsets.only(top: 20.0), // Add top margin
        child: Row(
          children: [
            Expanded(
              child: Text(currentUser.getDayStreak().toString()+" 🔥",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),

              ), // Move to the center
            ),

            Expanded(
              child: Text(pagetitle,
                textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
              ), // Move to the center
            ),
            Expanded(
              child: Text("Rekord: "+currentUser.getLongestStreak().toString()+" 🔥",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)
              ), // Move to the right
            ),
          ],
        ),
      ),
    ),
  );






    return appbar;
}



}


final Theme whitetheme=Theme(
    Color.fromRGBO(1, 5, 255, 1.0),
    Color.fromRGBO(1, 5, 255, 1.0),
    Color.fromRGBO(1, 5, 255, 1.0),
    Color.fromRGBO(0, 0, 0, 0.3),
    Color.fromRGBO(250, 250, 250, 1));



final Theme blacktheme=Theme(
    Color.fromRGBO(1, 5, 255, 1.0),
    Color.fromRGBO(1, 5, 255, 1.0),
    Color.fromRGBO(1, 5, 255, 1.0),
    Color.fromRGBO(0, 0, 0, 0.3),
    Color.fromRGBO(250, 250, 250, 1));

late Theme usertheme;










