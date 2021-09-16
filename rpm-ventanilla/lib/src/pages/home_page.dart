import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/providers/actos_provider.dart';
import 'package:playas/src/widgets/acto_widget.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/menu-card.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:universal_platform/universal_platform.dart';

class HomePage extends StatelessWidget {
  bool isWeb = UniversalPlatform.isWeb;
  static const String route = '/inicio';

  final _actosProvider = ActosProvider();

  @override
  Widget build(BuildContext context) {
    _actosProvider.findActosPopulares();
    return Scaffold(
      bottomNavigationBar: Container(
        height: 0,
      ),
      body: PageComponent(
        header: tituloPagina(context,
            'Registro Municipal de la\nPropiedad y Mercantil del Cantón Playas'),
        body: _swiperTarjetas(),
        footer: _footer(context),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return StreamBuilder(
      stream: _actosProvider.actosStream,
      builder: (BuildContext context, AsyncSnapshot<List<Acto>?> snapshot) {
        if (snapshot.hasData) {
          return ActoCard(
            actos: snapshot.data!,
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          MenuCard(
            menus: menus(isWeb),
          ),
        ],
      ),
    );
  }
}
