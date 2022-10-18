import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map> _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  late String resultado;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:

          case ConnectionState.waiting:
            print("conexão waiting");
            resultado = "Carregando...";
            break;
          case ConnectionState.active:
            print("conexão active");
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              resultado = "Erro ao carregar os dados.";
            } else {
              double valor = snapshot.data!["BRL"]["buy"];
              resultado = "Preço do bitcoin: ${valor.toString()}";
            }
            print("conexão done");
            break;
        }
        return Center(
          child: Text(resultado),
        );
      },
    );
  }
}
