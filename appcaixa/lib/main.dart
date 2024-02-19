import 'dart:convert';

import 'package:appcaixa/Models/Produto.dart';
import 'package:appcaixa/Service/pedidoService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final PedidoService produtosService = PedidoService();
  final textNumeroDoProduto = TextEditingController();
  final textQuantidade = TextEditingController();
  double numeroDoProduto = 0;
  double? quantidade = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nunes-Caixa'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: <Widget>[
                        TextField(
                          onChanged: (newValue) =>
                              numeroDoProduto = double.parse(newValue),
                          decoration: InputDecoration(
                            labelText: 'Numero do produto',
                          ),
                          controller: textNumeroDoProduto,
                          keyboardType: TextInputType
                              .number, // Define o tipo do teclado como numérico
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]')), // Permite apenas números
                          ],
                        ),
                        TextField(
                          onChanged: (newValue) =>
                              numeroDoProduto = double.parse(newValue),
                          controller: textQuantidade,
                          decoration: InputDecoration(
                            labelText: 'Quantidade',
                          ),
                          keyboardType: TextInputType
                              .number, // Define o tipo do teclado como numérico
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]')), // Permite apenas números
                          ],
                        ),
                      ])),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              if (numeroDoProduto != 0 &&
                                  numeroDoProduto != null) {
                                produtosService.EncontrarProduto(
                                    numeroDoProduto);
                                textNumeroDoProduto.clear();
                                textQuantidade.clear();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 0.5, color: Colors.blue),
                            ),
                            child: Text(
                              'Adicionar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.purple),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 70), // Espaço entre os botões
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              textNumeroDoProduto.clear();
                              textQuantidade.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 1.0),
                            ),
                            child: Text(
                              'Limpar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.purple),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
