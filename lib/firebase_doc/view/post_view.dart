import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orechanz/firebase_doc/model/firebase_provider.dart';

/// [投稿と削除]の画面
class PostView extends ConsumerWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postController = TextEditingController();

    final post = ref.watch(postStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿一覧'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 追加用のダイアログを表示
          await FormDialog(context, postController, ref);
        },
        child: const Icon(Icons.add),
      ),
      body: post.when(
        data: (db) {
          return ListView.builder(
            itemCount: db.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(db[index].body),
                subtitle: Text(db[index].id.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final documentID = db[index].id;
                    await ref
                        .read(firebaseProvider)
                        .collection('post')
                        .doc(documentID)
                        .delete();
                  },
                ),
              );
            },
          );
        },
        error: (e, s) => const Text('エラーです'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }

  // クラスで切り分けることができなかった?
  Future<void> FormDialog(BuildContext context,
      TextEditingController postController, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('投稿'),
          content: TextField(
            controller: postController,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // 投稿ボタンを押したときの処理
                final body = postController.text;
                await ref
                    .read(firebaseProvider)
                    .collection('post')
                    .add({'body': body});
                postController.clear();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('投稿'),
            ),
          ],
        );
      },
    );
  }
}
