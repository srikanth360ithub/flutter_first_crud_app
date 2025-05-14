import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../widgets/note_form.dart';
import '../screens/notification_screen.dart';
import '../screens/note_detail_screen.dart';
import '../screens/login_screen.dart';
import '../screens/product_list_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = [];

  void _addOrEditNote({Note? note}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => NoteForm(
        note: note,
        onSubmit: (title, description) {
          setState(() {
            if (note == null) {
              _notes.add(Note(
                id: const Uuid().v4(),
                title: title,
                description: description,
              ));
            } else {
              note.title = title;
              note.description = description;
            }
          });
        },
      ),
    );
  }

  void _deleteNote(String id) {
    setState(() {
      _notes.removeWhere((note) => note.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
                      title: const Text('ToDo List'),
                      backgroundColor: Colors.teal,
                      actions: [
                        IconButton(
                          icon: Icon(Icons.notifications),
                          iconSize: 35,
                          padding: const EdgeInsets.only(right: 20),
                          onPressed: () {
                            // Handle notification icon tap
                            // print('Notification icon tapped');
                            Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const NotificationScreen()),
                                      );
                            // You can navigate or show a dialog/snackbar here
                          },
                        ),
                      ],
                    ),

            drawer: Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                                    DrawerHeader(
                                      decoration: BoxDecoration(color: Colors.teal),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/rb_proud_member.png',
                                          width: 100,   // Adjust size as needed
                                          height: 100,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text('Home'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Settings'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Profile'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.notifications),
                              title: Text('Notifications'),
                              onTap: () {
                                // Navigator.pop(context);
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const NotificationScreen()),
                                      );
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.message),
                              title: Text('Messages'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                              ListTile(
                              leading: Icon(Icons.production_quantity_limits),
                              title: Text('Products'),
                              onTap: () {
                                // Navigator.pop(context);
                                 Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ProductListViewScreen()),
                                      );
                              },
                            ),
                            // ListTile(
                            //   leading: Icon(Icons.message),
                            //   title: Text('Messages'),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            // ),
                            ListTile(
                              leading: Icon(Icons.help),
                              title: Text('Help & Support'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.logout),
                              title: Text('Logout'),
                              onTap: () {
                                // Navigator.pop(context);
                                          Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                                  );
                              },
                            ),
                          ],
                        ),
                      ),

            
      body: _notes.isEmpty
          ? const Center(child: Text('No notes added.'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (ctx, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                  onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoteDetailScreen(
                                    title: note.title,
                                    description: note.description,
                                  ),
                                ),
                              );
                            },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit,color: Colors.blue),
                        onPressed: () => _addOrEditNote(note: note),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm Deletion"),
                                content: const Text("Are you sure you want to delete this note?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Delete", style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      _deleteNote(note.id); // Call delete function
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),

                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditNote(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
