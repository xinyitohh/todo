import 'package:flutter/material.dart';
import '../widgets/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {



  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todolist = [];
  List<ToDo> filteredList = [];

  TextEditingController taskController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList=todolist;
  }

  void filterTasks(String query){
    List<ToDo> results = [];
    if (query.isEmpty){
      results = todolist;
    } else {
      results = todolist
      .where((todo) => todo.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
      .toList();
    }
    setState(() {
      filteredList = results;
    });
  }

    void addTask(){
    if (taskController.text.isNotEmpty){
      setState(() {
        todolist.add(ToDo(
          id: DateTime.now().toString(),
          title: taskController.text,
          isDone: false,
        ));
        taskController.clear();
      });
    }
  }

  void toggleTask(String id){
    setState(() {
      final task = todolist.firstWhere((todo) => todo.id == id);
      task.isDone = !task.isDone;
    });
  }

  void deleteTask(String id){
    setState(() {
      todolist.removeWhere((todo) => todo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeeeff5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBar(),
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " All ToDos",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(children: filteredList.reversed.map((todo) => 
                  ToDoItem(
                    todo: todo, 
                    onToggle: toggleTask, 
                    onDelete: deleteTask)
                    ).toList()
                  ),
                ),
                addBar(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget addBar() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Row(children: [
      Expanded(
        child: TextField(
          controller: taskController,
          decoration: InputDecoration(
            hintText: 'Add a new task',
            //prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      const SizedBox(width: 10),
      Container(
        height: 47,
        width: 47,
        decoration: BoxDecoration(
            color: Color(0xFF6054ee), borderRadius: BorderRadius.circular(10)),
        child: IconButton(
            onPressed: addTask,
             icon: Icon(Icons.add), color: Colors.white),
      )
    ]),
  );
}

Widget searchBar() {
  return TextField(
    controller: searchController,
    onChanged: (value) => filterTasks(value),
    decoration: InputDecoration(
      hintText: 'Search',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}

}




