import 'package:flutter/material.dart';
import 'class/Ressources.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ressources relationnelles select',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ressources relationnelles select'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Ressources> items = [];
  int counter = 0;
  final dio = Dio();

  @override
  void initState() {
    fetchRessources();
    super.initState();
  }

  void fetchRessources() async {
    List<Ressources> lesRessources = [];
    final response = await dio.get('http://localhost:5083/api/Ressources');
    response.data.forEach((data) {
      final Ressources ressource = Ressources(
          id_ressource: data["id_ressource"] ?? 0,
          titre: data["titre"].toString(),
          langue_nom: data["langue_nom"].toString(),
          date_moderation: data["date_moderation"].toString(),
          validation_moderation:
              (data["validation_moderation"] == 0 ? false : true),
          description: data["description"].toString(),
          age_minimum: data["age_minimum"] ?? 0,
          compteur_vue: data["compteur_vue"] ?? 0);

      lesRessources.add(ressource);
    });

    setState(() {
      items = lesRessources;
    });
  }

  void orderbydesc() async {
    setState(() {
      if (counter % 2 == 0) {
        items.sort((a, b) => b.titre.compareTo(a.titre));
        counter++;
      } else {
        items.sort((a, b) => a.titre.compareTo(b.titre));
        counter++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].titre),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          orderbydesc();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
