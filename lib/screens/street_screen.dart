import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_management/models/city_model.dart';
import 'package:parking_management/models/district_model.dart';
import 'package:parking_management/models/state_model.dart';
import 'package:parking_management/models/street_model.dart';
import 'package:parking_management/providers/auth_provider.dart';
import 'package:parking_management/providers/license_plate_provider.dart';
import 'package:parking_management/providers/street_provider.dart';
import 'package:parking_management/widgets/appbar.dart';
import 'package:parking_management/widgets/button_street.dart';
import 'package:parking_management/widgets/drawer.dart';
import 'package:provider/provider.dart';

class StreetPage extends StatefulWidget {
  const StreetPage({Key? key}) : super(key: key);
  @override
  State<StreetPage> createState() => _StreetPageState();
}

class _StreetPageState extends State<StreetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerState = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerDistrict = TextEditingController();
  TextEditingController controllerNewDistrict = TextEditingController();
  TextEditingController controllerStreet = TextEditingController();
  bool addDistrict = false;
  bool addStreet = false;
  bool showTextButtonDistrict = true;
  bool isSavingStreet = false;

  @override
  Widget build(BuildContext context) {
    var providerStreet = Provider.of<StreetProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool verifyCity(String value) {
      for (var i = 0; i < providerStreet.cities.length; i++) {
        if (providerStreet.cities[i].toString() == value) {
          return true;
        }
      }
      return false;
    }

    bool verifyDistrict(String value) {
      for (var i = 0; i < providerStreet.districts.length; i++) {
        if (providerStreet.districts[i].toString() == value) {
          return true;
        }
      }
      return false;
    }

    bool verifyState(String value) {
      for (var i = 0; i < providerStreet.states.length; i++) {
        if (providerStreet.states[i].toString() == value) {
          return true;
        }
      }
      return false;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: Appbar(
          title: 'Direcciones',
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
              child: Column(
                children: [
                  Autocomplete<Department>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<Department>.empty();
                      } else {
                        var autoCompleteData = providerStreet.states;
                        return autoCompleteData
                            .where((state) => state.name!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                            .toList();
                      }
                    },
                    optionsViewBuilder:
                        (context, Function(Department) onSelected, options) {
                      return Material(
                        elevation: 4,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            Department option = options.elementAt(index);
                            return ListTile(
                              title: Text(
                                option.name!,
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
                    onSelected: (selectedState) {
                      controllerCity.clear();
                      controllerDistrict.clear();
                      providerStreet.listDistricts.clear();
                      providerStreet.listCities.clear();
                      providerStreet.state = selectedState;
                      providerStreet.filterCities();
                    },
                    fieldViewBuilder: (
                      context,
                      controller,
                      focusNode,
                      onEditingComplete,
                    ) {
                      controllerState = controller;
                      return TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Campo obligatorio";
                          } else if (!verifyState(value)) {
                            return "Seleccione un departamento valido";
                          }
                          return null;
                        }),
                        controller: controllerState,
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
                          hintText: "Buscar Departamento",
                          prefixIcon: const Icon(Icons.search),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Autocomplete<City>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<City>.empty();
                      } else {
                        var autoCompleteData = providerStreet.listCities;
                        return autoCompleteData.where((city) => city.name!
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()));
                      }
                    },
                    optionsViewBuilder:
                        (context, Function(City) onSelected, options) {
                      return Material(
                        elevation: 4,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);
                            return ListTile(
                              title: Text(
                                option.name!,
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
                    onSelected: (selectedCity) {
                      controllerDistrict.clear();
                      providerStreet.listDistricts.clear();
                      providerStreet.city = selectedCity;
                      providerStreet.filterDistricts();
                    },
                    fieldViewBuilder: (
                      context,
                      controller,
                      focusNode,
                      onEditingComplete,
                    ) {
                      controllerCity = controller;
                      return TextFormField(
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "Campo obligatorio";
                          } else if (!verifyCity(value)) {
                            return "Seleccione una ciudad valida";
                          }
                          return null;
                        }),
                        controller: controllerCity,
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
                          hintText: "Buscar Ciudad",
                          prefixIcon: const Icon(Icons.search),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Autocomplete<District>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<District>.empty();
                      } else {
                        var autoCompleteData = providerStreet.listDistricts;
                        return autoCompleteData.where((district) => district
                            .name!
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()));
                      }
                    },
                    optionsViewBuilder:
                        (context, Function(District) onSelected, options) {
                      return Material(
                        elevation: 4,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final option = options.elementAt(index);
                            return ListTile(
                              title: Text(
                                option.name!,
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
                    onSelected: (selectedDistric) {
                      providerStreet.district = selectedDistric;
                    },
                    fieldViewBuilder: (
                      context,
                      controller,
                      focusNode,
                      onEditingComplete,
                    ) {
                      controllerDistrict = controller;
                      return TextFormField(
                        validator: (value) {
                          if (addDistrict) {
                            return null;
                          } else if (value!.isEmpty) {
                            return "Campo obligatorio";
                          } else if (!verifyDistrict(value)) {
                            return "Seleccione un barrio valido";
                          }
                          return null;
                        },
                        controller: controllerDistrict,
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
                            hintText: "Buscar Barrio",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: addDistrict == false
                                  ? const Icon(Icons.add)
                                  : const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  addDistrict = !addDistrict;
                                });
                              },
                            )),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  addDistrict == true
                      ? SizedBox(
                          height: 65,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo obligatorio";
                              } else if (value.length < 4) {
                                return "Ingrese un barrio existente";
                              }
                              return null;
                            },
                            controller: controllerNewDistrict,
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
                              labelText: "Nuevo Barrio",
                              labelStyle: const TextStyle(fontSize: 15),
                              suffix: showTextButtonDistrict
                                  ? TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            showTextButtonDistrict = false;
                                          });
                                          District district = District(
                                              name: controllerNewDistrict.text,
                                              cityId: providerStreet.city!.id);
                                          if (await providerStreet.addDistrict(
                                                  district,
                                                  authProvider
                                                      .userCurrent.token!) ==
                                              true) {
                                            setState(() {
                                              addDistrict = false;
                                              showTextButtonDistrict = true;
                                            });
                                            providerStreet.listDistricts
                                                .clear();
                                            controllerNewDistrict.clear();
                                            providerStreet.filterDistricts();
                                            Fluttertoast.showToast(
                                              msg: "Barrio registrado",
                                              toastLength: Toast.LENGTH_SHORT,
                                            );
                                          } else {
                                            controllerNewDistrict.clear();
                                            setState(() {
                                              addDistrict = false;
                                              showTextButtonDistrict = true;
                                            });
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            Fluttertoast.showToast(
                                              msg: "Error",
                                              toastLength: Toast.LENGTH_SHORT,
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "Guardar",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 0, 80, 200),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(
                                          top: 20, right: 5),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 3,
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                            ),
                          ),
                        )
                      : Container(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        addStreet = true;
                      });
                    },
                    child: const Text(
                      "Añadir calle",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 80, 200),
                      ),
                    ),
                  ),
                  addStreet == true
                      ? SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Campo obligatorio";
                                  } else if (value.length < 4) {
                                    return "Ingrese una calle valida";
                                  }
                                  return null;
                                },
                                controller: controllerStreet,
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
                                  labelText: "Nombre calle",
                                  labelStyle: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Expanded(child: Container()),
                              isSavingStreet == false
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              controllerStreet.clear();
                                              addStreet = false;
                                            });
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: MyButton(
                                              text: "Cancelar",
                                              background: const Color.fromARGB(
                                                  255, 192, 55, 45),
                                              context: context),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isSavingStreet = true;
                                              });
                                              Street street = Street(
                                                name: controllerStreet.text,
                                                district:
                                                    providerStreet.district!,
                                              );

                                              if (await providerStreet
                                                      .addStreet(
                                                          street,
                                                          authProvider
                                                              .userCurrent
                                                              .token!) ==
                                                  true) {
                                                setState(() {
                                                  addStreet = false;
                                                  isSavingStreet = false;
                                                });
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                controllerStreet.clear();
                                                Fluttertoast.showToast(
                                                  msg: "Calle registrada",
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
                                              background: const Color.fromARGB(
                                                  255, 0, 80, 200),
                                              context: context),
                                        )
                                      ],
                                    )
                                  : const CircularProgressIndicator(
                                      strokeWidth: 3,
                                      backgroundColor: Colors.green,
                                    )
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
