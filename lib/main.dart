import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:project_ocr/data/repository/ocr_repository_impl.dart';
import 'package:project_ocr/data/service/idcard_servidce.dart';
import 'package:project_ocr/domin/usecase/scan_usecase.dart';
import 'package:project_ocr/presentation/bloc/ocr_bloc.dart';
import 'package:project_ocr/presentation/page/ocr.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => OcrBloc(
        ScanIdCardUsecase(
          OcrRepositoryImpl(
            OcrRemoteDatasource(client: http.Client()),
          ),
        ),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Autofill(),
      ),
    ),
  );
}

