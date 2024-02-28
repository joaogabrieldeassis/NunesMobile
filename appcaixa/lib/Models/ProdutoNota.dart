import 'package:uuid/uuid.dart';

class ProdutoNota {
  String nome = '';
  double preco = 0;
  double numero = 0;
  double precoTotal = 0;
  double quantidade = 0;
  String Id = Uuid().v1();
  ProdutoNota(this.nome, this.preco, this.numero, this.precoTotal, this.quantidade);
}
