import 'package:crud_pessoa/model/pessoa.dart';

abstract class PessoaDao {
  salvar(Pessoa pessoa);
  consultar(int id);
  excluir(int id);
  Future<List<Map<String, Object?>>> listarTodos();
}
