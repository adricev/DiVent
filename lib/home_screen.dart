import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: DateTime.utc(2024, 2, 14),
                eventLoader: (day) {
                  if (day.day % 2 == 0) {
                    return ['Evento 1', 'Evento 2'];
                  } else {
                    return ['Evento 3'];
                  }
                },
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
              icon: Icon(Icons.home),
              onPressed: () {
                // Acciones al presionar el botón de inicio
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                // Acciones al presionar el botón de calendario
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Acciones al presionar el botón de notificaciones
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Acciones al presionar el botón de ajustes
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventBoxes() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Evento ${index + 1}',
              style: TextStyle(fontSize: 16.0),
            ),
          );
        },
      ),
    );
  }
}
