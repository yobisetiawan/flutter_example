import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class Todo {
  Todo({required this.title, this.isDone = false});

  String title;
  bool isDone;
}

class MyHomeController extends GetxController {
  var qSearch = "".obs;
  RxList<Todo> todos = RxList<Todo>();

  searchTodo(String q) {
    qSearch(q);
  }

  deleteTodo() {
    todos.forEach((e) {
      if (e.isDone) {
        todos.remove(e);
      }
    });
  }

  addTodo(todo) {
    todos.add(todo);
  }

  onTodoToggle(Todo todo, isChecked) {
    todo.isDone = isChecked;
    int index = todos.indexWhere((element) => element.title == todo.title);
    todos[index] = todo;
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyHomeController c = Get.put(MyHomeController());

    _addTodo() async {
      final todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
          return NewTodoDialog();
        },
      );

      if (todo != null) {
        c.addTodo(todo);
      }
    }

    _searchTodo() async {
      final todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
          return SearchTodoDialog();
        },
      );
      var q = todo != null ? todo.title : "";
      c.searchTodo(q);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App To Do List'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 24.0,
              ),
              onPressed: () {
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
                c.deleteTodo();
              },
            ),
          )
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: c.todos.length,
          itemBuilder: (context, index) {
            final todo = c.todos[index];
            if (c.qSearch() != "") {
              if (todo.title.toLowerCase().contains(c.qSearch.toLowerCase())) {
                return CheckboxListTile(
                  value: todo.isDone,
                  title: Text(todo.title),
                  onChanged: (bool? value) {
                    c.onTodoToggle(todo, value);
                  },
                );
              }
              return SizedBox();
            }
            return CheckboxListTile(
              value: todo.isDone,
              title: Text(todo.title),
              onChanged: (bool? value) {
                c.onTodoToggle(todo, value);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
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
