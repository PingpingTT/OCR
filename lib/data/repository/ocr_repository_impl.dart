
import 'dart:io';
import 'package:project_ocr/data/service/idcard_servidce.dart';
import 'package:project_ocr/domin/entity/id_entity.dart';
import 'package:project_ocr/domin/repository/ocr_repository.dart';

class OcrRepositoryImpl implements OcrRepository {
  final OcrRemoteDatasource remote;

  OcrRepositoryImpl(this.remote);

  @override
  Future<IdEntity?> scanIdCard(File imageFile) {
    return remote.scan(imageFile);
  }
}
