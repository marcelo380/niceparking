import 'package:sqflite/sqlite_api.dart';

ReturnMessage mensagemErro(String message, {DatabaseException? error}) {
  print("exception => $error");
  var result = ReturnMessage(false, message);
  return result;
}

ReturnMessage mensagemSucesso(String message) => ReturnMessage(true, message);

class ReturnMessage {
  bool sucess;
  String message;
  ReturnMessage(this.sucess, this.message);
}
