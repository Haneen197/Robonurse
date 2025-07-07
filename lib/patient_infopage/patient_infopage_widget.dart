import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'patient_infopage_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'patient_infopage_model.dart';

class PatientInfopageWidget extends StatefulWidget {
  const PatientInfopageWidget({super.key});

  static String routeName = 'patient_infopage';
  static String routePath = '/patientInfopage';

  @override
  State<PatientInfopageWidget> createState() => _PatientInfopageWidgetState();
}

class _PatientInfopageWidgetState extends State<PatientInfopageWidget> {
  late PatientInfopageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PatientInfopageModel());

    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.ageTextController ??= TextEditingController();
    _model.ageFocusNode ??= FocusNode();

    _model.primaryDiagnosisTextController ??= TextEditingController();
    _model.primaryDiagnosisFocusNode ??= FocusNode();

    _model.secondaryDiagnosisTextController ??= TextEditingController();
    _model.secondaryDiagnosisFocusNode ??= FocusNode();
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
            'Edit Patient Info',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: StreamBuilder<List<UserInfoRecord>>(
            stream: queryUserInfoRecord(
              queryBuilder: (userInfoRecord) => userInfoRecord.where(
                'uid',
                isEqualTo: currentUserUid,
              ),
              singleRecord: true,
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

              final userInfo = snapshot.data!.isNotEmpty 
                  ? snapshot.data!.first 
                  : null;

              // Initialize controllers with current data
              if (userInfo != null) {
                _model.nameTextController.text = userInfo.displayName ?? '';
                _model.ageTextController.text = userInfo.age?.toString() ?? '';
                _model.primaryDiagnosisTextController.text = userInfo.primaryDiagnosis ?? '';
                _model.secondaryDiagnosisTextController.text = userInfo.secondaryDiagnosis ?? '';
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Patient Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Update your personal and medical information below.',
                      style: TextStyle(
                        color: Color(0xFF74F958),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 32),

                    // Name Field
                    Text(
                      'Full Name:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _model.nameTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
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
                        prefixIcon: Icon(Icons.person, color: Color(0xFF74F958)),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Age Field
                    Text(
                      'Age:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _model.ageTextController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your age',
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
                        prefixIcon: Icon(Icons.cake, color: Color(0xFF74F958)),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Primary Diagnosis Field
                    Text(
                      'Primary Diagnosis:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _model.primaryDiagnosisTextController,
                      style: TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter your primary diagnosis',
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
                        prefixIcon: Icon(Icons.medical_services, color: Color(0xFF74F958)),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Secondary Diagnosis Field
                    Text(
                      'Secondary Diagnosis:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _model.secondaryDiagnosisTextController,
                      style: TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter your secondary diagnosis (optional)',
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
                        prefixIcon: Icon(Icons.medical_information, color: Color(0xFF74F958)),
                      ),
                    ),
                    SizedBox(height: 32),

                    // Save Button
                    FFButtonWidget(
                      onPressed: isLoading ? null : () async {
                        if (_model.nameTextController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter your name'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        try {
                          // Update user info in Firestore
                          await FirebaseFirestore.instance
                              .collection('user_info')
                              .doc(currentUserUid)
                              .set({
                            'display_name': _model.nameTextController.text,
                            'age': int.tryParse(_model.ageTextController.text),
                            'primary_diagnosis': _model.primaryDiagnosisTextController.text,
                            'secondary_diagnosis': _model.secondaryDiagnosisTextController.text,
                            'uid': currentUserUid,
                            'updated_time': FieldValue.serverTimestamp(),
                          }, SetOptions(merge: true));

                          // Also update the user's display name in Firebase Auth
                          await FirebaseAuth.instance.currentUser?.updateDisplayName(_model.nameTextController.text);

                          setState(() {
                            isLoading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Information updated successfully!'),
                              backgroundColor: Color(0xFF74F958),
                            ),
                          );

                          context.pop();
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error updating information: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      text: isLoading ? 'Saving...' : 'Save Changes',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        color: isLoading 
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
              );
            },
          ),
        ),
      ),
    );
  }
}
