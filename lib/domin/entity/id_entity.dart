class IdEntity {
  final int idNumber;
  final String titleNameSurnameTh;
  final String titleNameEn;
  final String surnameEn;
  final String dobTh;
  final String dobEn;
  final String addressFull;
  final String doith;

  IdEntity({
    required this.idNumber,
    required this.titleNameSurnameTh,
    required this.titleNameEn,
    required this.surnameEn,
    required this.dobTh,
    required this.dobEn,
    required this.addressFull,
    required this.doith,
  });
  factory IdEntity.empty(){
    return IdEntity(
      idNumber:0,
      titleNameSurnameTh:'',
      titleNameEn:'',
      surnameEn:'',
      dobTh:'',
      dobEn:'',
      addressFull:'',
      doith:'',
    );
  }
}