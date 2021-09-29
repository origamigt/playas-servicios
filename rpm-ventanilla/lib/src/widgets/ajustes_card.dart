import 'package:flutter/material.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:responsive_property/responsive_property.dart';
import 'package:universal_platform/universal_platform.dart';

class AjustesCard extends StatelessWidget {
  bool isWeb = UniversalPlatform.isWeb;
  final List<Menu>? menus;

  AjustesCard({@required this.menus});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive({
              mobileScreenScope: 1,
              tabletScreenScope: 3,
              desktopScreenScope: 3
            }).resolve(context)!,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.4),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: menus!.length,
          itemBuilder: (context, index) {
            Menu menu = menus![index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[menuCard(context, menu, isWeb, true)],
            );
          },
        ));
  }
}
