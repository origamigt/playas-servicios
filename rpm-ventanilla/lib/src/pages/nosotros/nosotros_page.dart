import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/images-certificados.dart';
import 'package:playas/src/providers/certificado_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';

class NosotrosPage extends StatefulWidget {
  static const String route = '/acercaDe';

  @override
  _NosotrosPageState createState() => _NosotrosPageState();
}

class _NosotrosPageState extends State<NosotrosPage> {
  String codigo = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Data tipo = tiposBusqueda[0];
  TextEditingController codigoCtrl = TextEditingController();
  List<ImagenesCertificados> imagesCertificados = [];
  CertificadoProvider? certificadoProvider;
  final _formKey = GlobalKey<FormState>();

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
    certificadoProvider = Provider.of<CertificadoProvider>(context);

    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Validar certificado'),
          body: body(),
          footer: Container(),
        ));
  }

  Widget body() {
    return Column(
      children: <Widget>[
        tituloWidget(context, 'Escoja el tipo de validación'),
        Wrap(
          children: tiposWidget(),
        ),
        Container(
            height: 80,
            alignment: Alignment.center,
            child: TextFormField(
              controller: codigoCtrl,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingrese el código de verificación';
                }
              },
              decoration: InputDecoration(
                suffix: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    validarCertificado();
                  },
                ),
              ),
              textAlign: TextAlign.start,
            )),
        Expanded(
            flex: 4,
            child: certificadoProvider!.status == StatusCertificadoProv.Unknown
                ? Container()
                : certificadoProvider!.status == StatusCertificadoProv.Searching
                    ? Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: CircularProgressIndicator())
                    : imagenesDocumento()),
      ],
    );
  }

  Widget imagenesDocumento() {
    return Scrollbar(
        isAlwaysShown: true,
        child: ListView.builder(
          itemCount: imagesCertificados.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(top: 12),
                child: InteractiveViewer(
                    panEnabled: false,
                    // Set it to false
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 2,
                    child: imagesCertificados[index].urlImage != null
                        ? Image.network(imagesCertificados[index].urlImage!,
                            fit: BoxFit.fill, loadingBuilder:
                                (BuildContext context, Widget? child,
                                    ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child!;
                            return Container(
                              alignment: Alignment.center,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          })
                        : Container()));
          },
        ));
  }

  List<Widget> tiposWidget() {
    List<Widget> choices = [];
    tiposBusqueda.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          selectedColor: colorSecond.withOpacity(0.8),
          label: Text(
            item.data!,
            style: Theme.of(context).textTheme.headline6,
          ),
          selected: tipo == item,
          onSelected: (selected) {
            setState(() {
              tipo = (selected ? item : null)!;
            });
          },
        ),
      ));
    });
    return choices;
  }

  void validarCertificado() {
    final Future<Map<String, dynamic>> successfulMessage;
    successfulMessage =
        certificadoProvider!.validarCertificado(codigoCtrl.text, tipo.data![0]);
    successfulMessage.then((response) {
      if (response['status']) {
        imagesCertificados = response['data'];
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
