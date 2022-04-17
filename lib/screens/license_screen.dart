import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_management/models/licenseplate_model.dart';
import 'package:parking_management/models/state_model.dart';
import 'package:parking_management/models/street_model.dart';
import 'package:parking_management/providers/auth_provider.dart';
import 'package:parking_management/providers/street_provider.dart';
import 'package:parking_management/widgets/appbar.dart';
import 'package:parking_management/widgets/button_street.dart';
import 'package:parking_management/widgets/drawer.dart';
import 'package:provider/provider.dart';

class LicensePlateScreen extends StatefulWidget {
  const LicensePlateScreen({Key? key}) : super(key: key);

  @override
  State<LicensePlateScreen> createState() => _LicensePlateScreenState();
}

class _LicensePlateScreenState extends State<LicensePlateScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController controllerLicense = TextEditingController();

  bool addLicense = false;

  @override
  Widget build(BuildContext context) {
    var providerStreet = Provider.of<StreetProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool verifyCity(String value) {
      for (var i = 0; i < providerStreet.streets.length; i++) {
        if (providerStreet.streets[i].toString() == value) {
          return true;
        }
      }
      return false;
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: Appbar(
        title: 'Matriculas',
        pageContext: context,
        scaffoldKey: _scaffoldKey,
        showBack: true,
        background: const Color.fromARGB(255, 0, 80, 200),
        drawerColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Autocomplete<Street>(
                optionsBuilder: (TextEditingValue textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<Street>.empty();
                  } else {
                    var autoCompleteData = providerStreet.streets;
                    return autoCompleteData.where((street) => street.name!
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()));
                  }
                },
                optionsViewBuilder:
                    (context, Function(Street) onSelected, options) {
                  return Material(
                    elevation: 4,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return ListTile(
                          title: Text(
                            option.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: () {
                            onSelected(option);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: options.length,
                    ),
                  );
                },
                onSelected: (selectedStreet) {
                  providerStreet.street = selectedStreet;
                },
                fieldViewBuilder: (
                  context,
                  controller,
                  focusNode,
                  onEditingComplete,
                ) {
                  this.controller = controller;
                  return TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Selecione una calle";
                      } else if (!verifyCity(value)) {
                        return "Calle no registrada";
                      }
                      return null;
                    },
                    controller: this.controller,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      hintText: "Buscar Calle",
                      prefixIcon: const Icon(Icons.search),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    addLicense = true;
                  });
                },
                child: const Text(
                  "Añadir matricula",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 80, 200),
                  ),
                ),
              ),
              addLicense == true
                  ? SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingrese matricula";
                              }
                            },
                            controller: controllerLicense,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              labelText: "Matricula",
                              labelStyle: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Expanded(child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _formKey.currentState!.reset();
                                  controller.clear();
                                  setState(() {
                                    addLicense = false;
                                  });
                                },
                                child: MyButton(
                                    text: "Cancelar",
                                    background:
                                        const Color.fromARGB(255, 192, 55, 45),
                                    context: context),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  LicensePlate licensePlate = LicensePlate(
                                      enroliment: controllerLicense.text,
                                      street: providerStreet.street!);
                                  if (_formKey.currentState!.validate()) {
                                    // if (await provider.addStreet(street,
                                    //         authProvider.userCurrent.token!) ==
                                    //     true) {
                                    //   setState(() {
                                    //     addLicense = false;
                                    //   });
                                    //   controllerStreet.clear();
                                    //   Fluttertoast.showToast(
                                    //     msg: "Calle registrada",
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //   );
                                    // } else {
                                    //   Fluttertoast.showToast(
                                    //     msg: "Error",
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //   );
                                    // }
                                  }
                                },
                                child: MyButton(
                                    text: "Guardar",
                                    background:
                                        const Color.fromARGB(255, 0, 80, 200),
                                    context: context),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
            ]),
          ),
        ),
      ),
    );
  }
}