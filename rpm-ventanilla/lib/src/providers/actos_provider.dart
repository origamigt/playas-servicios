import 'dart:async';

import 'package:playas/src/models/acto.dart';
import 'package:playas/src/providers/ws.dart';
import 'package:rxdart/rxdart.dart';

class ActosProvider {
  final _actosStreamController = PublishSubject<List<Acto>>();

  Stream<List<Acto>> get actosStream => _actosStreamController.stream;

  void disposeStreams() {
    _actosStreamController.close();
  }

  findActosPopulares() async {
    List<dynamic>? collection =
        await findAll('/rpm-ventanilla/api/actosPopulares', true);
    List<Acto>? actos = collection!.map((p) => Acto().fromJson(p)).toList();
    _actosStreamController.add(actos);
  }

  Future<Acto>? findActoId(int id) async {
    Map<String, dynamic> map =
        await find('/rpm-ventanilla/api/actos/id/$id', false);
    Acto? acto = Acto().fromJson(map);
    return acto;
  }

  findActos() async {
    List<dynamic>? collection =
        await findAll('/rpm-ventanilla/api/actos', true);
    List<Acto>? actos = collection!.map((p) => Acto().fromJson(p)).toList();
    _actosStreamController.add(actos);
  }

  Future<List<Acto?>>? findActosInscripciones() async {
    List<dynamic>? collection =
        await findAll('/rpm-ventanilla/api/actosInscricipciones', true);
    List<Acto>? actos = collection!.map((p) => Acto().fromJson(p)).toList();
    return actos;
  }

  Future<List<Acto?>>? findActosRequisitos() async {
    List<dynamic>? collection =
        await findAll('/rpm-ventanilla/api/actosInscricipciones', true);
    List<Acto>? actos = collection!.map((p) => Acto().fromJson(p)).toList();
    return actos;
  }
}
