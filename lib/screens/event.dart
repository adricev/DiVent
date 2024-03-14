import 'package:flutter/material.dart'; // Importación de Flutter Material Design

// Clase que representa un evento
class Event {
  String name; // Nombre del evento
  String note; // Nota asociada al evento
  DateTime date; // Fecha del evento
  TimeOfDay startTime; // Hora de inicio del evento
  TimeOfDay endTime; // Hora de finalización del evento

  // Constructor de la clase Event
  Event({
    required this.note, // Parámetro requerido: nota del evento
    required this.name, // Parámetro requerido: nombre del evento
    required this.date, // Parámetro requerido: fecha del evento
    required this.startTime, // Parámetro requerido: hora de inicio del evento
    required this.endTime, // Parámetro requerido: hora de finalización del evento
  });
}
