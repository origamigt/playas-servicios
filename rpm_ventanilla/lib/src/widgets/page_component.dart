import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:playas/src/pages/home_page.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:universal_platform/universal_platform.dart';

class PageComponent extends StatelessWidget {
  bool isWeb = UniversalPlatform.isWeb;
  bool? back = true;
  Widget? header, body, footer;

  PageComponent({this.header, this.body, this.footer, this.back});

  @override
  Widget build(BuildContext context) {
    if (back == null) {
      back = true;
    }
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      logoFooter(),
                      ClipPath(
                        clipper: WaveClipperTwo(reverse: true),
                        child: Container(
                          height: 60,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              decoration: isWeb ? boxDecorationPlayasBG : null,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  back!
                      ? Stack(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    context.router
                                        .navigateNamed(HomePage.route);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                  )),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: header!,
                            ),
                          ],
                        )
                      : header!,
                  body!,
                  footer!
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget logoFooter() {
    return !isWeb
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/images/vur.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          )
        : Opacity(
            opacity: 0.6,
            child: Image.asset(
              'assets/images/vur.png',
              height: 100,
              width: 100,
            ),
          );
  }
}
