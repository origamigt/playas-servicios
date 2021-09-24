import 'package:flutter/material.dart';
import 'package:playas/src/widgets/components.dart';
import 'package:playas/src/widgets/page_component.dart';

class NosotrosPage extends StatefulWidget {
  static const String route = '/acercaDe';

  @override
  _NosotrosPageState createState() => _NosotrosPageState();
}

class _NosotrosPageState extends State<NosotrosPage> {
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
    return Form(
        key: _formKey,
        child: PageComponent(
          header: tituloPagina(context, 'Sobre nosotros'),
          body: body(),
          footer: Container(),
        ));
  }

  Widget body() {
    return Column(children: <Widget>[]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
