import 'package:flutter/material.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/data.dart';
import 'package:playas/src/models/images-certificados.dart';
import 'package:playas/src/providers/certificado_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';

class CertificadoWebPage extends StatefulWidget {
  static const String route = '/validarCertificado';

  @override
  _CertificadoWebPageState createState() => _CertificadoWebPageState();
}

class _CertificadoWebPageState extends State<CertificadoWebPage> {
  String codigo = "";
  String detalle = "";
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
          header: tituloPagina(context, 'Validar certificado', true),
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Wrap(
            children: tiposWidget(),
          ),
          SizedBox(
            height: 20,
          ),
          subTituloWidget(context,
              'Para validar su certificado o razón de inscripción ingrese su código de verificación'),
          SizedBox(
            height: 20,
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        validarCertificado();
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  hintText:
                      'Ingrese el código de verificación de su certificado',
                ),
                textAlign: TextAlign.start,
              )),
          subTituloWidget(context, detalle),
          certificadoProvider!.status == StatusCertificadoProv.Unknown
              ? Container()
              : certificadoProvider!.status == StatusCertificadoProv.Searching
                  ? cargando()
                  : imagenesDocumento()
        ],
      ),
    );
  }

  Widget imagenesDocumento() {
    return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Scrollbar(
            isAlwaysShown: true,
            child: ListView.builder(
              itemCount: imagesCertificados.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(top: 12),
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
                        : Container());
              },
            )));
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
      print(response.toString());
      if (response['status']) {
        imagesCertificados = response['data'];
        detalle = imagesCertificados[0].urlImage!;
        imagesCertificados.removeAt(0);
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
