import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playas/src/models/images-certificados.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CertificadoMovPage extends StatefulWidget {
  static const String route = '/validarCertificadoQR';

  @override
  _CertificadoMovPageState createState() => _CertificadoMovPageState();
}

class _CertificadoMovPageState extends State<CertificadoMovPage> {
  String qrcodigo = "";
  String detalle = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScan = false;
  bool load = true;
  bool text = true;

  List<ImagenesCertificados> imagesCertificados = [];

  @override
  initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
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
            ),
            backgroundColor: Colors.white,
          )),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: result == null
                  ? _buildQrView(context)
                  : load
                      ? Container(
                          alignment: Alignment.center,
                          height: 60,
                          child: CircularProgressIndicator())
                      : imagenesDocumento()),
          Container(
              height: 80,
              alignment: Alignment.center,
              child: result == null
                  ? Text(
                      'Escanee el código QR de su documento',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          result = null;
                          imagesCertificados = [];
                        });
                      },
                      child: Text(
                        '$detalle \nToque aquí para una nueva consulta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )))
        ],
      ),
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

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 170.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).primaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        load = true;
        text = false;
        qrcodigo = result!.code;
        String tipo = qrcodigo[0];
        String codigo = qrcodigo.substring(1, qrcodigo.length);

        String path = 'rpm-ventanilla/api/documento/codigo/$codigo/tipo/$tipo';
        findAllResponse(path, false).then((response) {
          setState(() {
            Iterable list = json.decode(utf8.decode(response.bodyBytes));
            imagesCertificados = list
                .map((model) => ImagenesCertificados().fromJson(model))
                .toList();
            detalle = imagesCertificados[0].urlImage!;
            imagesCertificados.removeAt(0);
            load = false;
            text = false;
          });
        });
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No tiene permisos para utilizar la cámara')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
