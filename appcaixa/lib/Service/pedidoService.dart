import 'package:appcaixa/Models/Produto.dart';
import 'package:flutter/material.dart';

class PedidoService {
  final List<Produto> produtosInializados = Produto.iniciarProdutos();

  Object? EncontrarProduto(double numero) {
    if (produtosInializados.any((element) => element.numero == numero)) {
      return produtosInializados
          .firstWhere((produto) => produto.numero == numero);
    } else {
      return null;
    }
  }
}
