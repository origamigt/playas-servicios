import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:playas/src/models/acto.dart';
import 'package:playas/src/models/acto_requisito.dart';
import 'package:playas/src/models/persona.dart';
import 'package:playas/src/models/solicitud.dart';
import 'package:playas/src/models/user.dart';
import 'package:playas/src/providers/actos_provider.dart';
import 'package:playas/src/providers/pago_provider.dart';
import 'package:playas/src/providers/persona_provider.dart';
import 'package:playas/src/providers/requisitos_provider.dart';
import 'package:playas/src/providers/usuario_provider.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class InscripcionesPage extends StatefulWidget {
  static const String route = '/inscripciones';

  @override
  InscripcionesState createState() => InscripcionesState();
}

class InscripcionesState extends State<InscripcionesPage> {
  Size? size;
  bool isWeb = UniversalPlatform.isWeb;
  final _actosProvider = ActosProvider();
  Acto acto = Acto();
  Acto? inscripcion;
  UsuarioProvider? userProvider;
  PersonaProvider? personaProvider;
  PagoProvider? pagoProvider;
  RequisitosProvider? requisitoProvider;

  TextEditingController identificacionCtrl = TextEditingController();
  TextEditingController datosPersonaCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController correoCtrl = TextEditingController();

  TextEditingController obsCtrl = TextEditingController();

  String estadoCivilSol = '';
  User? usuario;
  final _formKey = GlobalKey<FormState>();

  Future<List<Acto?>>? inscripciones;
  List<ActoRequisito> requisitos = [];

  @override
  void initState() {
    super.initState();
    inscripciones = _actosProvider.findActosInscripciones();
  }

