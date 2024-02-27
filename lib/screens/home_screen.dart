import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'list_events.dart';
import 'new_event.dart';
import 'profile_screen.dart';
import 'event.dart';

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
    initializeDateFormatting('es_ES');
    // Llama al método para imprimir los eventos cuando se inicia la pantalla
    HomeScreen.printEventsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildEventBoxes(),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset('images/B Calendar.png', width: 35),
              onPressed: () {},
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
              icon: Image.asset('images/Nuevo.png', width: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewEvent()),
                );
              },
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

  // Función para obtener los eventos para un día específico
  List<String> _getEventsForDay(DateTime day) {
    List<String> eventsForDay = [];
    for (String event in events) {
      // Asumiendo que los eventos son solo strings
      // Aquí puedes implementar la lógica para comparar fechas y obtener los eventos para el día especificado
      eventsForDay.add(event);
    }
    return eventsForDay;
  }

  Widget _buildEventBoxes() {
    return Container(
      color: Colors.grey[200],
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
                  'Nombre: ${event.name}',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'Fecha: ${event.date}',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'Hora de inicio: ${event.startTime}',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  'Hora de fin: ${event.endTime}',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
