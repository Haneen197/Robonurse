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
import 'info_model.dart';
export 'info_model.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key});

  static String routeName = 'info';
  static String routePath = '/info';

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  late InfoModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoModel());
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
            'Help & Instructions',
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
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFF74F958)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 60,
                        color: Color(0xFF74F958),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Welcome to Robonurse',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Your healthcare management companion',
                        style: TextStyle(
                          color: Color(0xFF74F958),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // For Patients Section
                _buildSection(
                  title: 'For Patients',
                  icon: Icons.person,
                  items: [
                    _buildInstructionItem(
                      icon: Icons.dashboard,
                      title: 'Dashboard',
                      description: 'View your personal information, medication progress, and todo list on the main dashboard.',
                    ),
                    _buildInstructionItem(
                      icon: Icons.pie_chart,
                      title: 'Progress Tracking',
                      description: 'Monitor your medication adherence with the interactive pie chart showing completed vs pending medications.',
                    ),
                    _buildInstructionItem(
                      icon: Icons.checklist,
                      title: 'Medication Todo List',
                      description: 'Mark medications as completed by tapping the check button. Completed medications will be crossed out.',
                    ),
                    _buildInstructionItem(
                      icon: Icons.edit,
                      title: 'Update Information',
                      description: 'Access the drawer menu and select "Patient Info" to update your name, age, and diagnosis information.',
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // For Doctors Section
                _buildSection(
                  title: 'For Doctors',
                  icon: Icons.medical_services,
                  items: [
                    _buildInstructionItem(
                      icon: Icons.people,
                      title: 'Patient Management',
                      description: 'View all registered patients with their basic information and medication status.',
                    ),
                    _buildInstructionItem(
                      icon: Icons.add_circle,
                      title: 'Add Medications',
                      description: 'Use the "Add Medication" button to assign new medications to patients with dosage and frequency.',
                    ),
                    _buildInstructionItem(
                      icon: Icons.medication,
                      title: 'Medication Tracking',
                      description: 'Monitor patient medication adherence through the progress indicators on each patient card.',
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // General Features Section
                _buildSection(
                  title: 'General Features',
                  icon: Icons.settings,
                  items: [
                    _buildInstructionItem(
                      icon: Icons.security,
                      title: 'Secure Authentication',
                      description: 'Your data is protected with Firebase Authentication and secure Firestore rules.',
                    ),
                    _buildInstructionItem(
                      icon: Icons.sync,
                      title: 'Real-time Updates',
                      description: 'All changes are synchronized in real-time across the application.',
                    ),
                    _buildInstructionItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      description: 'Use the logout option in the drawer menu (patients) or app bar (doctors) to securely sign out.',
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Support Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFCC5629)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Color(0xFFCC5629),
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Need Help?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'If you encounter any issues or need additional support, please contact your healthcare provider or the system administrator.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Back Button
                FFButtonWidget(
                  onPressed: () {
                    context.pop();
                  },
                  text: 'Back to Dashboard',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: Color(0xFF74F958),
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

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Color(0xFF74F958),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...items,
        ],
      ),
    );
  }

  Widget _buildInstructionItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFF74F958),
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
