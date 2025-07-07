import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/med_list_day_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'patient_infopage_widget.dart' show PatientInfopageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PatientInfopageModel extends FlutterFlowModel<PatientInfopageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;

  TextEditingController? nameTextController;
  FocusNode? nameFocusNode;

  TextEditingController? ageTextController;
  FocusNode? ageFocusNode;

  TextEditingController? primaryDiagnosisTextController;
  FocusNode? primaryDiagnosisFocusNode;

  TextEditingController? secondaryDiagnosisTextController;
  FocusNode? secondaryDiagnosisFocusNode;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    textFieldFocusNode6?.dispose();
    textController6?.dispose();

    nameTextController?.dispose();
    nameFocusNode?.dispose();

    ageTextController?.dispose();
    ageFocusNode?.dispose();

    primaryDiagnosisTextController?.dispose();
    primaryDiagnosisFocusNode?.dispose();

    secondaryDiagnosisTextController?.dispose();
    secondaryDiagnosisFocusNode?.dispose();
  }
}
