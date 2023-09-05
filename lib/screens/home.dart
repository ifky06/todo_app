import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.toDoList();
  List<ToDo> _filteredList = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _filteredList = todosList;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: tdBGColor,
            child: Column(
              children: [
                searchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'All Todos',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: tdBlack),
                      ),
                    ),
                    for (var todo in _filteredList.reversed)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _handleDeleteItem,
                      ),
                  ],
                ))
              ],
            ),
          ),
          inputFieldToDo(),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _handleDeleteItem(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((todo) => todo.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredList = results;
    });
  }

  Widget inputFieldToDo() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 20, right: 10, bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0.0, 0.0),
                spreadRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _todoController,
            decoration: InputDecoration(
              hintText: 'Add a new task',
              border: InputBorder.none,
            ),
          ),
        )),
        Container(
          margin: EdgeInsets.only(right: 20, bottom: 20),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: tdBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: () {
              _addToDoItem(_todoController.text);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: tdBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints(maxHeight: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGray,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/avatar2.png'),
            ),
          )
        ],
      ),
    );
  }
}
