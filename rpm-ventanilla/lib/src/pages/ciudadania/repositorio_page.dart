//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:playas/src/models/acto_requisito.dart';
import 'package:playas/src/providers/tramite_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositorioPage extends StatefulWidget {
  static const String route = '/misDocumentos';

  @override
  _RepositorioPageState createState() => _RepositorioPageState();
}

class _RepositorioPageState extends State<RepositorioPage> {
  bool isWeb = UniversalPlatform.isWeb;
  List<ActoRequisito> requisitos = [];
  Size? size;
  final _formKey = GlobalKey<FormState>();

  final tramiteProvider = TramiteProvider();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tramiteProvider.findRequisitos();
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Mis documentos', isWeb),
          body: body(),
          footer: Container(),
        ));
  }

  Widget body() {
    return LayoutBuilder(
      builder: (context, constraints) {
        size = MediaQuery.of(context).size;
        if (constraints.maxWidth > 600) {
          return FractionallySizedBox(
            widthFactor: 0.5,
            child: bodyDetail(),
          );
        } else {
          return bodyDetail();
        }
      },
    );
  }

  Widget bodyDetail() {
    return Container(
        width: size!.width,
        height: size!.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: tramiteProvider.requsitosStreamController,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ActoRequisito>?> snapshot) {
                  if (snapshot.hasData) {
                    requisitos = snapshot.data!;
                    return _buildList();
                  } else {
                    return cargando();
                  }
                },
              )
            ],
          ),
        ));
  }

  Widget _buildList() {
    return Scrollbar(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: requisitos.length,
            itemBuilder: (context, i) {
              ActoRequisito item = requisitos[i];
              return Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                width: size!.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          item.requisito!,
                          style: Theme.of(context).textTheme.headline2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      item.fecha!,
                      style: TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextButton(
                      child: Text(
                        'Descargar archivo',
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () async {
                        downloadFile(item.nombreArchivo);
                      },
                    ),
                  ],
                ),
              );
            }));
  }

  void downloadFile(String url) async {
    //print(url);
    if (isWeb) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    }
    //AnchorElement anchorElement = new AnchorElement(href: url);
    //anchorElement.download = url;
    // anchorElement.click();
  }
}
