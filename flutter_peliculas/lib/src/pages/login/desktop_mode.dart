import 'package:flutter/material.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/login_form.dart';

class DesktopMode extends StatefulWidget {
  @override
  _DesktopModeState createState() => _DesktopModeState();
}

class _DesktopModeState extends State<DesktopMode> {
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Container(
        decoration: boxDecorationBG,
        child: Center(
            child: Container(
                height: heightSize * 0.70,
                width: widthSize * 0.70,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Row(children: [
                      playasBG(heightSize, widthSize),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(top: 25),
                              decoration: boxDecorationLogin,
                              child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/logo.png',
                                          height: heightSize * 0.2,
                                          width: widthSize * 0.15),
                                      SizedBox(height: 20),
                                      LoginForm(0, 0.009, 18, 0.04, 0.01, 0.03,
                                          75, 0.01, 0.009, 0.01, 0.006)
                                    ]),
                              )))
                    ])))));
  }
}
