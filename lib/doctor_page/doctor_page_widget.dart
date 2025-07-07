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
import 'doctor_page_model.dart';
export 'doctor_page_model.dart';

class DoctorPageWidget extends StatefulWidget {
  const DoctorPageWidget({super.key});

  static String routeName = 'Doctor_page';
  static String routePath = '/doctorPage';

  @override
  State<DoctorPageWidget> createState() => _DoctorPageWidgetState();
}

class _DoctorPageWidgetState extends State<DoctorPageWidget> {
  late DoctorPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DoctorPageModel());
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
        drawer: Drawer(
          backgroundColor: Color(0xFF2A2A2A),
          child: Column(
            children: [
              // Drawer Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFF74F958),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentUserDocument?.displayName ?? 'Doctor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Doctor',
                      style: TextStyle(
                        color: Color(0xFF74F958),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Help Tab
                    ListTile(
                      leading: Icon(Icons.help, color: Color(0xFF74F958)),
                      title: Text(
                        'Help',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        context.pushNamed(InfoWidget.routeName);
                      },
                    ),
                    Divider(color: Colors.white24),
                    // Logout Tab
                    ListTile(
                      leading: Icon(Icons.logout, color: Color(0xFF74F958)),
                      title: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () async {
                        await authManager.signOut();
                        Navigator.of(context).pop();
                        context.goNamed(LoginWidget.routeName, extra: {'pageKey': UniqueKey()});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Doctor Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Header with Add Medication Button
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                color: Color(0xFF1E1E1E),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Patient Management',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        context.pushNamed(AddMedWidget.routeName);
                      },
                      text: 'Add Medication',
                      icon: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                      options: FFButtonOptions(
                        width: 150,
                        height: 40,
                        color: Color(0xFF74F958),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
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
              
              // Patients List
              Expanded(
                child: StreamBuilder<List<UserInfoRecord>>(
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 80,
                              color: Colors.white70,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No patients found',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Patients will appear here once they register',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final patient = patients[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 16),
                          color: Color(0xFF2A2A2A),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Patient Header
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Color(0xFF74F958),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patient.displayName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Age: ${patient.age?.toString() ?? 'N/A'}',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Add Medication Button for this patient
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xFF74F958),
                                      ),
                                      onPressed: () {
                                        // Navigate to add medication with patient info
                                        context.pushNamed(AddMedWidget.routeName, extra: {
                                          'patientId': patient.uid,
                                          'patientName': patient.displayName,
                                        });
                                      },
                                      tooltip: 'Add Medication for ${patient.displayName}',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                
                                // Diagnosis Information
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Primary Diagnosis:',
                                            style: TextStyle(
                                              color: Color(0xFF74F958),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            patient.primaryDiagnosis ?? 'Not specified',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Secondary Diagnosis:',
                                            style: TextStyle(
                                              color: Color(0xFF74F958),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            patient.secondaryDiagnosis ?? 'Not specified',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                
                                // Patient's Medications Summary
                                StreamBuilder<List<MedicationsRecord>>(
                                  stream: queryMedicationsRecord(
                                    queryBuilder: (medicationsRecord) => medicationsRecord.where(
                                      'uid',
                                      isEqualTo: patient.uid,
                                    ),
                                  ),
                                  builder: (context, medSnapshot) {
                                    if (!medSnapshot.hasData) {
                                      return SizedBox.shrink();
                                    }

                                    final medications = medSnapshot.data!;
                                    final totalMeds = medications.length;
                                    final completedMeds = medications.where((med) => med.completed).length;

                                    return Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1E1E1E),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.medication,
                                            color: Color(0xFF74F958),
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Medications: $totalMeds total, $completedMeds completed',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Spacer(),
                                          if (totalMeds > 0)
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: completedMeds == totalMeds 
                                                    ? Color(0xFF74F958) 
                                                    : Color(0xFFCC5629),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                '${((completedMeds / totalMeds) * 100).round()}%',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
