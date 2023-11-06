import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Persona> _personas = [
    Persona('Juan', 'Perez', '123456789'),
    Persona('Maria', 'Martinez', '987654321'),
    Persona('Pedro', 'Jimenez', '456789123'),
    Persona('Jose', 'Garcia', '321654987'),
    Persona('Luis', 'Rodriguez', '654123987'),
  ];

  void _agregarPersona() {
    setState(() {
      _personas.add(Persona('Jorge', 'Aguilar', '987654321'));
    });
  }

  void _eliminarPersona(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Persona'),
          content:
              Text('¿Estás seguro de eliminar a ${_personas[index].nombre}?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                setState(() {
                  _personas.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listado de alumnos'),
        ),
        body: ListView.builder(
          itemCount: _personas.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Dismissible(
                  key: Key(_personas[index].nombre),
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                  ),
                  onDismissed: (direction) {
                    _eliminarPersona(index);
                  },
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            '${_personas[index].nombre} ${_personas[index].lastName}'),
                        Text(_personas[index].cuenta),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(_personas[index].nombre.substring(0, 1)),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      print(_personas[index].cuenta);
                    },
                  ),
                ),
                Divider(), // Agrega un Divider entre cada elemento
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
          onPressed: _agregarPersona,
        ),
      ),
    );
  }
}

class Persona {
  String nombre;
  String lastName;
  String cuenta;

  Persona(this.nombre, this.lastName, this.cuenta);
}
