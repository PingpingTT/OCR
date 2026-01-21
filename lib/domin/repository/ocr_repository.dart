import 'dart:io';
import 'package:project_ocr/domin/entity/id_entity.dart';

abstract class OcrRepository {
  Future<IdEntity?> scanIdCard(File imageFile);
}
