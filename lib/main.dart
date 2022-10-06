import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

  List<String> todoList = [];
  String taskInput = "";

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo List App",
          style: TextStyle(fontFamily: "Robot"),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add new Todo"),
                  content: TextField(
                    onChanged: (String task) {
                      taskInput = task;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueGrey),
                      ),
                      onPressed: () {
                        setState(() {
                          todoList.add(taskInput);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Add'),
                    )
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: Text(todoList[index]),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  Checkbox(
                    value: check,
                    // checkColor: Colors.white,
                    activeColor: Colors.green,
                    onChanged: (value){
                      setState(() {
                        check = value!;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        todoList.removeAt(index);
                      });
                    },
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
