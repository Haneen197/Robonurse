import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'add_med_widget.dart' show AddMedWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddMedModel extends FlutterFlowModel<AddMedWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for MedName widget.
  FocusNode? medNameFocusNode;
  TextEditingController? medNameTextController;
  String? Function(BuildContext, String?)? medNameTextControllerValidator;
  // State field(s) for Dose widget.
  FocusNode? doseFocusNode;
  TextEditingController? doseTextController;
  String? Function(BuildContext, String?)? doseTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    medNameFocusNode?.dispose();
    medNameTextController?.dispose();

    doseFocusNode?.dispose();
    doseTextController?.dispose();
  }
}
