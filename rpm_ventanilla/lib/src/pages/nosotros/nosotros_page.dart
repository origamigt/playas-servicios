import 'package:flutter/material.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

class NosotrosPage extends StatefulWidget {
  static const String route = '/acercaDe';

  @override
  _NosotrosPageState createState() => _NosotrosPageState();
}

class _NosotrosPageState extends State<NosotrosPage> {
  final _formKey = GlobalKey<FormState>();
  bool isWeb = UniversalPlatform.isWeb;
  @override
  initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Sobre nosotros', isWeb),
          body: body(),
          footer: Container(),
        ));
  }

  Widget body() {
    return LayoutBuilder(
      builder: (context, constraints) {
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
    return Column(children: <Widget>[
      tituloWidget(context, 'Misión'),
      subTituloWidget(context,
          'Registrar documental y electrónicamente los títulos de propiedades de los predios del Cantón Jipijapa, garantizando la Seguridad Jurídica Inmobiliaria;  mediante los sistemas institucionales que se encargan de realizar y generar la información de acuerdo a los parámetros establecidos, para emitir los certificados y/o inscripciones  que requiera la ciudadanía usuaria de nuestros servicios, en concordancia con las disposiciones de Ley correspondientes.'),
      SizedBox(
        height: 10,
      ),
      tituloWidget(context, 'Visión'),
      subTituloWidget(context,
          'Posesionar a esta institución, dentro de cinco años,  como un ente de calidad y eficacia en la entrega de nuestros servicios; trabajando bajo esquemas jurídico-técnicos y tecnológicos actualizados, para impulsar un proceso de crecimiento del servicio público, con profesionalismo y responsabilidad, asegurando un mejoramiento continuo.'),
      //Image.asset('assets/images/logo.png', height: 110, width: 110),
      Column(
        children: [
          GestureDetector(
            onTap: () async {
              await canLaunch('https://origamiec.com/')
                  ? await launch('https://origamiec.com/')
                  : mensajeError(context,
                      'No se puede redirigir a https://origamiec.com/');
            },
            child: Image.asset(
              'assets/images/origami.png',
              height: 150,
              width: 200,
            ),
          ),
          Text(
            'Apasionados en la optimización y la transformación digital',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'proporcionando soluciones integrales que redunden en una atención de calidad a la ciudadanía',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            '2021 © All rigth reserved',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 30,
          )
        ],
      )
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
