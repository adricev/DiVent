import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'list_events.dart'; // Importa la clase ListEvents
import 'home_screen.dart'; // Importa ,a clase HomeScreen
import 'profile_screen.dart'; // Importa la clase ProfileScreen

class NewEvent extends StatefulWidget {
  @override
  _NewEventState createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

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
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
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
                            ? startTime!.format(context)
                            : 'Seleccione la hora de inicio',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Seleccione la hora de inicio',
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
                            ? endTime!.format(context)
                            : 'Seleccione la hora de fin',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Seleccione la hora de fin',
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
                      // Acción para cancelar el evento
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
                      // Acción para crear el evento
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset('images/B Calendar.png', width: 35),
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
              icon: Image.asset('images/Nuevo.png', width: 35),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('images/Perfil.png', width: 35),
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
}
