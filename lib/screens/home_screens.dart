import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

  Widget fieldPlate() {
    return TextFormField(decoration: InputDecoration(labelText: 'Chapa'));
  }

  Widget fieldEmail() {
    return TextFormField(decoration: InputDecoration(labelText: 'Marca'));
  }

  Widget fieldModel() {
    return TextFormField(decoration: InputDecoration(labelText: 'Modelo'));
  }

  Widget fieldClock() {
    return TextFormField(decoration: InputDecoration(labelText: 'Hora'));
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
            children: [fieldPlate(), fieldEmail(), fieldModel(), fieldClock()],
          ),
        ),
      ),
    );
  }
}