  @override
  Widget build(BuildContext context) {
    acto.id = 0;
    userProvider = Provider.of<UsuarioProvider>(context);
    personaProvider = Provider.of<PersonaProvider>(context);
    pagoProvider = Provider.of<PagoProvider>(context);
    requisitoProvider = Provider.of<RequisitosProvider>(context);
    userProvider!.initialize().then((value) {
      usuario = value;
      PubPersona persona = usuario!.persona!;
      identificacionCtrl.text = persona.cedRuc!;
      var nombres = persona.nombres! + ' ' + persona.apellidos!;
      datosPersonaCtrl.text = nombres;
      direccionCtrl.text = persona.direccion!;
      telefonoCtrl.text = persona.telefono1!;
      correoCtrl.text = persona.correo1!;
    });
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Inscripciones en linea', isWeb),
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
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tituloWidget(context, 'Contrato a inscribir'),
            inscripcionesWidget(),
            tituloWidget(context, 'Requisitos'),
            requisitosXinscripcion(),
            observacionWidget(),
            tituloWidget(context, 'Datos del solicitante y factura'),
            identificacionWidget(),
            nombresWidget(),
            direccionWidget(),
            telefonoWidget(),
            correoWidget(),
            SizedBox(
              height: 15,
            ),
            pagoProvider!.status == StatusPago.Procesing
                ? loading("Procesando solicitud...")
                : Center(
                    child: btnProcesarPago(),
                  ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget observacionWidget() {
    return datosWidget(
        context,
        '¿Quieres contarnos algo más?',
        TextFormField(
          controller: obsCtrl,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese alguna observación a su solicitud';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.comment_bank_outlined,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget identificacionWidget() {
    return datosWidget(
      context,
      'Identificación',
      TextFormField(
        controller: identificacionCtrl,
        readOnly: true,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Ingrese la identificación del solicitante';
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
          ),
          /*suffixIcon: personaProvider!.personaStatusPersonProv ==
                  StatusPersonProv.Searching
              ? loading("...")
              : btnBuscarPersona('SOLICITANTE'),*/
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget nombresWidget() {
    return datosWidget(
        context,
        'Datos personales',
        TextFormField(
          controller: datosPersonaCtrl,
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese los nombres del solicitante';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.accessibility,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget direccionWidget() {
    return datosWidget(
        context,
        'Dirección',
        TextFormField(
          readOnly: true,
          controller: direccionCtrl,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese la dirección del solicitante';
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.gps_fixed,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget correoWidget() {
    return datosWidget(
        context,
        'Correo electrónico',
        TextFormField(
          readOnly: true,
          controller: correoCtrl,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ingrese el correo electrónico del solicitante';
            }
          },
          textAlign: TextAlign.start,
        ));
  }

  Widget telefonoWidget() {
    return datosWidget(
        context,
        'Teléfono',
        TextFormField(
          readOnly: true,
          controller: telefonoCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.phone_android_outlined,
            ),
          ),
          textAlign: TextAlign.start,
        ));
  }

  Widget btnBuscarPersona(String tipo) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () async {
        if (tipo == 'SOLICITANTE') {
          if (identificacionCtrl.text.isEmpty) {
            mensajeError(context, 'Ingrese la identificación del solicitante');
            return;
          }
        } else {
          /*if (identificacionFactCtrl.text.isEmpty) {
            mensajeError(context,
                'Ingrese la identificación de quien se emitirá la factura');
            return;
          }*/
        }
        buscarPersona(tipo);
      },
    );
  }

  Widget btnProcesarPago() {
    return FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.5,
        child: Container(
          height: 45,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                )),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  doProcesarSolicitud();
                }
              },
              child: Text(
                'Generar solicitud',
              )),
        ));
  }

  Widget inscripcionesWidget() {
    return FutureBuilder(
      future: inscripciones,
      builder: (BuildContext context, AsyncSnapshot<List<Acto?>> snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: 110,
              alignment: Alignment.center,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.40,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 5,
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    Acto? item = snapshot.data![i];
                    return Container(
                      alignment: Alignment.center,
                      width: size!.width + 10,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: FilterChip(
                        selectedColor: colorSecond.withOpacity(0.5),
                        label: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item!.acto != null
                                ? StringUtils.capitalize(item.acto!)
                                : '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        selected: inscripcion == item,
                        onSelected: (selected) {
                          setState(() {
                            inscripcion = (selected ? item : null)!;
                            doBuscarRequisitos();
                          });
                        },
                      ),
                    );
                  }));
        } else {
          return Container(
              height: 100.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget requisitosXinscripcion() {
    switch (requisitoProvider!.status) {
      case StatusRequisitos.Unknown:
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Escoja el acto a inscribir',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      case StatusRequisitos.Searching:
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            loading("Cargando requisitos..."),
            SizedBox(
              height: 10,
            ),
          ],
        );
      case StatusRequisitos.Found:
        return requisitosWidget();
      case StatusRequisitos.NoFound:
        return Text('No se encontraron requisitos');
      default:
        return Container();
    }
  }

  Widget requisitosWidget() {
    return Column(
      children: [
        Text(
          'Los archivos deben ser en tipo pdf y maximo 4mb',
          style: Theme.of(context).textTheme.headline5,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: requisitos.length,
            itemBuilder: (context, i) {
              ActoRequisito item = requisitos[i];
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  height: 140,
                  width: size!.width - 20,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: item.requerido!
                            ? Colors.red
                            : Theme.of(context).primaryColor,
                        width: 1,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Wrap(
                        children: [
                          Text(
                            item.requisito!,
                            style: Theme.of(context).textTheme.headline6,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Text(
                        item.nombreArchivo,
                        style: TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                      TextButton(
                        child: Text(
                          'Subir archivo',
                          style: TextStyle(fontSize: 10),
                        ),
                        onPressed: () async {
                          _openFileExplorer(item);
                        },
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  doBuscarRequisitos() {
    final Future<Map<String, dynamic>> successfulMessage =
        requisitoProvider!.requisitosXacto(inscripcion!.id!);

    successfulMessage.then((response) async {
      if (response['status']) {
        setState(() {
          requisitos = response['data'];
        });
      } else {
        mensajeError(context, response['message']);
        setState(() {
          requisitos = [];
        });
      }
    });
  }

  void _openFileExplorer(ActoRequisito item) async {
    String extension = 'pdf';
    List<PlatformFile>? archivos;
    try {
      archivos = (await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: extension.replaceAll(' ', '').split(','),
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
      item.nombreArchivo =
          archivos != null ? archivos.map((e) => e.name).toString() : '...';
      item.archivo = archivos![0].bytes;
    });
  }

  doProcesarSolicitud() {
    if (inscripcion == null) {
      mensajeError(context, 'Debe escoger el acto a inscribir');
      return;
    }
    if (requisitos.isNotEmpty) {
      for (ActoRequisito r in requisitos) {
        if (r.requerido! && r.archivo == null) {
          mensajeError(context, 'Debe subir los requisitos obligatorios');
          return;
        }
      }
    } else {
      mensajeError(context, 'Debe cargar los requisitos');
      return;
    }
    print(requisitos.length);
    final Future<Map<String, dynamic>> successfulMessage = pagoProvider!
        .procesarInscripcion(
            obsCtrl.text,
            identificacionCtrl.text,
            datosPersonaCtrl.text,
            direccionCtrl.text,
            telefonoCtrl.text,
            correoCtrl.text,
            estadoCivilSol,
            identificacionCtrl.text,
            datosPersonaCtrl.text,
            direccionCtrl.text,
            telefonoCtrl.text,
            correoCtrl.text,
            acto,
            usuario!.id!,
            requisitos);

    successfulMessage.then((response) async {
      if (response['status']) {
        Solicitud rest = response['data'];
        mensajeInfo(context, response['message']);
      } else {
        mensajeError(context, response['message']);
      }
    });
  }

  buscarPersona(String tipo) {
    final Future<Map<String, dynamic>> successfulMessage;
    successfulMessage = personaProvider!.buscarPersona(
        tipo == 'SOLICITANTE'
            ? identificacionCtrl.text
            : 'identificacionFactCtrl.text',
        tipo);

    successfulMessage.then((response) {
      print(response.toString());
      if (response['status']) {
        PubPersona persona = response['persona'];
        print(persona.cedRuc);
        if (tipo == 'SOLICITANTE') {
          identificacionCtrl.text = persona.cedRuc!;
          datosPersonaCtrl.text =
              (persona.apellidos ?? '') + ' ' + (persona.nombres ?? '');
          direccionCtrl.text = persona.direccion ?? '';
          telefonoCtrl.text = persona.telefono1 ?? '';
          correoCtrl.text = persona.correo1 ?? '';
          estadoCivilSol = persona.estadoCivil ?? '';
        }
      } else {
        mensajeError(context, response['message']);
      }
    });
  }
}
