import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'event.dart'; // Asegúrate de tener esta clase definida

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 122, 48, 172),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Color.fromARGB(255, 122, 48, 172)),
                    SizedBox(width: 8),
                    Text(
                      'Fecha: ${DateFormat('dd-MM-yyyy').format(event.date)}',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Color.fromARGB(255, 122, 48, 172)),
                    SizedBox(width: 8),
                    Text(
                      'Hora de inicio: ${event.startTime.format(context)}',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Color.fromARGB(255, 122, 48, 172)),
                    SizedBox(width: 8),
                    Text(
                      'Hora de fin: ${event.endTime.format(context)}',
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Detalles del evento:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 122, 48, 172),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  event.note,
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
