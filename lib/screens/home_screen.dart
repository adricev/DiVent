import 'package:divent/screens/list_events.dart';
import 'package:divent/screens/new_event.dart';
import 'package:divent/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event.dart';
import 'event_detail_screen.dart'; // Importa la pantalla de detalles del evento

class HomeScreen extends StatefulWidget {
  static List<Event> events = [];

  @override
  _HomeScreenState createState() => _HomeScreenState();

  static void addEvent(Event event) {
    events.add(event);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES');
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

  List<Event> _getEventsForDay(DateTime day) {
    return HomeScreen.events.where((event) {
      return event.date.year == day.year &&
          event.date.month == day.month &&
          event.date.day == day.day;
    }).toList();
  }

  Widget _buildEventBoxes() {
    if (_selectedDay == null) {
      return Center(child: Text('No day selected'));
    }

    final eventsForSelectedDay = _getEventsForDay(_selectedDay!);

    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: eventsForSelectedDay.length,
        itemBuilder: (context, index) {
          final event = eventsForSelectedDay[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetailScreen(event: event)),
              );
            },
            child: Container(
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
                    style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Hora de inicio: ${event.startTime.format(context)}',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                  Text(
                    'Hora de fin: ${event.endTime.format(context)}',
                    style: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
