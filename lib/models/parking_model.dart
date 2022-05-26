class ParkingModel {
  int? codigo;
  int? numVaga;
  String? placa;
  String? dataEntrada;
  String? dataSaida;
  bool? empty;

  ParkingModel(
      {this.codigo,
      this.numVaga,
      this.placa,
      this.dataEntrada,
      this.dataSaida,
      this.empty = true});

  factory ParkingModel.fromMap(Map<dynamic, dynamic> json) => ParkingModel(
        codigo: json["CODIGO"],
        numVaga: json["NUM_VAGA"],
        placa: json["PLACA"],
        dataEntrada: json["DATA_ENTRADA"],
        dataSaida: json["DATA_SAIDA"],
      );

  Map<String, dynamic> toMap() => {
        "CODIGO": codigo,
        "NUM_VAGA": numVaga,
        "PLACA": placa,
        "DATA_ENTRADA": dataEntrada,
        "DATA_SAIDA": dataSaida,
      };
}
