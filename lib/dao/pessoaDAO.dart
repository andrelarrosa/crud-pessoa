import 'package:crud_pessoa/connection/sqlite/connection.dart';
import 'package:crud_pessoa/model/pessoa.dart';
import 'package:sqflite/sqflite.dart';

class PessoaDao {
  Future<bool> salvar(Pessoa pessoa) async {
    Database db = await Connection.abrirConexao();
    const sql = 'INSERT INTO pessoa (nome, celular) VALUES (?, ?)';
    var linhasAfetadas = await db.rawInsert(sql, [pessoa.nome, pessoa.celular]);
    return linhasAfetadas > 0;
  }

  Future<Pessoa> consultar(int id) async {
    late Database db;
    try {
      const sql = "SELECT * FROM pessoa WHERE id=?";
      db = await Connection.abrirConexao();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [id])).first;
      if (resultado.isEmpty) throw Exception('Sem registros com este id');
      Pessoa pessoa = Pessoa(
          id: resultado['id'] as int,
          nome: resultado['nome'].toString(),
          celular: resultado['celular'].toString());
      return pessoa;
    } catch (e) {
      throw Exception('classe PessoaDao, método consultar');
    } finally {
      db.close();
    }
  }

  Future<bool> excluir(int id) async {
    late Database db;
    try {
      const sql = 'DELETE FROM pessoa WHERE id = ?';
      db = await Connection.abrirConexao();
      int linhasAfetadas = await db.rawDelete(sql, [id]);
      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('classe PessoaDAO, método excluir');
    } finally {
      db.close();
    }
  }

  @override
  Future<List<Map<String, Object?>>> listarTodos() async {
    late Database db;
    try {
      const sql = 'SELECT * FROM pessoa';
      db = await Connection.abrirConexao();
      List<Map<String, Object?>> resultado = (await db.rawQuery(sql));
      if (resultado.isEmpty) throw Exception('Sem registros');
      List<Pessoa> pessoa = resultado.map((linha) {
        return Pessoa(
            id: linha['id'] as int,
            nome: linha['nome'].toString(),
            celular: linha['celular'].toString());
      }).toList();
      return resultado;
    } catch (e) {
      throw Exception('classe PessoaDAO, método listar');
    }
  }
}
