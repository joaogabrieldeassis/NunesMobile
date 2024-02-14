import 'package:appcaixa/Models/Produto.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Produto> produtosInializados = Produto.iniciarProdutos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nunes-Caixa'),
      ),
      body: Row(children: <Widget>[
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            //<-- VEJA AQUI
            side: BorderSide(
              width: 1.0,
            ),
          ),
          child: Text('Adicionar'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            //<-- VEJA AQUI
            side: BorderSide(
              width: 1.0,
            ),
          ),
          child: Text('Limpar'),
        ),
        
      ]),
    );
  }
}
