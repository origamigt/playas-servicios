//import 'package:vrouter/vrouter.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:playas/src/models/menu.dart';
import 'package:universal_platform/universal_platform.dart';

class MenuLoginCard extends StatelessWidget {
  bool isWeb = UniversalPlatform.isWeb;
  final List<Menu>? menus;

  MenuLoginCard({@required this.menus});
  BuildContext? context;
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    this.context = context;
    return Container(
      height: 90,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: menus!.length,
        itemBuilder: (context, i) => menuCard(
          menus![i],
        ),
      ),
    );
  }

  Widget menuCard(Menu menu) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
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
          borderRadius: BorderRadius.all(Radius.circular(5)),
          onTap: () {
            //context!.vRouter.to(menu.route);
            context!.router.navigateNamed(menu.route);
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 5, right: 5, left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    menu.iconData,
                    size: 15,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  menu.descripcion,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
