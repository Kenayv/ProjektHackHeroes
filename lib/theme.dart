import 'package:flutter/material.dart';
import 'package:project_hack_heroes/user.dart';

class Theme {
  late Color primarybgcolor;
  late Color secondarybgcolor;
  late Color shadowcolor;
  late Color appbarbgcolor;
  late Color appBarshadowcolor;
  late Color textColor;
  late Color page1;
  late Color page2;
  late Color page3;
  late Color page4;
  late Color page5;
  late Color taskcolor;
  late Color colorWhite;


  Theme(
    Color primarybgclr,
    Color secondarybgclr,
    Color shadowclr,
    Color appbarbgclr,
    Color appBarshadowclr,
    Color textclr,
    Color pg1,
    Color pg2,
    Color pg3,
    Color pg4,
    Color pg5,
    Color taskclr,
    Color whiteclr,
  ) {
    primarybgcolor = primarybgclr;
    secondarybgcolor = secondarybgclr;
    shadowcolor = shadowclr;
    appbarbgcolor = appbarbgclr;
    appBarshadowcolor = appBarshadowclr;
    textColor = textclr;
    page1 = pg1;
    page2 = pg2;
    page3 = pg3;
    page4 = pg4;
    page5 = pg5;
    taskcolor = taskclr;
    colorWhite = whiteclr;

  }

  AppBar studeeAppBar(String pagetitle) {
    return AppBar(
      shadowColor: appBarshadowcolor, // barely visible black shadow
      backgroundColor: appbarbgcolor,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          margin: const EdgeInsets.only(top: 15.0, bottom: 5.0), // Add top margin
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${currentUser.getDayStreak()}🔥",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: usertheme.textColor),
                ), // Move to the center
              ),
              Expanded(
                child: Text(
                  pagetitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: usertheme.textColor),
                ), // Move to the center
              ),
              Expanded(
                child: Text(" 🏅${currentUser.getLongestStreak()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28, color: usertheme.textColor)), // Move to the right
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final Theme whitetheme = Theme(
  const Color.fromRGBO(248, 245, 250, 1.0),
  const Color.fromRGBO(1, 5, 255, 1.0),
  const Color.fromRGBO(1, 5, 255, 1.0),
  const Color.fromRGBO(248, 245, 250, 0.9999),
  const Color.fromRGBO(201, 201, 201, 0.1),
  const Color.fromRGBO(0, 0, 0, 1),
  const Color.fromRGBO(106, 163, 248, 1),
  const Color.fromRGBO(252, 102, 102, 1),
  const Color.fromRGBO(139, 91, 227, 1.0),
  const Color.fromRGBO(252, 161, 66, 1.0),
  const Color.fromRGBO(128, 128, 128, 1.0),
  const Color.fromRGBO(139, 91, 227, 1.0),
  const Color.fromRGBO(255, 255, 255, 1.0),
);

/*
Light theme:
  niebieski: #6aa3f8  106, 163, 248
  czerwony: #fc6666   252, 102, 102
  fiolet: #cdb2ff     205, 178, 255
  zielony: #97e077    151, 224, 119
*/

final Theme blacktheme = Theme(
  const Color.fromRGBO(31, 42, 95, 1.0),
  const Color.fromRGBO(1, 5, 255, 1.0),
  const Color.fromRGBO(1, 5, 255, 1.0),
  const Color.fromRGBO(31, 42, 95, 0.99999),
  const Color.fromRGBO(40, 40, 80, 0.7),
  const Color.fromRGBO(255, 255, 255, 1),
  const Color.fromRGBO(89, 155, 255, 1.0),
  const Color.fromRGBO(173, 138, 253, 1.0), //PLACEHOLDERS LAST 4
  const Color.fromRGBO(255, 119, 46, 1.0),
  const Color.fromRGBO(0, 204, 189, 1.0),
  const Color.fromRGBO(128, 128, 128, 1.0), //MIGHT BE INAPROPRIATE COLOR FOR DARK THEME
  const Color.fromRGBO(255, 119, 46, 1.0),
  const Color.fromRGBO(255, 255, 255, 1.0),
);

/*
Dark theme: #1f2a5f         31, 42, 95)

  niebieski: #6aa3f8      106, 163, 248
  Fiolet: #af8ef7         175, 142, 247
  pomarańczowy: #ff8c4f   255, 140, 79
  zielony: #55d389        85, 211, 137
*/

Theme usertheme = (currentUser.getTheme() == "White" ? whitetheme : blacktheme);
