class ToDo {
  String? id;
  String? todoText;
  bool? isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> toDoList() {
    return [
      ToDo(
        id: '1',
        todoText: 'Buy Milk',
        isDone: true,
      ),
      ToDo(
        id: '2',
        todoText: 'Buy Eggs',
        // isDone: false,
      ),
      ToDo(
        id: '3',
        todoText: 'Buy Bread',
        // isDone: false,
      ),
    ];
  }
}
