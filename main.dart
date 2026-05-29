import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  final sovellus = MaterialApp(home: Vitsit());
  runApp(sovellus);
}

class Vitsit extends StatefulWidget {
  @override
  State<Vitsit> createState() => VitsitState();
}

class VitsitState extends State<Vitsit> {
  String setup = '';
  String punchline = '';

  Future<void> haeVitsi() async {
    final url = Uri.parse('https://simple-joke-api.deno.dev/random');
    final response = await get(url);
    final sanakirja = jsonDecode(response.body);
    final vitsi = Vitsi.sanakirjasta(sanakirja);

    setState(() {
      setup = vitsi.setup;
      punchline = vitsi.punchline;
    });
  }

  @override
  Widget build(BuildContext context) {
    final nappi = ElevatedButton(
      onPressed: haeVitsi,
      child: Text('Heh?'),
    );
    final sarake = Column(children: [Text(setup), Text(punchline), nappi]);
    return Scaffold(body: sarake);
  }
}

class Vitsi {
   late String setup;
   late String punchline;

  Vitsi(this.setup, this.punchline);
  Vitsi.sanakirjasta(sanakirja) {
    this.setup = sanakirja['setup'];
    this.punchline = sanakirja['punchline'];
  }
}