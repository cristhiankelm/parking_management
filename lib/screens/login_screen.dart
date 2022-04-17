import 'package:flutter/material.dart';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_management/models/user_model.dart';
import 'package:parking_management/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool signin = true;
  bool processing = false;
  late TextEditingController namectrl, emailctrl, passctrl;
  User user = User();
  @override
  void initState() {
    super.initState();
    namectrl = TextEditingController();
    emailctrl = TextEditingController();
    passctrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue.shade50,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.account_circle,
              size: 200,
              color: Color.fromARGB(255, 0, 80, 200),
            ),
            boxUi(),
          ],
        ));
  }

  void changeState() {
    cleanFields();
    _formKey.currentState!.reset();
    if (signin) {
      setState(() {
        signin = false;
      });
    } else {
      setState(() {
        signin = true;
      });
    }
  }

  void cleanFields() {
    emailctrl.clear();
    namectrl.clear();
    passctrl.clear();
  }

  void createUser() {
    user.name = namectrl.text;
    user.email = emailctrl.text;
    user.password = passctrl.text;
  }

  registerUser() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      processing = true;
    });

    createUser();

    List res = await authProvider.registerUser(user);

    if (res.contains("200")) {
      cleanFields();
      Navigator.pushReplacementNamed(context, 'home', arguments: user);
      Fluttertoast.showToast(
        msg: "Cuenta creada",
        toastLength: Toast.LENGTH_SHORT,
      );
    } else if (res[1]
        .contains("The password must contain at least one number.")) {
      Fluttertoast.showToast(
        msg: "La contraseña debe contener al menos un número.",
        toastLength: Toast.LENGTH_SHORT,
      );
      passctrl.clear();
    } else if (res[1].contains("The password must be at least 8 characters.")) {
      Fluttertoast.showToast(
        msg: "La contraseña debe tener al menos 8 caracteres.",
        toastLength: Toast.LENGTH_SHORT,
      );
    } else if (res[0].contains("The email has already been taken.")) {
      Fluttertoast.showToast(
        msg: "El email ya ha sido registrado.",
        toastLength: Toast.LENGTH_SHORT,
      );
      emailctrl.clear();
    } else {
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    setState(() {
      processing = false;
    });
  }

  void userSignIn() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      processing = true;
    });

    createUser();

    int res = await authProvider.userSignIn(user);

    if (res == 200) {
      Navigator.pushReplacementNamed(context, 'home');
      Fluttertoast.showToast(msg: "success", toastLength: Toast.LENGTH_SHORT);
    } else if (res == 422) {
      Fluttertoast.showToast(
          msg: "usuario o contraseña incorrecta",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
    }
    setState(() {
      processing = false;
    });
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'SIGN IN',
                    style: GoogleFonts.varelaRound(
                      color: signin == true
                          ? const Color.fromARGB(255, 0, 80, 200)
                          : Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.varelaRound(
                      color: signin != true
                          ? const Color.fromARGB(255, 0, 80, 200)
                          : Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            signin == true ? signInUi() : signUpUi(),
          ],
        ),
      ),
    );
  }

  Widget signInUi() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: ((value) {
              if (!value!.contains("@")) {
                return "E-mail invalido";
              } else if (value.length < 5) {
                return "E-mail invalido";
              }
              return null;
            }),
            controller: emailctrl,
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box,
                  color: Color.fromARGB(255, 0, 80, 200),
                ),
                hintText: 'email'),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Contraseña invalido";
              }
              return null;
            },
            controller: passctrl,
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color.fromARGB(255, 0, 80, 200),
                ),
                hintText: 'contraseña'),
          ),
          const SizedBox(
            height: 10.0,
          ),
          MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  userSignIn();
                }
              },
              child: processing == false
                  ? Text(
                      'Iniciar sesión',
                      style: GoogleFonts.varelaRound(
                          fontSize: 18.0,
                          color: const Color.fromARGB(255, 0, 80, 200)),
                    )
                  : const CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    )),
        ],
      ),
    );
  }

  Widget signUpUi() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return "Campo obligatorio";
              } else if (value.length <= 2) {
                return "Nombre invalido";
              }
              return null;
            }),
            controller: namectrl,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 0, 80, 200),
              ),
              hintText: 'nombre',
            ),
          ),
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return "Campo obligatorio";
              } else if (value.length < 5) {
                return "E-mail invalido";
              } else if (!value.contains("@")) {
                return "E-mail invalido";
              }
              return null;
            }),
            controller: emailctrl,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                color: Color.fromARGB(255, 0, 80, 200),
              ),
              hintText: 'email',
            ),
          ),
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            }),
            controller: passctrl,
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color.fromARGB(255, 0, 80, 200),
                ),
                hintText: 'contraseña'),
          ),
          const SizedBox(
            height: 10.0,
          ),
          MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registerUser();
                }
              },
              child: processing == false
                  ? Text(
                      'Inscribirse',
                      style: GoogleFonts.varelaRound(
                          fontSize: 18.0,
                          color: const Color.fromARGB(255, 0, 80, 200)),
                    )
                  : const CircularProgressIndicator(
                      backgroundColor: Colors.green)),
        ],
      ),
    );
  }
}
