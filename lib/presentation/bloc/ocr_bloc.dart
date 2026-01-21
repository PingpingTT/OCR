import 'package:flutter_bloc/flutter_bloc.dart';
import 'ocr_event.dart';
import 'ocr_state.dart';
import 'package:project_ocr/domin/usecase/scan_usecase.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final ScanIdCardUsecase scanUsecase;

  OcrBloc(this.scanUsecase) : super(OcrInitial()) {
    on<ScanIdCardEvent>(_onScan);
  }

  Future<void> _onScan(
    ScanIdCardEvent event,
    Emitter<OcrState> emit,
  ) async {
    emit(OcrLoading());

    try {
      final result = await scanUsecase(event.image);

      if (result == null) {
        emit(OcrError("ไม่พบข้อมูลจากบัตรประชาชน"));
      } else {
        emit(OcrLoaded(result));
      }
    } catch (e) {
      emit(OcrError(e.toString()));
    }
  }
}
