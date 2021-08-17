import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:playas/src/widgets/components.dart';

class PageComponent extends StatelessWidget {
  Widget? header, body, footer;

  PageComponent({this.header, this.body, this.footer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: WaveClipperTwo(reverse: true),
                  child: Container(
                    height: 100,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            Container(
              decoration: boxDecorationPlayasBG,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [header!, body!, footer!],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
