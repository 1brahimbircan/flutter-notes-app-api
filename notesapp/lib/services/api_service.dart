import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:dio/dio.dart';

class ApiService {
  // ignore: prefer_final_fields
  static String _baseUrl =
      "https://notesapp-backend-alpha.vercel.app/notes";

  static Dio dio = Dio();

  static Future<void> addNote(Note note) async {
    try {
      Response response = await dio.post(
        "$_baseUrl/add",
        data: note.toMap(),
      );

      // Check the HTTP response code
      if (response.statusCode == 200) {
        var decoded = response.data;
        debugPrint(decoded.toString());
      } else {
        debugPrint("An error occurred: ${response.statusMessage}");
        // Show appropriate feedback to the user
      }
    } catch (e) {
      debugPrint("Connection timed out or an error occurred: $e");
      // Show appropriate feedback to the user
    }
  }

  static Future<void> deleteNote(Note note) async {
    try {
      Response response = await dio.post(
        "$_baseUrl/delete",
        data: note.toMap(),
      );

      // Check the HTTP response code
      if (response.statusCode == 200) {
        var decoded = response.data;
        debugPrint(decoded.toString());
      } else {
        debugPrint("An error occurred: ${response.statusMessage}");
        // Show appropriate feedback to the user
      }
    } catch (e) {
      debugPrint("Connection timed out or an error occurred: $e");
      // Show appropriate feedback to the user
    }
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    try {
      Response response = await dio.post(
        "$_baseUrl/list",
        data: {"userid": userid},
      );

      // Check the HTTP response code
      if (response.statusCode == 200) {
        var decoded = response.data;

        List<Note> notes = [];
        for (var noteMap in decoded) {
          Note newNote = Note.fromMap(noteMap);
          notes.add(newNote);
        }
        return notes;
      } else {
        debugPrint("An error occurred: ${response.statusMessage}");
        // Show appropriate feedback to the user
        return []; // Return an empty list
      }
    } catch (e) {
      debugPrint("Connection timed out or an error occurred: $e");
      // Show appropriate feedback to the user
      return []; // Return an empty list
    }
  }
}
