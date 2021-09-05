/*import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificarDocPage extends StatefulWidget {
  @override
  VerificarDocPageState createState() => VerificarDocPageState();
}

class VerificarDocPageState extends State<VerificarDocPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _nombreArchivo;
  List<PlatformFile>? archivos;
  String? directorioArchivo;
  String? _extension = 'pdf';
  bool cargandoArchivo = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.custom;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    _clearCachedFiles();
    setState(() => cargandoArchivo = true);
    try {
      directorioArchivo = null;
      archivos = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      cargandoArchivo = false;
      _nombreArchivo =
          archivos != null ? archivos!.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  void _selectFolder() {
    FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => directorioArchivo = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _openFileExplorer(),
                  child: const Text("Open file picker"),
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
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.50,
                                  child: Scrollbar(
                                      child: ListView.separated(
                                    itemCount:
                                        archivos != null && archivos!.isNotEmpty
                                            ? archivos!.length
                                            : 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final bool isMultiPath =
                                          archivos != null && archivos!.isNotEmpty;
                                      final String name = 'File $index: ' +
                                          (isMultiPath
                                              ? archivos!
                                                  .map((e) => e.name)
                                                  .toList()[index]
                                              : _nombreArchivo ?? '...');
                                      final path = archivos!
                                          .map((e) => e.path)
                                          .toList()[index]
                                          .toString();

                                      return ListTile(
                                        title: Text(
                                          name,
                                        ),
                                        subtitle: Text(path),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                  )),
                                )
                              : const SizedBox(),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
*/

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        TextButton(
          child: Text('Subir archivo'),
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
                      : const SizedBox(),
        ),
        validarDocProvider!.status == StatusValidarDoc.Searching
            ? loading("...")
            : archivos != null
                ? TextButton(
                    child: Text('Validar archivo'),
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
            tituloWidget(context, 'Firma valida'),
            subTituloWidget(context, data!.firmaValida! ? 'SI' : 'NO'),
            tituloWidget(context, 'Documento valido'),
            subTituloWidget(context, data!.documentoValido! ? 'SI' : 'NO'),
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
          tituloWidget(context, 'Información Firmante'),
          subTituloWidget(context, certificado.informacionFirmante!),
          tituloWidget(context, 'Cargo'),
          subTituloWidget(context, certificado.datosUsuario!.cargo!),
          tituloWidget(context, 'Información Entidad Certificadora'),
          subTituloWidget(
              context, certificado.informacionEntidadCertificadora!),
          tituloWidget(context, 'Fecha'),
          subTituloWidget(context, dt.format(certificado.generado!)),
          tituloWidget(context, 'Motivo Documento'),
          subTituloWidget(context, certificado.motivoDocumento!),
          tituloWidget(context, 'Localizacion Documento'),
          subTituloWidget(context, certificado.localizacionDocumento!),
          tituloWidget(context, 'Firma Verificada'),
          subTituloWidget(context, certificado.firmaVerificada! ? 'SI' : 'NO'),
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
