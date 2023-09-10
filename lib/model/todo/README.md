## copyWithを使用した例
copyWithとは何かというと、コンストラクタで作成したインスタンスをコピーして、一部の値を変更したインスタンスを作成することができる。

**Freezedを使用しないで使用する場合**
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