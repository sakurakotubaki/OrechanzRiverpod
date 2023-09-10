## copyWithを使用した例
copyWithとは何かというと、コンストラクタで作成したインスタンスをコピーして、一部の値を変更したインスタンスを作成することができる。

Freezedを使用しないで使用する場合
このように書かないといけない。
```dart
class Todo {
  String task;
  int count;
  bool isDone;
  Todo({
    required this.task,
    required this.count,
    required this.isDone,
  });

  Todo copyWith({
    String? task,
    int? count,
    bool? isDone,
  }) {
    return Todo(
      task: task ?? this.task,
      count: count ?? this.count,
      isDone: isDone ?? this.isDone,
    );
  }
}
```

**Freezedを使用して使用する場合**
最初からいい感じで、toJsonとfromJsonが作成されている。
copyWithも簡単に使える。
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

// flutter pub run build_runner watch
/* 動画撮影しているときは、なぜかboolで@Defaultの設定できなかった?
コード修正して、コマンドをもう一度実行したら、boolで@Defaultの設定できた。
*/
@freezed
class Todo with _$Todo {
  const factory Todo({
    @Default('') String task,
    @Default(0) int count,
    @Default(false) bool isDone,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json)
      => _$TodoFromJson(json);
}
```

## copyWithを使う
全部の値をインスタンス化したクラスに代入せずに、一部の値だけを変更したインスタンスを作成することができる。
```dart
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
  var todos = const Todo().copyWith(task: '米を買う', count: 2);

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
```

## まとめ
仕事で使った例を出すと、入力フォームでonChangedを使った箇所で、copyWithを使って特定のプロパティだけを変更して、入力フォームの値を変更していましたね。