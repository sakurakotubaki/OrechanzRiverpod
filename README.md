# 🧑‍💻俺ちゃんずドキュメント

## AsyncValueとは?
[AsyncValue Class](https://pub.dev/documentation/riverpod/latest/riverpod/AsyncValue-class.html)

非同期データを安全に操作するためのユーティリティ。

AsyncValue を使用することで、非同期操作のロード/エラー状態の処理を忘れることがないことが保証されます。

また、AsyncValueを別のオブジェクトにうまく変換するためのユーティリティも公開されている。例えば、Flutter WidgetはAsyncValueをプログレスインジケータやエラー画面に変換したり、データを表示したりするのに使うことができる：

Firestoreからデータを取得するプロバイダーを使った例
**使用例**
```dart
// personコレクションの全てのデータを取得するためのStreamProvider
// 普通の書き方。Listを使わない。
final personStreamProvider = StreamProvider((ref) {
  final snapshot = ref.watch(firebaseProvider).collection('person').snapshots();
  return snapshot.map((snapshot) {
    return snapshot.docs.map((doc) => doc.data()).toList();
  });
});

// Listとモデルクラスを使った例
// GPTがこんぶさんみたいなコードを生成した?
final postStreamProvider = StreamProvider<List<Post>>((ref) {
  final snapshot = ref.watch(firebaseProvider).collection('post').snapshots();
  return snapshot.map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;// QueryDocumentSnapshotが取れている。documentIDを取得できる。
      return Post.fromJson(data);
    }).toList();
  });
});

// この書き方する人は多分いない？
// yieldつけると、Pythonだったらメモリの消費が少なくなるらしい
final personStreamProvider = StreamProvider((ref) async* {
  final snapshot =
      await ref.watch(firebaseProvider).collection('person').snapshots();
  yield snapshot.map((snapshot) {
    return snapshot.docs.map((doc) => doc.data()).toList();
  });
});
```

## View側にデータを表示する方法
Listとモデルクラスを使わない例
全部データを取得するだけならこれでもできる。
```dart
class PostReadPage extends ConsumerWidget {
  const PostReadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watchを使うことで、StreamProviderの値を監視することができる
    // データの型はAsyncValue<List<Post>>となる
    final person = ref.watch(personStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿一覧'),
      ),
      // List<Post>を使わないパターン
      body: person.when(
        data: (db) {
          return ListView.builder(
            itemCount: db.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(db[index]['name']),
                subtitle: Text(db[index]['age'].toString()),
              );
            },
          );
        },
        error: (_, __) => const Center(child: Text('エラーが発生しました')),// 引数は、_, __と書くこともできる
        loading: () => const Center(child: CircularProgressIndicator()),
        ),
    );
  }
}
```

## Listとモデルクラスを使った例
次のページに値を渡したい場合があります。そんなときは、Listとモデルクラスが必要です。
onTapを使用すれば次のページに値を渡すことができます。
```dart
class PostReadPage extends ConsumerWidget {
  const PostReadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watchを使うことで、StreamProviderの値を監視することができる
    // データの型はAsyncValue<List<Post>>となる
    final post = ref.watch(postStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿一覧'),
      ),
      // List<Post>を使わないパターン
      body: post.when(
        data: (db) {
          return ListView.builder(
            itemCount: db.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(db[index].body),
              );
            },
          );
        },
        error: (_, __) =>
            const Center(child: Text('エラーが発生しました')), // 引数は、_, __と書くこともできる
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
```

## Notifierのstateとは?

[Notifier Class](https://pub.dev/documentation/riverpod/latest/riverpod/Notifier-class.html)

[state property](https://pub.dev/documentation/riverpod/latest/riverpod/Notifier/state.html)

**日本語に翻訳すると**
この変数を更新すると、すべてのリスナーが同期的に呼び出される。リスナーへの通知は、リスナーの数をNとしてO(N)である。

状態を更新すると、少なくとも1つのリスナーがスローした場合にスローされる。

**わかりやすい解説にすると**

`Notifier`の中にある`state`は、状態を持つ変数のようなものです。`state`が変更されると、`Notifier`はこれに反応して、`Notifier`を購読しているリスナー全てにその変更を通知します。この通知の仕組みにより、UIや他のコンポーネントは`state`の変更を即座に知り、必要なアクションを取ることができます。

例を考えてみましょう。ショッピングアプリでカートの中身を管理する`Notifier`があるとします。ユーザーが商品をカートに追加すると、その`Notifier`の`state`が更新されます。すると、購読しているすべてのリスナー（例えばカートのアイコンや合計金額を表示するウィジェット）はこの変更を受け取り、UIが自動的に更新されます。

ただし、リスナーの中にはエラーをスローするものがあるかもしれません。もし`state`の変更に応じて1つ以上のリスナーがエラーをスローした場合、そのエラーは`Notifier`からもスローされます。このため、エラーハンドリングを適切に行うことが重要です。

要するに、`Notifier`の`state`はアプリケーションの状態を表し、この状態が変わると購読している全てのリスナーにその変更が伝わります。

## まとめ
- stateとは、状態を持っている変数
- リスナーとは例を出すと、アイコンや数字を表示するWidget