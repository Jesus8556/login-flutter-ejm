import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String token;

  HomePage(this.token);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> garages = [];

  @override
  void initState() {
    super.initState();
    fetchGarages();
  }

  Future<void> fetchGarages() async {
  final apiUrl = 'http://localhost:3000/api/garage';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'x-access-token': widget.token},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        garages = responseData.map((garage) => garage.toString()).toList();
      });
    } else {
      print('Error al obtener la lista de garages: ${response.statusCode}');
    }
  } catch (error) {
    print('Error en la solicitud HTTP: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garages'),
      ),
      body: ListView.builder(
        itemCount: garages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(garages[index]),
          );
        },
      ),
    );
  }
}
