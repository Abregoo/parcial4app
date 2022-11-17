import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parcial4app/widgets/txtinput.dart';

class FormReservas extends StatefulWidget {
  FormReservas({Key? key}) : super(key: key);

  @override
  State<FormReservas> createState() => _FormReservasState();
}

class _FormReservasState extends State<FormReservas> {
  // TABLA CLIENTES
  final TextEditingController _nombreCtl = TextEditingController();
  final TextEditingController _apellidoCtlr = TextEditingController();
  final TextEditingController _fecha_nacimientoCtl = TextEditingController();
  final TextEditingController _sexoCtlr = TextEditingController();
  final TextEditingController _tipoCtl = TextEditingController();
  // TABLA RESERVAS
  final TextEditingController _estadoCtl = TextEditingController();
  //TABLA VUELOS
  final TextEditingController _tipo_vueloCtl = TextEditingController();
  final TextEditingController _avion_codigoCtl = TextEditingController();
  //TABLA DESTINOS
  final TextEditingController _nombre_destinoCtl = TextEditingController();
  //TABLA HORARIOS
  final TextEditingController _hora_vueloCtl = TextEditingController();

  final CollectionReference _clientes = FirebaseFirestore.instance.collection('clientes');
  final CollectionReference _reservas = FirebaseFirestore.instance.collection('reservas');
  final CollectionReference _avion = FirebaseFirestore.instance.collection('avion');
  final CollectionReference _usuarios = FirebaseFirestore.instance.collection('usuarios');
  final CollectionReference _vuelos = FirebaseFirestore.instance.collection('vuelos');
  final CollectionReference _destinos= FirebaseFirestore.instance.collection('destinos');
  final CollectionReference _horario = FirebaseFirestore.instance.collection('horarios');

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Input(
                  hintText: "Ingrese nombre",
                  labelText: "nombre",
                  txtvalue: _nombreCtl
                ),

                TextField(
                  controller: _nombreCtl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _apellidoCtlr,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final String nombre = _nombreCtl.text;
                    final String apellido = _apellidoCtlr.text;

                    if (apellido != null) {
                      await _usuarios
                          .add({"nombre": nombre, "apellido": apellido, "prueba": "Holaa"});
                       await _clientes
                          .add({"nombre": nombre, "apellido": apellido});

                      _nombreCtl.text = '';
                      _apellidoCtlr.text = '';
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
          stream: _usuarios.snapshots(),
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
                        // child: Row(
                        //   children: [
                        //     IconButton(
                        //         icon: const Icon(Icons.edit),
                        //         onPressed: () => _update(documentSnapshot)),
                        //     IconButton(
                        //         icon: const Icon(Icons.delete),
                        //         onPressed: () => _delete(documentSnapshot.id)),
                        //   ],
                        // ),
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
          child: const Icon(Icons.airplane_ticket_outlined, size: 35,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }



}
