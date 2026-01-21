import 'package:project_ocr/domin/entity/id_entity.dart';

class IdcardModel extends IdEntity {
  IdcardModel({
    required super.idNumber,
    required super.titleNameSurnameTh,
    required super.titleNameEn,
    required super.surnameEn,
    required super.dobTh,
    required super.dobEn,
    required super.addressFull,
    required super.doith,
});

  factory IdcardModel.fromAigenJson(Map<String, dynamic> json) {
    return IdcardModel(
      idNumber: int.tryParse(json["id_number"]?["value"]?.toString() ?? "") ?? 0,
      titleNameSurnameTh:
          json["title_name_surname_th"]?["value"]?.toString() ?? "",
      titleNameEn: json["title_name_en"]?["value"]?.toString() ?? "",
      surnameEn: json["surname_en"]?["value"]?.toString() ?? "",
      dobTh: json["dob_th"]?["value"]?.toString() ?? "",
      dobEn: json["dob_en"]?["value"]?.toString() ?? "",
      addressFull: json["address_full"]?["value"]?.toString() ?? "",
      doith: json["doi_th"]?["value"]?.toString() ?? "",
    );
  }
  IdEntity toEntity(){
    return IdEntity(
      idNumber: idNumber,
      titleNameSurnameTh: titleNameSurnameTh,
      titleNameEn: titleNameEn,
      surnameEn: surnameEn,
      dobTh: dobTh,
      dobEn: dobEn,
      addressFull:addressFull,
      doith: doith
      );
  }
}
