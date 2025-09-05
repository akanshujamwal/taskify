import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskify/widgets/task_widgets.dart';

import '../data/firestor.dart';

class StreamNote extends StatelessWidget {
  bool done;
  StreamNote(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore_Datasource().stream(done),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final noteslist = Firestore_Datasource().getNotes(snapshot);
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final note = noteslist[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                Firestore_Datasource().delet_note(note.id);
              },
              child: Task_Widget(note),
            );
          },
          itemCount: noteslist.length,
        );
      },
    );
  }
}
