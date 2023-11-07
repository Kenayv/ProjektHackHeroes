import 'package:flutter/material.dart';
import 'package:project_hack_heroes/user.dart';

class Theme {
  late Color Primarybgcolor;
  late Color Secondarybgcolor;
  late Color Shadowcolor;
  late Color Appbarbgcolor;
  late Color AppBarshadowcolor;
  late Color TextColor;
  late Color Page1;
  late Color Page2;
  late Color Page3;
  late Color Page4;
  late Color Taskcolor;

  Theme(
    Color primarybgcolor,
    Color secondarybgcolor,
    Color shadowcolor,
    Color appbarbgcolor,
    Color appBarshadowcolor,
    Color textcolor,
    Color page1,
    Color page2,
    Color page3,
    Color page4,
    Color taskcolor,


  ) {
    Primarybgcolor = primarybgcolor;
    Secondarybgcolor = secondarybgcolor;
    Shadowcolor = shadowcolor;
    Appbarbgcolor = appbarbgcolor;
    AppBarshadowcolor = appBarshadowcolor;
    TextColor = textcolor;
    Page1 = page1;
    Page2 = page2;
    Page3 = page3;
    Page4 = page4;
    Taskcolor=taskcolor;
  }

  AppBar getAppBar(String pagetitle) {
    late AppBar appbar = AppBar(
      shadowColor: AppBarshadowcolor, // barely visible black shadow
      backgroundColor: Appbarbgcolor,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 5.0), // Add top margin
          child: Row(
            children: [
              Expanded(
                child: Text(
                  currentUser.getDayStreak().toString() + "🔥",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: usertheme.TextColor),
                ), // Move to the center
              ),
              Expanded(
                child: Text(
                  pagetitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: usertheme.TextColor),
                ), // Move to the center
              ),
              Expanded(
                child: Text(" 🏅" + currentUser.getLongestStreak().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28, color: usertheme.TextColor)), // Move to the right
              ),
            ],
          ),
        ),
      ),
    );

    return appbar;
  }
}

final Theme whitetheme = Theme(
  Color.fromRGBO(248, 245, 250, 1.0),
  Color.fromRGBO(1, 5, 255, 1.0),
  Color.fromRGBO(1, 5, 255, 1.0),
  Color.fromRGBO(248, 245, 250, 0.9999),
  Color.fromRGBO(201, 201, 201, 0.1),
  Color.fromRGBO(0, 0, 0, 1),
  Color.fromRGBO(106, 163, 248, 1),
  Color.fromRGBO(252, 102, 102, 1),
  Color.fromRGBO(139, 91, 227, 1.0),
  Color.fromRGBO(252, 161, 66, 1.0),
  Color.fromRGBO(139, 91, 227, 1.0),
);

/*
    niebieski: #6aa3f8  106, 163, 248
    czerwony: #fc6666   252, 102, 102
    fiolet: #cdb2ff     205, 178, 255
    zielony: #97e077    151, 224, 119

 */

final Theme blacktheme = Theme(
  Color.fromRGBO(31, 42, 95, 1.0),
  Color.fromRGBO(1, 5, 255, 1.0),
  Color.fromRGBO(1, 5, 255, 1.0),
  Color.fromRGBO(31, 42, 95, 0.99999),
  Color.fromRGBO(40, 40, 80, 0.7),
  Color.fromRGBO(255, 255, 255, 1),
  Color.fromRGBO(89, 155, 255, 1.0),
  Color.fromRGBO(173, 138, 253, 1.0), //PLACEHOLDERS LAST 4
  Color.fromRGBO(255, 119, 46, 1.0),
  Color.fromRGBO(0, 204, 189, 1.0),
  Color.fromRGBO(255, 119, 46, 1.0),
);

/*

Dark theme: #1f2a5f         31, 42, 95)

    niebieski: #6aa3f8      106, 163, 248
    Fiolet: #af8ef7         175, 142, 247
    pomarańczowy: #ff8c4f   255, 140, 79
    zielony: #55d389        85, 211, 137



 */

late Theme usertheme;
