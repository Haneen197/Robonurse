import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'Login';
  static String routePath = '/login';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();
    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    // Clear text fields on load for professionalism
    _model.emailAddressTextController?.clear();
    _model.passwordTextController?.clear();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model.emailAddressTextController?.clear();
      _model.passwordTextController?.clear();
      setState(() {});
    });
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
        backgroundColor: Color(0xFF1E1E1E),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              padding: EdgeInsets.all(32.0),
              child: Card(
                color: Color(0xFF2A2A2A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Robonurse',
                          style: FlutterFlowTheme.of(context).displaySmall.copyWith(
                            color: Color(0xFFF9C258),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Welcome Back',
                        style: FlutterFlowTheme.of(context).displaySmall.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Let\'s get started by filling out the form below.',
                        style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                          color: Color(0xFF74F958),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _model.emailAddressTextController,
                        focusNode: _model.emailAddressFocusNode,
                        autofillHints: [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Color(0xFF3A3A3A),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email, color: Color(0xFF74F958)),
                        ),
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        validator: _model.emailAddressTextControllerValidator.asValidator(context),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _model.passwordTextController,
                        focusNode: _model.passwordFocusNode,
                        obscureText: !_model.passwordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Color(0xFF3A3A3A),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock, color: Color(0xFF74F958)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _model.passwordVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _model.passwordVisibility = !_model.passwordVisibility;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: _model.passwordTextControllerValidator.asValidator(context),
                      ),
                      SizedBox(height: 24),
                      FFButtonWidget(
                        onPressed: () async {
                          GoRouter.of(context).prepareAuthEvent();
                          final user = await authManager.signInWithEmail(
                            context,
                            _model.emailAddressTextController.text,
                            _model.passwordTextController.text,
                          );
                          if (user == null) {
                            return;
                          }
                          if (valueOrDefault<bool>(currentUserDocument?.patient, false)) {
                            context.pushNamedAuth(PatientPageWidget.routeName, context.mounted);
                          } else if (valueOrDefault<bool>(currentUserDocument?.doctor, false)) {
                            context.pushNamedAuth(DoctorPageWidget.routeName, context.mounted);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Your account does not have a valid role assigned. Please contact support.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                        },
                        text: 'Sign In',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 44,
                          color: Color(0xFF74F958),
                          textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(SignupWidget.routeName);
                            },
                            child: Text(
                              'Signup',
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
        ),
      ),
    );
  }
}
