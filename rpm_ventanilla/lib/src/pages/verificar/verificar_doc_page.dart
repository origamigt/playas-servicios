import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:playas/src/models/certificado.dart';
import 'package:playas/src/models/documento.dart';
import 'package:playas/src/providers/validardoc_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class VerificarDocPage extends StatefulWidget {
  static const String route = '/verificarDocumento';

  @override
  VerificarDocPageState createState() => VerificarDocPageState();
}

class VerificarDocPageState extends State<VerificarDocPage> {
  bool isWeb = UniversalPlatform.isWeb;
  ValidarDocProvider? validarDocProvider;
  String? extension = 'pdf';
  FilePickerResult? result;
  PlatformFile? file;
  bool cargandoArchivo = false;
  String? directorioArchivo;
  String? nombreArchivo;
  Documento? data;
  final _formKey = GlobalKey<FormState>();
  DateFormat dt = DateFormat('dd-MM-yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    validarDocProvider = Provider.of<ValidarDocProvider>(context);
    return Form(
      key: _formKey,
      child: PageComponent(
        header: tituloPagina(context, 'Verificar documentos', isWeb),
        body: body(),
        footer: Container(),
      ),
    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        subTituloWidget(context,
            'Para validar sus archivos debe cargar su certificado o razón de inscripción y procede a validar el documento'),
        TextButton(
          child: Text(
            'Cargar archivo',
            style: Theme.of(context).textTheme.headline6,
          ),
          onPressed: () async {
            _openFileExplorer();
          },
        ),
        Builder(
          builder: (BuildContext context) => cargandoArchivo
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: const CircularProgressIndicator(),
                )
              : directorioArchivo != null
                  ? ListTile(
                      title: const Text('Directory path'),
                      subtitle: Text(directorioArchivo!),
                    )
                  : file != null
                      ? Container(
                          alignment: Alignment.center,
                          height: 80,
                          child: ListView.separated(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              final String name = 'Archivo: $nombreArchivo';

                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  name,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                        )
                      : Container(),
        ),
        validarDocProvider!.status == StatusValidarDoc.Searching
            ? loading("...")
            : file != null
                ? TextButton(
                    child: Text(
                      'Validar archivo',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () async {
                      validarDocumento();
                    },
                  )
                : const SizedBox(),
        validarDocProvider!.status == StatusValidarDoc.Found
            ? datosDocumento()
            : Container()
      ],
    );
  }

  Widget datosDocumento() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                tituloWidget2(context, 'Firma válida'),
                subTituloWidget2(context, data!.firmaValida! ? 'SI' : 'NO'),
                tituloWidget2(context, 'Documento valido'),
                subTituloWidget2(context, data!.documentoValido! ? 'SI' : 'NO'),
                data!.error != null
                    ? subTituloWidget(context, data!.error!)
                    : Container(),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: data!.certificados!.length,
                    itemBuilder: (context, i) =>
                        detalleCertificado(data!.certificados![i]),
                  ),
                )
                /* data!.error!.isNotEmpty
              ? subTituloWidget(context, data!.error!)
              : Container(),
           */
              ],
            ),
          ),
        ));
  }

  Widget detalleCertificado(Certificado certificado) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          tituloWidget2(context, 'Información Firmante'),
          subTituloWidget2(context, certificado.informacionFirmante!),
          tituloWidget2(context, 'Información Entidad Certificadora'),
          subTituloWidget2(
              context, certificado.informacionEntidadCertificadora!),
          tituloWidget2(context, 'Fecha'),
          subTituloWidget2(context, dt.format(certificado.generado!)),
          tituloWidget2(context, 'Motivo Documento'),
          subTituloWidget2(context, certificado.motivoDocumento!),
          tituloWidget2(context, 'Localizacion Documento'),
          subTituloWidget2(context, certificado.localizacionDocumento!),
          tituloWidget2(context, 'Firma Verificada'),
          subTituloWidget2(context, certificado.firmaVerificada! ? 'SI' : 'NO'),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void _openFileExplorer() async {
    setState(() => cargandoArchivo = true);
    try {
      result = (await FilePicker.platform.pickFiles(
          onFileLoading: (FilePickerStatus status) => print(status),
          type: FileType.custom,
          withData: true,
          allowedExtensions: ['pdf']));
    } on PlatformException catch (e) {
      mensajeError(context, 'Su dispositivo no soporta la carga de archivos');
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      cargandoArchivo = false;
      if (result != null) {
        file = result!.files.first;
        nombreArchivo = file != null ? file!.name : '...';
      } else {
        // User canceled the picker
      }
    });
  }

  validarDocumento() {
    final Future<Map<String, dynamic>> successfulMessage;
    successfulMessage =
        validarDocProvider!.validarDocumento(file!.bytes, nombreArchivo);

    successfulMessage.then((response) {
      if (response['status']) {
        setState(() {
          data = response['data'];
        });
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
