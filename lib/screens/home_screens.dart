import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              leading: Icon(Icons.verified_user),
              elevation: 0,
              title: Text('Detalles Vehículo'),
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              actions: <Widget>[],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Chapa',
                  hintText: 'Chapa del Vehículo',
                  icon: Icon(Icons.lock_outline),
                  isDense: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Modelo',
                  hintText: 'Modelo del Vehículo',
                  icon: Icon(Icons.car_rental),
                  isDense: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Marca',
                  hintText: 'Marca del Vehículo',
                  icon: Icon(Icons.dinner_dining),
                  isDense: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Horario',
                  hintText: '',
                  icon: Icon(Icons.punch_clock),
                  isDense: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
