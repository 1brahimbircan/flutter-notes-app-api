import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notesapp/constants/constants.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/pages/note_add_page.dart';
import 'package:notesapp/providers/notes_provider.dart';
import 'package:notesapp/widgets/accordion_card.dart';
import 'package:notesapp/widgets/fab_menu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentHeader = "My Notes";
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            currentHeader,
            style: Constants.styleBaslik,
          ),
        ),
        floatingActionButton: const FABMenu(),
        body: (notesProvider.isLoading == false)
            ? SafeArea(
                child: (notesProvider.notes.isNotEmpty)
                    ? ListView(
                        children: [
                          Padding(
                            padding: Constants.h10v5padding,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                              decoration: InputDecoration(hintText: "Search"),
                            ),
                          ),
                          (notesProvider.getFilteredNotes(searchQuery).length > 0)?ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: notesProvider.getFilteredNotes(searchQuery).length,
                            itemBuilder: (context, index) {
                              Note currentNote = notesProvider.getFilteredNotes(searchQuery)[index];
                              // Display note information for each category
                              return Padding(
                                padding: Constants.h10v5padding,
                                child: Slidable(
                                  startActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        backgroundColor: const Color.fromARGB(
                                            43, 117, 117, 117),
                                        icon: Icons.edit,
                                        label: "Düzenle",
                                        onPressed: (context) {
                                          _goUpdateNote(context, currentNote);
                                        },
                                      )
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          backgroundColor: const Color.fromARGB(
                                              35, 250, 17, 0),
                                          icon: Icons.delete,
                                          label: "Sil",
                                          onPressed: (context) {
                                            notesProvider
                                                .deleteNote(currentNote);
                                          },
                                        )
                                      ]),
                                  child: AccordionCard(
                                    note: currentNote,
                                  ),
                                ),
                              );
                            },
                          ):const Padding(padding: Constants.h10v5padding,child: Text("No Notes Found!",textAlign: TextAlign.center,),)
                        ],
                      )
                    : const Center(
                        child: Text("No Notes Yet"),
                      ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _goUpdateNote(BuildContext context, Note note) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => NoteAddPage(
                  isUpdate: true,
                  note: note,
                )))
        .then(
      (value) {
        setState(() {});
      },
    );
  }

  // void _notSil(Note note) {
  //   notesProvider.(note.id!).then(
  //     (silinenID) {
  //       if (silinenID != 0) {
  //         showTopSnackBar(
  //           displayDuration: const Duration(milliseconds: 100),
  //           Overlay.of(context),
  //           const Padding(
  //             padding: EdgeInsets.only(top: 55),
  //             child: CustomSnackBar.error(
  //               icon: Icon(
  //                 Icons.delete,
  //                 size: 100,
  //               ),
  //               message: "Not Silindi",
  //             ),
  //           ),
  //         );
  //         setState(() {});
  //       }
  //     },
  //   );
  // }
}
