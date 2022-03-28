import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

  Widget fieldPlate() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Chapa', icon: Icon(Icons.paste_rounded)));
  }

  Widget fieldEmail() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Marca', icon: Icon(Icons.paste_rounded)));
  }

  Widget fieldModel() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Modelo', icon: Icon(Icons.receipt_long_rounded)));
  }

  Widget fieldClock() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Hora', icon: Icon(Icons.calendar_month_rounded)));
  }

  Widget buttonSave() {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () {},
            icon: Icon(Icons.save),
            label: Text('Guardar')));
  }

  Widget buttonCancel() {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {},
            icon: Icon(Icons.cancel_presentation_rounded),
            label: Text('Cancelar')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Estacionamiento'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.car_rental_sharp))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              fieldPlate(),
              fieldEmail(),
              fieldModel(),
              fieldClock(),
              buttonSave(),
              buttonCancel(),
            ],
          ),
        ),
      ),
    );
  }
}
