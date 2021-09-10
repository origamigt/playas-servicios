import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playas/src/configs/constants.dart';
import 'package:playas/src/models/images-certificados.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ScanQrpage extends StatefulWidget {
  String route = '/validate';

  @override
  _ScanQrpageState createState() => _ScanQrpageState();
}

class _ScanQrpageState extends State<ScanQrpage> {
  String barcode = "", selectedUrl = qrCertificate;

  bool isScan = false;
  bool load = true;
  bool text = true;

  List<ImagesCertificados> imagesCertificados = [];

  @override
  initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    selectedUrl = qrCertificate;
    barcode = "";
    load = true;
    text = true;
    //scan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              brightness: Brightness.light,
              elevation: 1.0,
              centerTitle: true,
              title: Text(
                'Validar Documento',
                style: TextStyle(color: Colors.lightBlue, fontSize: 15),
              ),
              backgroundColor: Colors.white,
              /*actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.camera_alt, color: registroColor),
                  onPressed: scan,
                )
              ],*/
            )),
        body: load
            ? Center(
                child: text
                    ? Text('Escanee el Código QR de su Documento')
                    : JumpingDotsProgressIndicator(
                        fontSize: 25.0,
                      ),
              )
            : ListView.builder(
                itemCount: imagesCertificados.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Visibility(
                          visible: !load,
                          child: Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Image.network(
                                imagesCertificados[index].urlImage,
                                fit: BoxFit.fitHeight,
                              ))),
                    ],
                  );
                },
              ));
  }

  /*Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        load = true;
        text = false;
        this.barcode = barcode;
        switch(barcode.length){
          case 53: //CERTIFICADOS
            //getImagesCertificados(barcode.substring(43)).then((response) {
            getImagesDocumentos(barcode.substring(43), 1).then((response) {
              setState(() {
                Iterable list = json.decode(response.body);
                imagesCertificados = list
                    .map((model) => ImagesCertificados.fromJson(model))
                    .toList();
                load = false;
                text = false;
              });
            });
            break;
          case 65: //RAZONES DE INSCRIPCION
            getImagesDocumentos(barcode.substring(55), 2).then((response) {
              setState(() {
                Iterable list = json.decode(response.body);
                imagesCertificados = list
                    .map((model) => ImagesCertificados.fromJson(model))
                    .toList();
                load = false;
                text = false;
              });
            });
            break;
          case 64: //NOTAS DEVOLUTIVAS
            getImagesDocumentos(barcode.substring(54), 3).then((response) {
              setState(() {
                Iterable list = json.decode(response.body);
                imagesCertificados = list
                    .map((model) => ImagesCertificados.fromJson(model))
                    .toList();
                load = false;
                text = false;
              });
            });
            break;
        }
        //Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          load = false;
          this.barcode =
              'No se han otorgado los permisos necesarios a la aplicacion!';
        });
      } else {
        setState(() {
          this.barcode = 'Error: $e';
          load = false;
        });
      }
    } on FormatException {
      setState(() => this.barcode = 'No se logro identificar el codigo');
    } catch (e) {
      setState(() => this.barcode = 'No se logro identificar el codigo');
    }
  }*/

  @override
  void dispose() {
    super.dispose();
  }
}
