class ParkingModel {
  int? codigo;
  int? numVaga;
  String? responsavel;
  String? dataEntrada;
  String? dataSaida;

  ParkingModel(
      {this.codigo,
      this.numVaga,
      this.responsavel,
      this.dataEntrada,
      this.dataSaida});

  ParkingModel.fromJson(Map<String, dynamic> json) {
    codigo = json['CODIGO'];
    numVaga = json['NUM_VAGA'];
    responsavel = json['RESPONSAVEL'];
    dataEntrada = json['DATA_ENTRADA'];
    dataSaida = json['DATA_SAIDA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CODIGO'] = codigo;
    data['NUM_VAGA'] = numVaga;
    data['RESPONSAVEL'] = responsavel;
    data['DATA_ENTRADA'] = dataEntrada;
    data['DATA_SAIDA'] = dataSaida;
    return data;
  }
}
