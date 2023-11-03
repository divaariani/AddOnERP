import 'dart:convert';

class CustomerModel {
    final String nomorCo;
    final String namabarang;
    final String qtyorder;
    final String noStage;
    final String stageName;
    final dynamic createdate;

    CustomerModel({
        required this.nomorCo,
        required this.namabarang,
        required this.qtyorder,
        required this.noStage,
        required this.stageName,
        required this.createdate,
    });

    factory CustomerModel.fromRawJson(String str) => CustomerModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        nomorCo: json["nomor_co"],
        namabarang: json["namabarang"],
        qtyorder: json["qtyorder"],
        noStage: json["no_stage"],
        stageName: json["stage_name"],
        createdate: json["createdate"],
    );

    Map<String, dynamic> toJson() => {
        "nomor_co": nomorCo,
        "namabarang": namabarang,
        "qtyorder": qtyorder,
        "no_stage": noStage,
        "stage_name": stageName,
        "createdate": createdate,
    };
}
