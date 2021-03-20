import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/sign_up/sign_up_screen.dart';
import 'package:inventory_management_system/authentication_service.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/SignInScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email;
  // ignore: unused_field
  String _password;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              TextFormField(
                onSaved: (input) => _email = input,
                validator: (String value) {
                  if (value.length < 6) {
                    return "Enter valid Email";
                  }
                  return null;
                },
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Enter your email",
                  hintText: "Enter your email",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (input) => _password = input,
                validator: (String value) {
                  if (value.length < 6) {
                    return "Enter correct password";
                  }
                  return null;
                },
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
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    context.read<AuthenticationService>().signIn(
                          context: context,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                  }
                },
                child: Text("Sign In"),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have a account?",
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, SignUpScreen.routeName),
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
