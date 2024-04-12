import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:core';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isEmailValid = true;
  bool _isPasswordMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Войти",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Создать аккаунт",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  buildTextField("Имя", controller: TextEditingController()),
                  SizedBox(height: 20),
                  buildEmailTextField("Почта"),
                  SizedBox(height: 20),
                  buildTextField("Пароль", obscureText: true, controller: _passwordController),
                  SizedBox(height: 20),
                  buildTextField("Повторите пароль", obscureText: true, controller: _confirmPasswordController),
                  _isPasswordMatch ? SizedBox(height: 0) : SizedBox(height: 10),
                  _isPasswordMatch ? SizedBox(height: 0) : Text(
                    "Пароли не совпадают",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {},
                  color: Colors.indigo.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Зарегистрироваться",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("У вас уже есть аккаунт ?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Войти",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, {bool obscureText = false, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            onChanged: (value) {
              if (controller == _passwordController || controller == _confirmPasswordController) {
                setState(() {
                  _isPasswordMatch = _passwordController.text == _confirmPasswordController.text;
                });
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailTextField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
              color: _isEmailValid ? Colors.white : Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              errorText:
              _isEmailValid ? null : 'Введите корректный адрес электронной почты',
              contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            ),
            onChanged: (value) {
              setState(() {
                _isEmailValid = RegExp(
                    r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                    .hasMatch(value);
              });
            },
          ),
        ),
      ),
    );
  }
}
