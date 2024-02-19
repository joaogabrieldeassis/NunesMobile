import 'package:appcaixa/Models/Produto.dart';

class PedidoService {
  final List<Produto> produtosInializados = Produto.iniciarProdutos();

  void EncontrarProduto(double numero) {
    var produto =
        produtosInializados.firstWhere((produto) => produto.numero == numero);
    print(produto.nome);
  }
}
