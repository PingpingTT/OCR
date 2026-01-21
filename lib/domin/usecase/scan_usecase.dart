import 'dart:io';
import 'package:project_ocr/domin/entity/id_entity.dart';
import 'package:project_ocr/domin/repository/ocr_repository.dart';

class ScanIdCardUsecase {
  final OcrRepository repository;

  ScanIdCardUsecase(this.repository);

  Future<IdEntity?> call(File imageFile) {
    return repository.scanIdCard(imageFile);
  }
}
