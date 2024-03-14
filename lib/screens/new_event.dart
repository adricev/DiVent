import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'list_events.dart'; // Importa la clase ListEvents
import 'home_screen.dart'; // Importa la clase HomeScreen
import 'profile_screen.dart'; // Importa la clase ProfileScreen
import 'event.dart'; // Importa la clase Event

// Widget StatefulWidget para agregar un nuevo evento
class NewEvent extends StatefulWidget {
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? eventNote;
  String? eventName; // Variable para almacenar el nombre del evento

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Evento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre del Evento'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    eventName =
                        value; // Actualiza el valor del nombre del evento
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Nombre del Evento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Notas'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    eventNote = value; // Actualiza el valor de nota del evento
                  });
                },
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Notas del Evento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Fecha'),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: selectedDate != null
                      ? DateFormat('dd-MM-yyyy').format(
                          selectedDate!) // Formatea la fecha seleccionada
                      : 'Seleccione una fecha',
                ),
                decoration: InputDecoration(
                  hintText: 'Seleccione una fecha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedDate)
                        setState(() {
                          selectedDate = picked;
                        });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Hora de Inicio'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: startTime != null
                            ? startTime!
                                .format(context) // Formatea la hora de inicio
                            : 'Seleccione la hora de inicio',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Hora de inicio',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null && picked != startTime)
                              setState(() {
                                startTime = picked;
                              });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0), // Espacio entre los campos de hora
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: endTime != null
                            ? endTime!
                                .format(context) // Formatea la hora de fin
                            : 'Seleccione la hora de fin',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Hora de fin',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null && picked != endTime)
                              setState(() {
                                endTime = picked;
                              });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text('Etiquetas de Colores'),
              // Aquí puedes implementar los botones de opción para los colores
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[200], // Fondo rojo clarito
                      onPrimary: Colors.white, // Texto blanco
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addEvent();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 122, 115, 222), // Fondo morado
                      onPrimary: Colors.white, // Texto blanco
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Crear Evento'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Barra de navegación inferior
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset('images/Calendar.png', width: 35),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('images/Menu.png', width: 35),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListEvents()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('images/B Nuevo.png', width: 30),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('images/Perfil.png', width: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Función para agregar un evento a la lista
  void _addEvent() {
    setState(() {
      final newEvent = Event(
        name: eventName ??
            'Evento', // Utiliza el valor del TextFormField o 'Evento' si es nulo
        note: eventNote ??
            'Nota', // Utiliza el valor del TextFormField o 'Nota' si es nulo
        date: selectedDate ?? DateTime.now(),
        startTime: startTime ?? TimeOfDay.now(),
        endTime: endTime ?? TimeOfDay.now(),
      );

      // Agrega el nuevo evento a la lista en HomeScreen
      HomeScreen.events.add(newEvent);

      // Limpia los campos de entrada
      eventName = null;
      eventNote = null;
      selectedDate = null;
      startTime = null;
      endTime = null;
    });
  }
}
