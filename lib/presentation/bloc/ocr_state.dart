import 'package:project_ocr/domin/entity/id_entity.dart';

abstract class OcrState {}

class OcrInitial extends OcrState {}

class OcrLoading extends OcrState {}

class OcrLoaded extends OcrState {
  final IdEntity model;
  OcrLoaded(this.model);
}

class OcrError extends OcrState {
  final String message;
  OcrError(this.message);
}
