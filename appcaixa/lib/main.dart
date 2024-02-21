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
      home: IniciarApp(),
    );
  }
}

class IniciarApp extends StatefulWidget {
  const IniciarApp({super.key, required this.title});

  final String title;

  @override
  State<IniciarApp> createState() => MyHomePage();
}

class MyHomePage extends State<IniciarApp> {
  final PedidoService produtosService = PedidoService();
  final textNumeroDoProduto = TextEditingController();
  final textQuantidade = TextEditingController();
  double numeroDoProduto = 0;
  double? quantidade = 0;
  int itensAdicionados = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nunes-Caixa'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              elevation: 0,
              child: Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(children: <Widget>[
                          IconButton(
                            onPressed: () {
                              // Coloque aqui o código para executar quando o botão for pressionado.
                            },
                            icon: Image.asset(
                              'assets/carrinho.png', // Caminho para a imagem dentro do diretório 'assets' do seu projeto
                              width: 40, // Largura da imagem
                              height: 40, // Altura da imagem
                            ),
                            // Estilize conforme necessário
                            style: ElevatedButton.styleFrom(
                              // Cor do texto do botão
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Text(itensAdicionados.toString())
                        ])
                      ]),
                  SizedBox(height: 100),
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
                                _incrementCounter;
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      itensAdicionados++;
    });
  }
}
