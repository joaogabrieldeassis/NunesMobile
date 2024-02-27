import 'dart:convert';

import 'package:appcaixa/Models/Produto.dart';
import 'package:appcaixa/Models/ProdutoNota.dart';
import 'package:appcaixa/Service/pedidoService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//main() => runApp(const DataTableExampleApp());
main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IniciarApp('Nunes'),
    );
  }
}

class IniciarApp extends StatefulWidget {
  const IniciarApp(this.title);

  final String title;

  @override
  State<IniciarApp> createState() => MyHomePage();
}

class MyHomePage extends State<IniciarApp> {
  final PedidoService produtosService = PedidoService();
  final textNumeroDoProduto = TextEditingController();
  final textQuantidade = TextEditingController();
  double numeroDoProduto = 0;
  double quantidade = 0;
  int itensAdicionados = 0;
  final produtoNota = <ProdutoNota>[];

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DataTableExample(produtoNota)),
                              );
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
                              quantidade = double.parse(newValue),
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
                                BuscarNumero();
                              } else {
                                _showDialog("Digite um numero corretamente",
                                    "Por favor digite novamente");
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
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          LimparCarrinho();
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0),
                        ),
                        child: Text(
                          'Limpar carrinho',
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
            ),
          ],
        ));
  }

  void _incrementCounter() {
    setState(() {
      itensAdicionados++;
    });
  }

  void _showDialog(String title, String subtitle) {
    textNumeroDoProduto.clear();
    textQuantidade.clear();
    quantidade = 0;
    numeroDoProduto = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(subtitle),
          actions: <Widget>[
            // define os botões na base do dialogo
            new TextButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void BuscarNumero() {
    var produto = produtosService.EncontrarProduto(numeroDoProduto);
    if (produto == null) {
      _showDialog("O produto não foi encontrado", "Por favor digite novamente");
    } else {
      _incrementCounter();
      RealizarCalculoDoProduto(produto as Produto);
    }
    textNumeroDoProduto.clear();
    textQuantidade.clear();
    quantidade = 0;
    numeroDoProduto = 0;
  }

  void RealizarCalculoDoProduto(Produto produto) {
    double valorTotal = quantidade != null ? produto.preco * quantidade : 0;
    produtoNota.add(new ProdutoNota(
        produto.nome, produto.preco, produto.numero, valorTotal, quantidade));
  }

  void LimparCarrinho() {
    setState(() {
      itensAdicionados = 0;
    });
    produtoNota.clear();
  }
}

// class DataTableExampleApp extends StatelessWidget {
//   final List<ProdutoNota> produtoNota;
//   const DataTableExampleApp({required this.produtoNota});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('DataTable Sample')),
//         body: const DataTableExample(produtoNota: produtoNota),
//       ),
//     );
//   }
// }

class DataTableExample extends StatelessWidget {
  final List<ProdutoNota> produtoNota;

  const DataTableExample(this.produtoNota);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('DataTable Sample')),
          body: ListView(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExpensesApp()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 1.0),
                ),
                child: Text(
                  'Voltar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.purple,
                  ),
                ),
              ),
              DataTable(
                columns: [
                  DataColumn(label: Text('Qtd')),
                  DataColumn(label: Text('N')),
                  DataColumn(label: Text('\$')),
                  DataColumn(label: Text('T\$')),
                  DataColumn(label: Text('A')),
                ],
                rows: produtoNota
                    .map((produto) => DataRow(
                          cells: [
                            DataCell(
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Text(produto.numero.toString()),
                              ),
                            ),
                            DataCell(
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: Text(produto.numero
                                    .toString()), // Suponho que 'dadosN' seja um atributo do produto
                              ),
                            ),
                            DataCell(
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: Text(produto.numero
                                    .toString()), // Suponho que 'dadosD' seja um atributo do produto
                              ),
                            ),
                            DataCell(
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Text(produto.numero
                                    .toString()), // Suponho que 'dadosT' seja um atributo do produto
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(20, 20),
                                  side: BorderSide(
                                      width: 0.2, color: Colors.blue),
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 61, 61),
                                ),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'X',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 7, 24, 41),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),

              Divider(), // Adiciona uma linha separadora
              // Adicione mais DataTables ou outros widgets abaixo desta linha, se necessário
            ],
          )),
    );
  }
}
