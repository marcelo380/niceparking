import 'package:sqflite/sqlite_api.dart';

ReturnMessage returnError(String message, {DatabaseException? error}) {
  var result = ReturnMessage(false, message, null);
  return result;
}

ReturnMessage returnSucess(String message, {dynamic data}) =>
    ReturnMessage(true, message, data);

class ReturnMessage {
  bool sucess;
  String message;
  dynamic data;
  ReturnMessage(this.sucess, this.message, this.data);
}
