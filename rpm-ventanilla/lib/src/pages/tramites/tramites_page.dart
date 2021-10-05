import 'package:flutter/material.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/providers/actos_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:universal_platform/universal_platform.dart';

class TramitesPage extends StatelessWidget {
  static const String route = '/tramites';
  bool isWeb = UniversalPlatform.isWeb;
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
        header: tituloPagina(context, 'Servicios en linea', isWeb),
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
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return FractionallySizedBox(
                  widthFactor: 0.5,
                  child: tramitesCard(snapshot.data!),
                );
              } else {
                return tramitesCard(snapshot.data!);
              }
            },
          );
          /*return TramitesCard(
            actos: snapshot.data!,
          );*/
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget tramitesCard(List<Acto>? actos) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 30.0,
          ),
          itemCount: actos!.length,
          itemBuilder: (context, index) {
            Acto acto = actos[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 90,
                  child: acto.urlImage != null
                      ? FadeInImage(
                          height: 100,
                          image: NetworkImage(actos[index].urlImage!),
                          placeholder: AssetImage('assets/images/no-image.jpg'),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/no-image.jpg',
                                fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/no-image.jpg',
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    acto.acto!,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            );
          },
        ));
  }
}
