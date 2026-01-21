import 'dart:io';

abstract class OcrEvent {}

class ScanIdCardEvent extends OcrEvent {
  final File image;
  ScanIdCardEvent(this.image);
}
