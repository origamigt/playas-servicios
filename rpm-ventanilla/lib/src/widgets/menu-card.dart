import 'package:flutter/material.dart';
import 'package:playas/src/models/menu.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:universal_platform/universal_platform.dart';

class MenuCard extends StatelessWidget {
  bool isWeb = UniversalPlatform.isWeb;
  final List<Menu>? menus;

  MenuCard({@required this.menus});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: menus!.length,
        itemBuilder: (context, i) => menuCard(context, menus![i], isWeb),
      ),
    );
  }
}
