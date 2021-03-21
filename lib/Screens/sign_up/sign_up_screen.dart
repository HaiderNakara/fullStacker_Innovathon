import 'package:flutter/material.dart';
import 'package:inventory_management_system/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/SignUpScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email;

  String _password;
  String _repassword;

  bool _reobscureText = true;
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              TextFormField(
                validator: (String value) {
                  if (value.length < 6) {
                    return "Enter valid Email";
                  }
                  return null;
                },
                onSaved: (input) => _email = input,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter your email",
                  hintText: "Enter your email",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (String value) {
                  if (value.length < 6) {
                    return "Enter a valid password";
                  }
                  return null;
                },
                onSaved: (input) => _password = input,
                obscureText: _obscureText,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Enter your Password",
                  hintText: "Enter your Password",
                  suffixIcon: GestureDetector(
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                    onTap: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: _reobscureText,
                controller: _repasswordController,
                validator: (String value) {
                  if (value.length < 8) {
                    return "Password don't match";
                  }
                  return null;
                },
                onSaved: (input) => _repassword = input,
                decoration: InputDecoration(
                  labelText: "Re Enter your Password",
                  hintText: "Re Enter your Password",
                  suffixIcon: GestureDetector(
                    child: Icon(_reobscureText
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onTap: () {
                      setState(() => _reobscureText = !_reobscureText);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    context.read<AuthenticationService>().signUp(
                        context: context,
                        email: _emailController.text,
                        password: _passwordController.text);
                  }
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
