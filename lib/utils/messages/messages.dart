import 'package:sqflite/sqlite_api.dart';

mensagemErro(String mensagem, DatabaseException error) {
  var result = {
    'sucesso': false,
    'mensagem': mensagem,
    'debug': error.toString()
  };

  return result;
}

mensagemSucesso(String mensagem) => {
      'sucesso': true,
      'mensagem': mensagem,
    };
