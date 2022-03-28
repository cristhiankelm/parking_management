import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

  Widget fieldPlate() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Chapa',
            icon: Icon(Icons.paste_rounded),
            border: OutlineInputBorder()));
  }

  Widget fieldEmail() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Marca',
            icon: Icon(Icons.paste_rounded),
            border: OutlineInputBorder()));
  }

  Widget fieldModel() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Modelo',
            icon: Icon(Icons.receipt_long_rounded),
            border: OutlineInputBorder()));
  }

  Widget fieldClock() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Hora',
            icon: Icon(Icons.calendar_month_rounded),
            border: OutlineInputBorder()));
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
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              fieldPlate(),
              SizedBox(height: 20),
              fieldEmail(),
              SizedBox(height: 20),
              fieldModel(),
              SizedBox(height: 20),
              fieldClock(),
              SizedBox(height: 20),
              buttonSave(),
              SizedBox(height: 20),
              buttonCancel(),
            ],
          ),
        ),
      ),
    );
  }
}
