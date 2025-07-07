import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/med_list_day_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'medicationlist_model.dart';
export 'medicationlist_model.dart';

class MedicationlistWidget extends StatefulWidget {
  const MedicationlistWidget({super.key});

  static String routeName = 'Medicationlist';
  static String routePath = '/medicationlist';

  @override
  State<MedicationlistWidget> createState() => _MedicationlistWidgetState();
}

class _MedicationlistWidgetState extends State<MedicationlistWidget> {
  late MedicationlistModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MedicationlistModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            'All medications',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(PatientPageWidget.routeName);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: StreamBuilder<List<MedicationsRecord>>(
              stream: queryMedicationsRecord(
                queryBuilder: (medicationsRecord) => medicationsRecord.where(
                  'uid',
                  isEqualTo: currentUserUid,
                ),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<MedicationsRecord> columnMedicationsRecordList =
                    snapshot.data!;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(columnMedicationsRecordList.length,
                          (columnIndex) {
                    final columnMedicationsRecord =
                        columnMedicationsRecordList[columnIndex];
                    return ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        MedListDayWidget(
                          key: Key(
                              'Key9e5_${columnIndex}_of_${columnMedicationsRecordList.length}'),
                          medName: columnMedicationsRecord.medName,
                          completed: columnMedicationsRecord.completed,
                          dose: columnMedicationsRecord.dose,
                          timing: columnMedicationsRecord.timing,
                        ),
                      ],
                    );
                  })
                      .divide(SizedBox(height: 16.0))
                      .addToStart(SizedBox(height: 60.0)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
