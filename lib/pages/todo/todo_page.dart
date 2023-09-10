import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orechanz/model/todo/todo.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  // Freezedはimuutableなので、copyWithで値を変更する
  var todos = const Todo(isDone: false).copyWith(task: '米を買う', count: 2);

  @override
  void initState() {
    // ページが呼ばれたら、todosの変数のデータをログに出す。
    print(todos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('copyWithを使う'),
      ),
      body: Center(
        child: Column(
          children: [
            // 上書きした値を表示
            Text(todos.isDone.toString()),
            Text(todos.task),
            Text(todos.count.toString()),
          ],
        ),
      ),
    );
  }
}
