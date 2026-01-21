import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ocr/domin/entity/id_entity.dart';
import 'package:project_ocr/presentation/bloc/ocr_bloc.dart';
import 'package:project_ocr/presentation/bloc/ocr_event.dart';
import 'package:project_ocr/presentation/bloc/ocr_state.dart';
import 'package:project_ocr/presentation/widget/elevatedbttemplate.dart';
import 'package:project_ocr/presentation/widget/fromfilltemplate.dart';

class Autofill extends StatefulWidget {
  const Autofill({super.key});

  @override
  State<Autofill> createState() => _AutofillState();
}

class _AutofillState extends State<Autofill> {
  final picker = ImagePicker();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final idCardCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      context.read<OcrBloc>().add(ScanIdCardEvent(File(file.path)));
    }
  }

  void fillForm(IdEntity idcard) {
    nameCtrl.text = idcard.titleNameSurnameTh;
    dobCtrl.text = idcard.dobTh;
    idCardCtrl.text = idcard.idNumber.toString();
    addressCtrl.text = idcard.addressFull;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    dobCtrl.dispose();
    idCardCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("OCR Project")),
        backgroundColor: const Color.fromARGB(255, 135, 213, 255),
      ),
      body: BlocListener<OcrBloc, OcrState>(
        listener: (context, state) {
          if (state is OcrLoaded) {
            fillForm(state.model);
          } else if (state is OcrError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 59, 139, 182),
                    const Color.fromARGB(255, 182, 230, 252),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Ocr Form",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  FormFillTemplate(
                    hintText: "ชื่อนามสกุล",
                    fillColor: Colors.white,
                    controller: nameCtrl,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),

                  FormFillTemplate(
                    hintText: "E-mail",
                    fillColor: Colors.white,
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  FormFillTemplate(
                    hintText: "วัน/เดือน/ปี เกิด",
                    fillColor: Colors.white,
                    controller: dobCtrl,
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 16),

                  FormFillTemplate(
                    hintText: "เลขบัตรประชาชน",
                    fillColor: Colors.white,
                    controller: idCardCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  FormFillTemplate(
                    hintText: "ที่อยู่",
                    fillColor: Colors.white,
                    controller: addressCtrl,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 24),

                  BlocBuilder<OcrBloc, OcrState>(
                    builder: (context, state) {
                      if (state is OcrLoading) {
                        return const CircularProgressIndicator();
                      }

                      return Column(
                        children: [
                          Elevatedbttemplate(
                            text: "บันทึก",
                            backgroundColor: const Color.fromARGB(255, 100, 176, 218),
                            onPressed: () {
                              nameCtrl.clear();
                              emailCtrl.clear();
                              dobCtrl.clear();
                              idCardCtrl.clear();
                              addressCtrl.clear();
                            },
                          ),
                          const SizedBox(height: 20),
                          Elevatedbttemplate(
                            text: "สแกนข้อความ",
                            backgroundColor:Color.fromARGB(255, 79, 142, 177),
                            onPressed: () => pickImage(ImageSource.camera),
                          ),
                          const SizedBox(height: 20),
                          Elevatedbttemplate(
                            text: "แกลลอรี่",
                            backgroundColor: const Color.fromARGB(255, 45, 100, 129),
                            onPressed: () => pickImage(ImageSource.gallery),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
