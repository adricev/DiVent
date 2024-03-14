import 'package:flutter/material.dart'; // Importación de Flutter Material Design
import 'package:intl/date_symbol_data_local.dart'; // Importación para inicializar el formato de fecha local
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart'; // Importación del calendario de mesa
import 'list_events.dart'; // Importación de la lista de eventos
import 'new_event.dart'; // Importación de la pantalla para crear un nuevo evento
import 'profile_screen.dart'; // Importación de la pantalla de perfil
import 'event.dart'; // Importación de la clase Event

class HomeScreen extends StatefulWidget {
  static List<Event> events = []; // Lista de eventos

  @override
  _HomeScreenState createState() => _HomeScreenState();

  // Método estático para agregar un evento
  static void addEvent(Event event) {
    events.add(event);
  }

  // Método para imprimir los datos de los eventos en la consola
  static void printEventsData() {
    for (var event in events) {
      print('Nombre del evento: ${event.name}');
      print('Fecha del evento: ${event.date}');
      print('Hora de inicio del evento: ${event.startTime}');
      print('Hora de fin del evento: ${event.endTime}');
      print('---------------------------');
    }
  }
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String> events = []; // Lista de eventos creados

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES'); // Inicializa el formato de fecha local
    // Llama al método para imprimir los eventos cuando se inicia la pantalla
    HomeScreen.printEventsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'), // Título de la barra de aplicación
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: _focusedDay,
                locale: 'es_ES',
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: (day) {
                  return _getEventsForDay(day);
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.red),
                  weekdayStyle: TextStyle(color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, _) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 122, 48, 172),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildEventBoxes(), // Widget para mostrar los eventos
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset('images/B Calendar.png',
                  width: 35), // Icono para la vista de calendario
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('images/Menu.png',
                  width: 35), // Icono para mostrar la lista de eventos
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListEvents()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('images/Nuevo.png',
                  width: 30), // Icono para agregar un nuevo evento
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEvent()),
                );
              },
            ),
            IconButton(
              icon: Image.asset('images/Perfil.png',
                  width: 30), // Icono para ir a la pantalla de perfil
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

// Función para obtener los eventos para un día específico
  List<Event> _getEventsForDay(DateTime day) {
    List<Event> eventsForDay = [];
    for (Event event in HomeScreen.events) {
      // Aquí comparamos la fecha del evento con la fecha especificada
      if (event.date.year == day.year &&
          event.date.month == day.month &&
          event.date.day == day.day) {
        eventsForDay.add(event);
      }
    }
    return eventsForDay;
  }

// Función para formatear números a dos dígitos con ceros a la izquierda si es necesario
  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  // Widget para mostrar los eventos en forma de cajas
  Widget _buildEventBoxes() {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: HomeScreen
            .events.length, // Modificado para mostrar los eventos de HomeScreen
        itemBuilder: (context, index) {
          final event = HomeScreen.events[index];
          return Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 143, 86, 179),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${event.name}', // Nombre del evento
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Fecha: ${DateFormat('dd-MM-yyyy').format(event.date)}', // Fecha del evento
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
                Text(
                  'Hora de inicio: ${event.startTime}', // Hora de inicio del evento
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
                Text(
                  'Hora de fin: ${event.endTime}', // Hora de fin del evento
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
