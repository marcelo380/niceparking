class ParkingModel {
  int? codigo;
  int? numVaga;
  String? responsavel;
  String? dataEntrada;
  String? dataSaida;
  bool? empty;

  ParkingModel(
      {this.codigo,
      this.numVaga,
      this.responsavel,
      this.dataEntrada,
      this.dataSaida,
      this.empty = true});

  factory ParkingModel.fromMap(Map<dynamic, dynamic> json) => ParkingModel(
        codigo: json["CODIGO"],
        numVaga: json["NUM_VAGA"],
        responsavel: json["RESPONSAVEL"],
        dataEntrada: json["DATA_ENTRADA"],
        dataSaida: json["DATA_SAIDA"],
      );

  Map<String, dynamic> toMap() => {
        "CODIGO": codigo,
        "NUM_VAGA": numVaga,
        "RESPONSAVEL": responsavel,
        "DATA_ENTRADA": dataEntrada,
        "DATA_SAIDA": dataSaida,
      };
}
