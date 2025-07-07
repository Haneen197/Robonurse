import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'info_widget.dart' show InfoWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InfoModel extends FlutterFlowModel<InfoWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for primary_diagnosis widget.
  FocusNode? primaryDiagnosisFocusNode;
  TextEditingController? primaryDiagnosisTextController;
  String? Function(BuildContext, String?)?
      primaryDiagnosisTextControllerValidator;
  // State field(s) for Secondary_diagnosis widget.
  FocusNode? secondaryDiagnosisFocusNode;
  TextEditingController? secondaryDiagnosisTextController;
  String? Function(BuildContext, String?)?
      secondaryDiagnosisTextControllerValidator;
  // State field(s) for Age widget.
  FocusNode? ageFocusNode;
  TextEditingController? ageTextController;
  String? Function(BuildContext, String?)? ageTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    primaryDiagnosisFocusNode?.dispose();
    primaryDiagnosisTextController?.dispose();

    secondaryDiagnosisFocusNode?.dispose();
    secondaryDiagnosisTextController?.dispose();

    ageFocusNode?.dispose();
    ageTextController?.dispose();
  }
}
