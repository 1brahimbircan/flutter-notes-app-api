import 'package:flutter/material.dart';
import 'package:notesapp/constants/constants.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

class NoteAddPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const NoteAddPage({super.key, required this.isUpdate, this.note});

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String? _selectedCategory;
  String? _selectedPriority;
  String? noteTitle, noteContent;
  final List<String> _priorityList = ["Low", "Middle", "High"];
  final List<String> _categoryList = ["School", "Work", "Sport"];

  void addNewNote() {
    if (titleController.text != '' &&
        _selectedCategory != null &&
        _selectedPriority != null) {
      Note newNote = Note(
        id: const Uuid().v1(),
        userid: "1brahimbircan",
        category: _selectedCategory!,
        priority: _selectedPriority!,
        title: titleController.text,
        content: contentController.text,
        dateadded: DateTime.now(),
      );
      Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
      Navigator.pop(context);
    } else {
      showTopSnackBar(
        displayDuration: const Duration(milliseconds: 100),
        Overlay.of(context),
        const Padding(
          padding: EdgeInsets.only(top: 55),
          child: CustomSnackBar.error(
            message: "Please fill in all the required fields.",
          ),
        ),
      );
    }
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.category = _selectedCategory;
    widget.note!.priority = _selectedPriority;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
      _selectedCategory = widget.note!.category!;
      _selectedPriority = widget.note!.priority!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.isUpdate) {
            updateNote();
          } else {
            addNewNote();
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        splashColor: Colors.white,
        child: const Icon(
          color: Colors.black,
          Icons.done,
          size: 30,
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: Constants.h10v5padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _buildCategory()),
                    const SizedBox(width: 10),
                    Expanded(child: _buildPriority()),
                  ],
                ),
              ),
              _buildNoteTitle(),
              _buildNoteContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          menuMaxHeight: 200,
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Category"),
          ),
          items: _categoryList.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child:
                  Padding(padding: Constants.h10v5padding, child: Text(item)),
            );
          }).toList(),
          value: _selectedCategory,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildPriority() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("Priority"),
          ),
          itemHeight: 50,
          items: _priorityList.map((priority) {
            return DropdownMenuItem<String>(
              value: priority,
              child: Padding(
                padding: Constants.h10v5padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,
                        size: 15,
                        color: _priorityColorDefine(
                            _priorityList.indexOf(priority))),
                    const SizedBox(width: 5),
                    Text(priority),
                  ],
                ),
              ),
            );
          }).toList(),
          value: _selectedPriority,
          onChanged: (newValue) {
            setState(() {
              _selectedPriority = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildNoteTitle() {
    return Padding(
      padding: Constants.h10v5padding,
      child: TextFormField(
        controller: titleController,
        validator: (text) {
          if (text!.length < 3) {
            return "Must be at least 3 characters";
          }
          return null;
        },
        onSaved: (text) {
          noteTitle = text;
        },
        decoration: const InputDecoration(
            hintText: "enter note title.",
            labelText: "Title",
            border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildNoteContent() {
    return Padding(
      padding: Constants.h10v5padding,
      child: TextFormField(
        controller: contentController,
        onSaved: (text) {
          noteContent = text;
        },
        maxLines: 15,
        decoration: const InputDecoration(
            hintMaxLines: 1,
            hintText: "enter note content.",
            labelText: "Content",
            border: OutlineInputBorder()),
      ),
    );
  }

  Color? _priorityColorDefine(int oncelik) {
    var renk = Colors.white;
    if (oncelik == 0) {
      renk = const Color.fromARGB(255, 0, 255, 9);
      return renk;
    } else if (oncelik == 1) {
      renk = Colors.amber;
      return renk;
    } else if (oncelik == 2) {
      renk = Colors.red;
      return renk;
    }
    return renk;
  }
}
