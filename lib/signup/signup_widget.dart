import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup_model.dart';
export 'signup_model.dart';
import 'package:robonurse/patient_page/patient_page_widget.dart';
import 'package:robonurse/doctor_page/doctor_page_widget.dart';
import '/backend/schema/users_record.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  static String routeName = 'Signup';
  static String routePath = '/signup';

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  late SignupModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedRole;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignupModel());

    _model.displaNameTextController ??= TextEditingController();
    _model.displaNameFocusNode ??= FocusNode();

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.passwordConfirmTextController ??= TextEditingController();
    _model.passwordConfirmFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1E1E1E),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            padding: EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create an account',
                      style: FlutterFlowTheme.of(context).displaySmall.copyWith(
                            color: Colors.white,
                          )),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _model.displaNameTextController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Full name',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF3A3A3A),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Colors.white70),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _model.emailAddressTextController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF3A3A3A),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Colors.white70),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _model.passwordTextController,
                    style: TextStyle(color: Colors.white),
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF3A3A3A),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _model.passwordConfirmTextController,
                    style: TextStyle(color: Colors.white),
                    obscureText: !confirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF3A3A3A),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(
                          confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _model.passwordTextController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: Color(0xFF3A3A3A),
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Select Role',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF3A3A3A),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work, color: Colors.white70),
                    ),
                    value: selectedRole,
                    items: ['Patient', 'Doctor'].map((role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a role' : null,
                  ),
                  SizedBox(height: 24),
                  FFButtonWidget(
                    onPressed: isLoading ? null : () async {
                      GoRouter.of(context).prepareAuthEvent();

                      // Validate all required fields
                      if (_model.displaNameTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter your name")),
                        );
                        return;
                      }

                      if (_model.emailAddressTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter your email")),
                        );
                        return;
                      }

                      if (_model.passwordTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter a password")),
                        );
                        return;
                      }

                      if (selectedRole == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select a role")),
                        );
                        return;
                      }

                      if (_model.passwordTextController.text !=
                          _model.passwordConfirmTextController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords don't match!")),
                        );
                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      try {
                        final user = await authManager.createAccountWithEmail(
                        context,
                        _model.emailAddressTextController.text,
                        _model.passwordTextController.text,
                      );
                      if (user == null) {
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      }

                      // Wait a moment for the user to be fully authenticated
                      await Future.delayed(Duration(milliseconds: 500));

                      // Update the user's display name in Firebase Auth
                      await FirebaseAuth.instance.currentUser?.updateDisplayName(_model.displaNameTextController.text);

                      // Update user role using Cloud Function
                      try {
                        final functions = FirebaseFunctions.instance;
                        await functions.httpsCallable('updateUserRole').call({
                          'role': selectedRole,
                        });
                      } catch (e) {
                        // Fallback: create user document directly if Cloud Function fails
                        final userData = createUsersRecordData(
                          displayName: _model.displaNameTextController.text,
                          email: user.email,
                          uid: user.uid,
                          createdTime: getCurrentTimestamp,
                          patient: selectedRole == 'Patient',
                          doctor: selectedRole == 'Doctor',
                        );

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .set(userData);
                      }

                      setState(() {
                        isLoading = false;
                      });

                      // Show success message and redirect to login
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Account created successfully! Please sign in.'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Redirect to login page
                      context.goNamed(LoginWidget.routeName, extra: {'pageKey': UniqueKey()});
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error creating account: ${e.toString()}')),
                      );
                    }
                    },
                    text: isLoading ? 'Creating Account...' : 'Create Account',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 44,
                      color: isLoading ? Color(0xFF74F958).withOpacity(0.5) : Color(0xFF74F958),
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(LoginWidget.routeName, extra: {'pageKey': UniqueKey()});
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF74F958),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
