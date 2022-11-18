import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parcial4app/database/data.dart';
import 'package:parcial4app/widgets/dateimput.dart';
import 'package:parcial4app/widgets/dropdown.dart';
import 'package:parcial4app/widgets/txtinput.dart';

class FormReservas extends StatefulWidget {
  FormReservas({Key? key}) : super(key: key);

  @override
  State<FormReservas> createState() => _FormReservasState();
}

class _FormReservasState extends State<FormReservas> {
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listadosCatalogos();
  }


  // TABLA CLIENTES
  final TextEditingController _nombreCtl = TextEditingController();
    final TextEditingController _cedulaCtl = TextEditingController();
  final TextEditingController _apellidoCtlr = TextEditingController();
  final TextEditingController _fecha_nacimientoCtl = TextEditingController();
  final TextEditingController _sexoCtlr = TextEditingController();
  final TextEditingController _tipoCtl = TextEditingController();
  final TextEditingController _usuarioCtl = TextEditingController();
  // TABLA RESERVAS
  final TextEditingController _estadoCtl = TextEditingController();
  //TABLA VUELOS
  final TextEditingController _tipo_vueloCtl = TextEditingController();
  final TextEditingController _avion_codigoCtl = TextEditingController();
  //TABLA DESTINOS
  final TextEditingController _nombre_destinoCtl = TextEditingController();
  //TABLA HORARIOS
  final TextEditingController _hora_vueloCtl = TextEditingController();

  final CollectionReference _clientes =
      FirebaseFirestore.instance.collection('clientes');
  final CollectionReference _reservas =
      FirebaseFirestore.instance.collection('reservas');
  final CollectionReference _avion =
      FirebaseFirestore.instance.collection('avion');
  final CollectionReference _vuelos =
      FirebaseFirestore.instance.collection('vuelos');
  final CollectionReference _destinos =
      FirebaseFirestore.instance.collection('destinos');
  final CollectionReference _horario =
      FirebaseFirestore.instance.collection('horarios');

 

  space() {
    return SizedBox(
      height: 10,
    );
  }

  jsonClientes() {
    return {
      'nombre': _nombreCtl.text,
      'apellido': _apellidoCtlr.text,
      'fecha_nacimiento': _fecha_nacimientoCtl.text,
      'cedula': _cedulaCtl.text,
      'sexo': _sexoCtlr.text,
      'tipo': _tipoCtl.text,
      'usuario': _usuarioCtl.text,
    };
  }

  jsonVuelos() {
    return {
      'disponibilidad': 30,
      'tipo_vuelo': _tipo_vueloCtl.text,
      'avion': jsonAvion(),
      'destinos': jsonDestino(),
    };
  }

  jsonDestino(){
    return {
      'nombre_destino': _nombre_destinoCtl.text,
      'horario:': _hora_vueloCtl.text,
    };

  }

  jsonAvion(){
    return {
      'codigo': _avion_codigoCtl.text,
      'disponibilidad': 30,
    };
  }

  jsonReservas(){
    return {
      'estado': _estadoCtl.text,
      'vuelos': jsonVuelos(),
    };
  }

  limpiarFormulario(){
    _nombreCtl.text = '';
    _apellidoCtlr.text = '';
    _cedulaCtl.text = '';
    _fecha_nacimientoCtl.text = '';
    _sexoCtlr.text = '';
    _tipoCtl.text = '';
    _usuarioCtl.text = '';
    _estadoCtl.text = '';
    _tipo_vueloCtl.text = '';
    _avion_codigoCtl.text = '';
    _nombre_destinoCtl.text = '';
    _hora_vueloCtl.text = '';
  }

  //REGISTRAR VUELOS:
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: ListView(
              children: [
                Input(
                    hintText: "Ingrese nombre",
                    labelText: "nombre",
                    txtvalue: _nombreCtl),
                space(),
                Input(
                    hintText: "Ingrese apellido",
                    labelText: "apellido",
                    txtvalue: _apellidoCtlr),
                space(),
                InputDate(
                  hintText: "Ingrese fecha de nacimiento",
                  labelText: "fecha de nacimiento",
                  txtvalue: _fecha_nacimientoCtl,
                ),
                space(),
                Input(
                    hintText: "Ingrese cedula",
                    labelText: "cedula",
                    txtvalue: _cedulaCtl),
                space(),
                Dropdown(
                    selectedValue: 0,
                    onChanged: (selectedValue) =>
                        _sexoCtlr.text = selectedValue.toString(),
                    hintText: "Sexo",
                    lstitems: [
                      const DropdownMenuItem(
                        child: Text("Masculino"),
                        value: 1,
                      ),
                      const DropdownMenuItem(
                        child: Text("Femenino"),
                        value: 2,
                      )
                    ]),

                space(),
                Input(
                    hintText: "Ingrese usuario",
                    labelText: "usuario",
                    txtvalue: _usuarioCtl),
                space(),
                Dropdown(
                    selectedValue: 0,
                    onChanged: (selectedValue) => _tipoCtl.text = selectedValue.toString(),
                    hintText: "Tipo",
                    lstitems: [
                      const DropdownMenuItem(
                        child: Text("Natural"),
                        value: 1,
                      ),
                      const DropdownMenuItem(
                        child: Text("Juridico"),
                        value: 2,
                      )
                    ]),

//---------------------------------------------------
                space(),
                Dropdown(
                    selectedValue: 0,
                    onChanged: (selectedValue) =>
                        _tipo_vueloCtl.text = selectedValue.toString(),
                    hintText: "Tipo Vuelo",
                    lstitems: [
                      const DropdownMenuItem(
                        child: Text("Comercial"),
                        value: 1,
                      ),
                      const DropdownMenuItem(
                        child: Text("Ejecutivo"),
                        value: 2,
                      )
                    ]),

                space(),
                Dropdown(
                    selectedValue: 0,
                    onChanged: (selectedValue) =>
                        _avion_codigoCtl.text = selectedValue.toString(),
                    hintText: "Aerolínea",
                    lstitems: 
                    listarAviones().map((e){
                            return DropdownMenuItem(
                              child: Text(e['marca']), 
                              value: Text(e['hmarca']),
                    );}).toList(),                    
                    ),

                space(),
                Dropdown(
                    selectedValue: 0,
                    onChanged: (selectedValue) =>
                        _nombre_destinoCtl.text = selectedValue.toString(),
                    hintText: "Destinos",
                    lstitems: 
                    listarDestinos().map((e){
                            return DropdownMenuItem(
                              child: Text(e['nombre']), 
                              value: Text(e['nombre']),
                    );}).toList(),                    
                    ),

                space(),
                Dropdown(
                    selectedValue: 0,
                    onChanged: (selectedValue) =>
                        _hora_vueloCtl.text = selectedValue.toString(),
                    hintText: "Horarios",
                    lstitems: 
                    listarHorarios().map((e){
                            return DropdownMenuItem(
                              child: Text(e['hora_vuelo']), 
                              value: Text(e['hora_vuelo']),
                    );}).toList(),                    
                    ),
                //
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final String nombre = _nombreCtl.text;
                    final String apellido = _apellidoCtlr.text;

                    if (apellido != null) {
                      await _clientes.add(jsonClientes());
                      await _vuelos.add(jsonVuelos());
                      await _reservas.add(jsonReservas());

                      limpiarFormulario();
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Formulario Reservas')),
        ),
        body: StreamBuilder(
          stream: _clientes.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['nombre'].toString()),
                      subtitle: Text(documentSnapshot['apellido'].toString()),
                      trailing: SizedBox(
                        width: 100,
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// agregar productos
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(
            Icons.airplane_ticket_outlined,
            size: 35,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
