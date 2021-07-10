import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter App To Do List'),
    );
  }
}

class Todo {
  Todo({required this.title, this.isDone = false});

  String title;
  bool isDone;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class NewTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            final todo = new Todo(title: controller.value.text);
            controller.clear();

            Navigator.of(context).pop(todo);
          },
        ),
      ],
    );
  }
}

class SearchTodoDialog extends StatelessWidget {
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Search'),
          onPressed: () {
            final todo = new Todo(title: controller.value.text);
            controller.clear();
            Navigator.of(context).pop(todo);
          },
        ),
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];
  String qSearch = "";

  _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      },
    );

    if (todo != null) {
      setState(() {
        qSearch = "";
        todos.add(todo);
      });
    }
  }

  _searchTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return SearchTodoDialog();
      },
    );

    setState(() {
      qSearch = todo != null ? todo.title : "";
    });
  }

  _onTodoToggle(todo, isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  _deleteTodo() {
    List<Todo> tempTodo = [];
    todos.forEach((e) {
      if (!e.isDone) {
        tempTodo.add(e);
      }
    });
    setState(() {
      todos = tempTodo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 24.0,
              ),
              onPressed: () {
                print('onPressed search action ==============================');
                _searchTodo();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                size: 30.0,
              ),
              onPressed: () {
                print('onPressed delete action ==============================');
                _deleteTodo();
              },
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          if (qSearch != "") {
            if (todo.title.toLowerCase().contains(qSearch.toLowerCase())) {
              return CheckboxListTile(
                value: todo.isDone,
                title: Text(todo.title),
                onChanged: (bool? value) {
                  _onTodoToggle(todo, value);
                },
              );
            }
            return SizedBox();
          }
          return CheckboxListTile(
            value: todo.isDone,
            title: Text(todo.title),
            onChanged: (bool? value) {
              _onTodoToggle(todo, value);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
