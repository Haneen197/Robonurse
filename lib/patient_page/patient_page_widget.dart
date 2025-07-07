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
import 'package:fl_chart/fl_chart.dart';
import 'patient_page_model.dart';
export 'patient_page_model.dart';

class PatientPageWidget extends StatefulWidget {
  const PatientPageWidget({super.key});

  static String routeName = 'Patient_page';
  static String routePath = '/patientPage';

  @override
  State<PatientPageWidget> createState() => _PatientPageWidgetState();
}

class _PatientPageWidgetState extends State<PatientPageWidget> {
  late PatientPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PatientPageModel());
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
                      currentUserDocument?.displayName ?? 'Patient',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Patient',
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
                    // Patient Info Tab
                    ListTile(
                      leading: Icon(Icons.person, color: Color(0xFF74F958)),
                      title: Text(
                        'Patient Info',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        context.pushNamed('patient_infopage');
                      },
                    ),
                    // Help Tab
                    ListTile(
                      leading: Icon(Icons.help, color: Color(0xFF74F958)),
                      title: Text(
                        'Help',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        context.pushNamed('info');
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
          iconTheme: IconThemeData(color: Color(0xFF74F958)),
          title: Text(
            'Patient Dashboard',
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
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Info Card
                StreamBuilder<List<UserInfoRecord>>(
                  stream: queryUserInfoRecord(
                    queryBuilder: (userInfoRecord) => userInfoRecord.where(
                      'uid',
                      isEqualTo: currentUserUid,
                    ),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Card(
                        color: Color(0xFF2A2A2A),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF74F958),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    final userInfo = snapshot.data!.isNotEmpty 
                        ? snapshot.data!.first 
                        : null;

                    return Card(
                      color: Color(0xFF2A2A2A),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                        userInfo?.displayName ?? 'Patient Name',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Age: ${userInfo?.age?.toString() ?? 'N/A'}',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Primary Diagnosis:',
                              style: TextStyle(
                                color: Color(0xFF74F958),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userInfo?.primaryDiagnosis ?? 'Not specified',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Secondary Diagnosis:',
                              style: TextStyle(
                                color: Color(0xFF74F958),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userInfo?.secondaryDiagnosis ?? 'Not specified',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),

                // Medication Progress Pie Chart
                Card(
                  color: Color(0xFF2A2A2A),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medication Progress',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        StreamBuilder<List<MedicationsRecord>>(
                          stream: queryMedicationsRecord(
                            queryBuilder: (medicationsRecord) => medicationsRecord.where(
                              'uid',
                              isEqualTo: currentUserUid,
                            ),
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

                            final medications = snapshot.data!;
                            final frequencyMap = {
                              'Twice daily': 2,
                              'Three times daily': 3,
                            };

                            // Expand medications list according to frequency
                            List<MedicationsRecord> expandedMedications = [];
                            for (final med in medications) {
                              final count = frequencyMap[med.timing] ?? 1;
                              for (int i = 0; i < count; i++) {
                                expandedMedications.add(med);
                              }
                            }

                            final totalMedications = expandedMedications.length;
                            final completedMedications = expandedMedications.where((med) => med.completed).length;
                            final pendingMedications = totalMedications - completedMedications;

                            if (totalMedications == 0) {
                              return Container(
                                height: 200,
                                child: Center(
                                  child: Text(
                                    'No medications assigned yet',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }

                            return Container(
                              height: 200,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: PieChart(
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            value: completedMedications.toDouble(),
                                            title: 'Completed\n$completedMedications',
                                            color: Color(0xFF74F958),
                                            radius: 60,
                                            titleStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          PieChartSectionData(
                                            value: pendingMedications.toDouble(),
                                            title: 'Pending\n$pendingMedications',
                                            color: Color(0xFFCC5629),
                                            radius: 60,
                                            titleStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                        centerSpaceRadius: 40,
                                        sectionsSpace: 2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF74F958),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Completed',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFCC5629),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Pending',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          'Total: $totalMedications',
                                          style: TextStyle(
                                            color: Color(0xFF74F958),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
                ),
                SizedBox(height: 20),

                // Medication Todo List
                Card(
                  color: Color(0xFF2A2A2A),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Medication Todo List',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.medication,
                              color: Color(0xFF74F958),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        StreamBuilder<List<MedicationsRecord>>(
                          stream: queryMedicationsRecord(
                            queryBuilder: (medicationsRecord) => medicationsRecord.where(
                              'uid',
                              isEqualTo: currentUserUid,
                            ),
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

                            final medications = snapshot.data!;
                            final frequencyMap = {
                              'Twice daily': 2,
                              'Three times daily': 3,
                            };

                            // Expand medications list according to frequency
                            List<MedicationsRecord> expandedMedications = [];
                            for (final med in medications) {
                              final count = frequencyMap[med.timing] ?? 1;
                              for (int i = 0; i < count; i++) {
                                expandedMedications.add(med);
                              }
                            }

                            if (expandedMedications.isEmpty) {
                              return Container(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    'No medications assigned yet',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: expandedMedications.length,
                              itemBuilder: (context, index) {
                                final medication = expandedMedications[index];
                                return Card(
                                  margin: EdgeInsets.only(bottom: 8),
                                  color: medication.completed 
                                      ? Color(0xFF1E1E1E) 
                                      : Color(0xFF3A3A3A),
                                  child: ListTile(
                                    leading: Icon(
                                      medication.completed 
                                          ? Icons.check_circle 
                                          : Icons.radio_button_unchecked,
                                      color: medication.completed 
                                          ? Color(0xFF74F958) 
                                          : Colors.white70,
                                    ),
                                    title: Text(
                                      medication.medName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: medication.completed 
                                            ? TextDecoration.lineThrough 
                                            : null,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dose: ${medication.dose}',
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                          'Timing: ${medication.timing}',
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        medication.completed 
                                            ? Icons.undo 
                                            : Icons.check,
                                        color: Color(0xFF74F958),
                                      ),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('medications')
                                            .doc(medication.reference.id)
                                            .update({
                                          'completed': !medication.completed,
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
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
