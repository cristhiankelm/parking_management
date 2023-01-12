import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_management/models/licenseplate_model.dart';
import 'package:parking_management/models/state_model.dart';
import 'package:parking_management/models/street_model.dart';
import 'package:parking_management/providers/auth_provider.dart';
import 'package:parking_management/providers/license_plate_provider.dart';
import 'package:parking_management/providers/street_provider.dart';
import 'package:parking_management/widgets/appbar.dart';
import 'package:parking_management/widgets/button_street.dart';
import 'package:parking_management/widgets/drawer.dart';
import 'package:parking_management/widgets/plate.dart';
import 'package:provider/provider.dart';

class LicensePlateScreen extends StatefulWidget {
  const LicensePlateScreen({Key? key}) : super(key: key);

  @override
  State<LicensePlateScreen> createState() => _LicensePlateScreenState();
}

class _LicensePlateScreenState extends State<LicensePlateScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  TextEditingController controllerLicense = TextEditingController();

  bool addLicense = false;
  bool isSavingLicense = false;

  @override
  Widget build(BuildContext context) {
    var providerStreet = Provider.of<StreetProvider>(context, listen: false);
    var providerLicense = Provider.of<LicenseProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool verifyStreet(String value) {
      for (var i = 0; i < providerStreet.streets.length; i++) {
        if (providerStreet.streets[i].toString() == value) {
          return true;
        }
      }
      return false;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(children: [
                    Autocomplete<Street>(
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
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
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: options.length,
                          ),
                        );
                      },
                      onSelected: (selectedStreet) {
                        providerLicense.listLicenses.clear();
                        providerLicense.street = selectedStreet;
                        providerLicense.filterLicenses();
                        setState(() {});
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
                            } else if (!verifyStreet(value)) {
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
                          addLicense = !addLicense;
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
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 151,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Ingrese matricula";
                                    } else if (value.length < 6 ||
                                        value.length > 7) {
                                      return "Matricula invalida";
                                    }
                                    return null;
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
                                const SizedBox(
                                  height: 20,
                                ),
                                isSavingLicense == false
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _formKey.currentState!.reset();
                                              controllerLicense.clear();
                                              setState(() {
                                                addLicense = false;
                                              });
                                            },
                                            child: MyButton(
                                                text: "Cancelar",
                                                background:
                                                    const Color.fromARGB(
                                                        255, 192, 55, 45),
                                                context: context),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  isSavingLicense = true;
                                                });
                                                LicensePlate licensePlate =
                                                    LicensePlate(
                                                        enroliment:
                                                            controllerLicense
                                                                .text
                                                                .toUpperCase(),
                                                        street_id:
                                                            providerLicense
                                                                .street!.id
                                                                .toString());
                                                if (await providerLicense
                                                        .addLicense(
                                                            licensePlate,
                                                            authProvider
                                                                .userCurrent
                                                                .token!) ==
                                                    true) {
                                                  controllerLicense.clear();
                                                  // providerLicense
                                                  //     .filterLicenses();
                                                  setState(() {
                                                    // addLicense = false;
                                                    isSavingLicense = false;
                                                  });
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                  Fluttertoast.showToast(
                                                    msg: "Matricula registrada",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg: "Error",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                }
                                              }
                                            },
                                            child: MyButton(
                                                text: "Guardar",
                                                background:
                                                    const Color.fromARGB(
                                                        255, 0, 80, 200),
                                                context: context),
                                          )
                                        ],
                                      )
                                    : const CircularProgressIndicator(
                                        backgroundColor: Colors.green,
                                      )
                              ],
                            ),
                          )
                        : Container(),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height,
                  width: 250,
                  child: ListView.builder(
                    itemCount: providerLicense.listLicenses.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          showDialog(
                              useSafeArea: true,
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding:
                                      const EdgeInsets.only(top: 15),
                                  elevation: 4,
                                  title: const Text("Eliminar matricula?"),
                                  content: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 101,
                                    child: Plate(
                                        text: providerLicense
                                            .listLicenses.reversed
                                            .elementAt(index)
                                            .enroliment,
                                        context: context),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 0, 80, 200)),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (await providerLicense.removeLicense(
                                                providerLicense
                                                    .listLicenses.reversed
                                                    .elementAt(index)
                                                    .id!,
                                                authProvider
                                                    .userCurrent.token!) ==
                                            true) {
                                          controllerLicense.clear();
                                          Fluttertoast.showToast(
                                            msg: "Matricula eliminada",
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                          setState(() {});
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          Navigator.of(context).pop();
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Error",
                                            toastLength: Toast.LENGTH_SHORT,
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "Si",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 0, 80, 200)),
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Plate(
                            text: providerLicense.listLicenses.reversed
                                .elementAt(index)
                                .enroliment,
                            context: context),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
