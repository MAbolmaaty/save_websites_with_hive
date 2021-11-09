import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:save_websites_with_hive/src/screens/websites_screen.dart';
import 'package:save_websites_with_hive/src/utils/app_theme.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  // bool rememberMe = true;
  bool obscurePassword = true;

  String? _email, _password;

  @override
  void dispose() {
    Hive.box('users').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewPortConstraints) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewPortConstraints.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),

                      ///
                      /// Screen Title
                      _screenTitle(),

                      const SizedBox(
                        height: 40,
                      ),

                      ///
                      /// User Email
                      _emailEntryField(),

                      const SizedBox(
                        height: 10,
                      ),

                      ///
                      /// User password
                      _passwordEntryField(
                          (value) => _password = value,
                          () => setState(() {
                                obscurePassword = !obscurePassword;
                              }),
                          obscurePassword),

                      const SizedBox(
                        height: 20,
                      ),

                      ///
                      /// Login Button
                      _loginButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _screenTitle() {
    return const Text(
      "Sign In With Email",
      style: TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailEntryField() {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
      child: TextFormField(
          maxLines: 1,
          // validator: (value) => value.isEmpty
          //     ? AppLocalizations.of(context).enterEmailOrPhoneNumber
          //     : null,
          onSaved: (value) => _email = value,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 16, right: 16),
              labelText: "Enter your email",
              labelStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              isDense: true),
          keyboardType: TextInputType.emailAddress),
    );
  }

  Widget _passwordEntryField(Function(String? value) onSave,
      Function() passwordObscuring, bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
      child: TextFormField(
        maxLines: 1,
        //validator: (value) => value.isEmpty ? validationMessage : null,
        onSaved: onSave,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 16, right: 16),
            labelText: "Enter your password",
            labelStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
            suffixIcon: GestureDetector(
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[400]!,
                size: 25,
              ),
              onTap: passwordObscuring,
            ),
            alignLabelWithHint: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.grey[400]!)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.grey[400]!)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Colors.grey[400]!)),
            isDense: true),
      ),
    );
  }

  Widget _loginButton() {
    return GestureDetector(
        onTap: () {
          ///
          /// Hide keyboard
          FocusScope.of(context).unfocus();

          final form = formKey.currentState;
          if (form!.validate()) {
            form.save();
            Navigator.of(context)
                .pushAndRemoveUntil(WebsitesScreen.route(), (route) => false);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              color: AppTheme.primaryColor),
          child: Text(
            "Sign In".toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[400],
            ),
          ),
        ));
  }
}
