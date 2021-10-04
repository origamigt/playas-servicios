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

class VerificarDocPage extends StatefulWidget {
  static const String route = '/verificarDocumento';

  @override
  VerificarDocPageState createState() => VerificarDocPageState();
}

class VerificarDocPageState extends State<VerificarDocPage> {
  ValidarDocProvider? validarDocProvider;
  String? extension = 'pdf';
  List<PlatformFile>? archivos;
  bool cargandoArchivo = false;
  String? directorioArchivo;
  String? nombreArchivo;
  Documento? data;
  final _formKey = GlobalKey<FormState>();
  DateFormat dt = DateFormat('dd-MM-yyyy – hh:mm');

  @override
  Widget build(BuildContext context) {
    validarDocProvider = Provider.of<ValidarDocProvider>(context);
    return Form(
      key: _formKey,
      child: PageComponent(
        header: tituloPagina(context, 'Verificar documentos'),
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
                  : archivos != null
                      ? Container(
                          alignment: Alignment.center,
                          height: 80,
                          child: ListView.separated(
                            itemCount: archivos != null && archivos!.isNotEmpty
                                ? archivos!.length
                                : 1,
                            itemBuilder: (BuildContext context, int index) {
                              final bool isMultiPath =
                                  archivos != null && archivos!.isNotEmpty;
                              final String name = 'Archivo: ' +
                                  (isMultiPath
                                      ? archivos!
                                          .map((e) => e.name)
                                          .toList()[index]
                                      : nombreArchivo ?? '...');

                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  name,
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
            : archivos != null
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tituloWidget2(context, 'Firma valida'),
            subTituloWidget2(context, data!.firmaValida! ? 'SI' : 'NO'),
            tituloWidget2(context, 'Documento valido'),
            subTituloWidget2(context, data!.documentoValido! ? 'SI' : 'NO'),
            data!.error != null
                ? subTituloWidget(context, data!.error!)
                : Container(),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data!.certificados!.length,
              itemBuilder: (context, i) =>
                  detalleCertificado(data!.certificados![i]),
            )
            /* data!.error!.isNotEmpty
              ? subTituloWidget(context, data!.error!)
              : Container(),
           */
          ],
        ),
      ),
    );
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
      archivos = (await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: (extension?.isNotEmpty ?? false)
            ? extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      mensajeError(context, 'Su dispositivo no soporta la carga de archivos');
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      cargandoArchivo = false;
      nombreArchivo =
          archivos != null ? archivos!.map((e) => e.name).toString() : '...';
    });
  }

  validarDocumento() {
    final Future<Map<String, dynamic>> successfulMessage;
    successfulMessage =
        validarDocProvider!.validarDocumento(archivos![0].bytes, nombreArchivo);

    successfulMessage.then((response) {
      print(response.toString());
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
