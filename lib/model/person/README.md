# Freezedとは?
- [Freezed](https://pub.dev/packages/freezed)は、Dartのコードを生成するためのパッケージです。

## Freezedを使うメリット
- データクラスを簡単に作成できる
- データクラスの比較が簡単にできる
- データクラスのコピーが簡単にできる
- データクラスのコンストラクタを簡単に作成できる
- データクラスのコンストラクタを複数作成できる
- データクラスのコンストラクタを名前付きで作成できる


## Freezedを使うデメリット
- データクラスのコンストラクタを複数作
- コンバーターを作成しないと使えないデータ型がある
- 自動生成されないファイルもあるらしい？
  例を出すと、HiveというローカルDBでそんなことがあったのが、Twitterで投稿されていた。

## APIとやりとりするモデルクラスを作成する
**Freezedを使わない例**
このように、toJsonとfromJsonを作成する必要がある。

```dart
class Person {
  final String name;
  final int age;

  Person({this.name, this.age});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}
```

**Freezedを使う例**
このように、Freezedを使うと、toJsonとfromJsonを作成する必要がない。
copyWithも簡単に作成できる。

```dart
@freezed
abstract class Person with _$Person {
  const factory Person({
    String name,
    int age,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) =>
      _$PersonFromJson(json);
}
```