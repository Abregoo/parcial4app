import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Listados

listados() {
  listarAviones();
  listarClientes();
  listarDestinos();
  listarHorarios();
  listarReservas();
  listarVuelos();
}

listarAviones() async {
  var aviones = await db.collection("avion").get();

  aviones.docs.forEach((element) {
    print(element.data());
  });
}

listarHorarios() async {
  var horarios = await db.collection("horarios").get();

  horarios.docs.forEach((element) {
    print(element.data());
  });
}

listarDestinos() async {
  var destinos = await db.collection("detinos").get();

  destinos.docs.forEach((element) {
    print(element.data());
  });
}

listarVuelos() async {
  var vuelos = await db.collection("vuelos").get();

  vuelos.docs.forEach((element) {
    print(element.data());
  });
}

listarClientes() async {
  var clientes = await db.collection("clientes").get();

  clientes.docs.forEach((element) {
    print(element.data());
  });
}

listarReservas() async {
  var reservas = await db.collection("reservas").get();

  reservas.docs.forEach((element) {
    print(element.data());
  });
}

//CRUD AVION
crearAvion(int estado, String marca) {
  final avion = {"estado": estado, "marca": marca};

  db.collection("avion").add(avion).then(
      (DocumentReference doc) => print('Avion agregado con ID: ${doc.id}'));
}

//CRUD HORARIO
crearHorario(String horavuelo) {
  final horario = {"hora_vuelo": horavuelo};

  db.collection("horarios").add(horario).then(
      (DocumentReference doc) => print('Horario agregado con ID: ${doc.id}'));
}

//CRUD DESTINO
crearDestino(String nombre, String idHorario) {}

//CRUD CLIENTES

//CRUD VUELOS

//CRUD RESERVAS