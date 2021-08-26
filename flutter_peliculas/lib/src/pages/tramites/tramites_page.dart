import 'package:flutter/material.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/providers/actos_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:playas/src/widgets/tramites_card.dart';

class TramitesPage extends StatelessWidget {
  static const String route = '/tramites';

  final _actosProvider = ActosProvider();
  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    _actosProvider.findActos();
    this.context = context;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 0,
      ),
      body: PageComponent(
        header: tituloPagina(context, 'Servicios en linea'),
        body: _gridTramites(),
        footer: Container(),
      ),
    );
  }

  Widget _gridTramites() {
    return StreamBuilder(
      stream: _actosProvider.actosStream,
      builder: (BuildContext context, AsyncSnapshot<List<Acto>?> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: TramitesCard(
              actos: snapshot.data!,
            ),
          );
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
