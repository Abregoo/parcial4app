import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parcial4app/paginas/formReserva.dart';
import 'package:parcial4app/principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseAPP());
}

class FirebaseAPP extends StatelessWidget {
  const FirebaseAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: FormReservas(),
    );
  }
}
