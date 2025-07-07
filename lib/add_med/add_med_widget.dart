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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_med_model.dart';
import 'package:flutter/services.dart';
export 'add_med_model.dart';

class AddMedWidget extends StatefulWidget {
  const AddMedWidget({super.key});

  static String routeName = 'AddMed';
  static String routePath = '/addMed';

  @override
  State<AddMedWidget> createState() => _AddMedWidgetState();
}

class _AddMedWidgetState extends State<AddMedWidget> {
  late AddMedModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedPatientId;
  String? selectedPatientName;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddMedModel());

    _model.medNameTextController ??= TextEditingController();
    _model.medNameFocusNode ??= FocusNode();

    _model.doseTextController ??= TextEditingController();
    _model.doseFocusNode ??= FocusNode();
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
          iconTheme: IconThemeData(color: Color(0xFF74F958)),
          title: Text(
            'Add Medication',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Medication',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Fill out the form below to assign medication to a patient.',
                  style: TextStyle(
                    color: Color(0xFF74F958),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 32),

                // Patient Selection
                StreamBuilder<List<UserInfoRecord>>(
                  stream: queryUserInfoRecord(
                    queryBuilder: (userInfoRecord) => userInfoRecord,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF74F958),
                          ),
                        ),
                      );
                    }

                    final patients = snapshot.data!;

                    if (patients.isEmpty) {
                      return Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'No patients found. Please register patients first.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Patient:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xFF74F958)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedPatientId,
                              hint: Text(
                                'Choose a patient...',
                                style: TextStyle(color: Colors.white70),
                              ),
                              dropdownColor: Color(0xFF2A2A2A),
                              style: TextStyle(color: Colors.white),
                              icon: Icon(Icons.arrow_drop_down, color: Color(0xFF74F958)),
                              items: patients.map((patient) {
                                return DropdownMenuItem<String>(
                                  value: patient.uid,
                                  child: Text(
                                    '${patient.displayName} (Age: ${patient.age ?? 'N/A'})',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedPatientId = value;
                                  selectedPatientName = patients
                                      .firstWhere((p) => p.uid == value)
                                      .displayName;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 24),

                // Medication Name
                Text(
                  'Medication Name:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _model.medNameTextController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter medication name',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF2A2A2A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF74F958)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF74F958)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF74F958), width: 2),
                    ),
                    prefixIcon: Icon(Icons.medication, color: Color(0xFF74F958)),
                  ),
                ),
                SizedBox(height: 16),

                // Dose
                Text(
                  'Dose:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _model.doseTextController,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*')),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter dose (e.g., 10)',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF2A2A2A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF74F958)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF74F958)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF74F958), width: 2),
                    ),
                    prefixIcon: Icon(Icons.scale, color: Color(0xFF74F958)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a dose';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Dose must be a number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Frequency
                Text(
                  'Frequency:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF74F958)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _model.dropDownValue,
                      hint: Text(
                        'Select frequency...',
                        style: TextStyle(color: Colors.white70),
                      ),
                      dropdownColor: Color(0xFF2A2A2A),
                      style: TextStyle(color: Colors.white),
                      icon: Icon(Icons.arrow_drop_down, color: Color(0xFF74F958)),
                      items: ['Morning', 'Afternoon', 'Evening', 'Night', 'Twice daily', 'Three times daily']
                          .map((frequency) {
                        return DropdownMenuItem<String>(
                          value: frequency,
                          child: Text(
                            frequency,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _model.dropDownValue = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32),

                // Save Button
                FFButtonWidget(
                  onPressed: selectedPatientId == null || 
                             _model.medNameTextController.text.isEmpty ||
                             _model.doseTextController.text.isEmpty ||
                             _model.dropDownValue == null
                      ? null
                      : () async {
                          if (selectedPatientId == null || selectedPatientId!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please select a valid patient.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          print('Assigning medication to patient UID: ' + selectedPatientId!);
                          try {
                            final medName = _model.medNameTextController.text;
                            final dose = double.tryParse(_model.doseTextController.text) ?? 0.0;
                            print('Saving dose: ' + dose.toString());
                            if (dose == 0.0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Dose must be a valid number greater than zero.')),
                              );
                              return;
                            }
                            final frequency = _model.dropDownValue;
                            final timingMap = {
                              'Twice daily': ['Morning', 'Evening'],
                              'Three times daily': ['Morning', 'Afternoon', 'Night'],
                            };
                            final timings = timingMap[frequency] ?? (frequency != null ? [frequency] : ['Other']);
                            for (final timing in timings) {
                              await MedicationsRecord.collection.doc().set(
                                createMedicationsRecordData(
                                  uid: selectedPatientId,
                                  medName: medName,
                                  dose: dose,
                                  completed: false,
                                  timing: timing,
                                ),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Medication added successfully!'),
                                backgroundColor: Color(0xFF74F958),
                              ),
                            );
                            context.pop();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error adding medication: ${e.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  text: 'Save Medication',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: selectedPatientId == null || 
                           _model.medNameTextController.text.isEmpty ||
                           _model.doseTextController.text.isEmpty ||
                           _model.dropDownValue == null
                        ? Color(0xFF74F958).withOpacity(0.5)
                        : Color(0xFF74F958),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
