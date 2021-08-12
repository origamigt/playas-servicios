import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/routes/rpm_application.dart';

Color colorPrimary = Color(0xFF2D2E74);

BoxDecoration boxDecorationBG = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/images/background.jpg"),
    fit: BoxFit.cover,
  ),
);

BoxDecoration boxDecorationLogin = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      colors: [
        Color(0xFFFCDF00).withOpacity(0.75),
        Color(0xFFF8821E).withOpacity(0.75),
        Color(0XFF70C047).withOpacity(0.75)
      ],
      stops: [0.46, 0.55, 0.7],
      begin: Alignment(-1.0, -2.0),
      end: Alignment(1.0, 2.0),
    ));

Widget playasBG(heightSize, widthSize) {
  return Expanded(
      flex: 1,
      child: Container(
          child: Align(
        alignment: Alignment.center,
        child: Image.asset('assets/images/logo_2.jpg',
            height: heightSize * 0.5,
            width: widthSize * 0.5,
            semanticLabel: 'test'),
      )));
}

BoxDecoration boxDecorationPlayasBG = BoxDecoration(
  image: DecorationImage(
      image: AssetImage(
        "assets/images/logo.png",
      ),
      scale: 3,
      alignment: Alignment.topLeft),
);

Widget menuCard(BuildContext context, Menu menu) {
  return Container(
    margin: EdgeInsets.only(top: 5, right: 20, left: 5, bottom: 15),
    width: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      boxShadow: [
        BoxShadow(
            color: menu.color.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(2, 3))
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () {
          RpmApplication.router.navigateTo(context, menu.route);
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Icon(
                  menu.iconData,
                  size: 25,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                menu.descripcion,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
