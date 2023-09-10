
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orechanz/pages/todo/todo_page.dart';

enum Gender { male, female }

final genderProvider = NotifierProvider<CounterNotifier, Gender>(CounterNotifier.new);

class CounterNotifier extends Notifier<Gender> {
  @override
   build() {
    return Gender.female;
  }

  void updateGender(Gender value) {
    state = value;
  }
}

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      home: TodoPage(),
    );
  }
}

// class Home extends ConsumerWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // ref.watchで、genderProviderを監視
//     final gender = ref.watch(genderProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gender Selection'),
//       ),
//       body: Column(
//         children: <Widget>[
//           // ListTileを使って、RadioListTileを作成
//           ListTile(
//             title: const Text('男性'),
//             leading: Radio<Gender>(
//               value: Gender.male,// ここでenumの値を指定
//               groupValue: gender,// ref.watchで、男性か女性かを監視
//               // ref.readで、updateGenderを呼び出す
//               onChanged: (Gender? value) {
//                 ref.read(genderProvider.notifier).updateGender(value!);
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('女性'),
//             leading: Radio<Gender>(
//               value: Gender.female,// ここでenumの値を指定
//               groupValue: gender,// ref.watchで、男性か女性かを監視
//               onChanged: (Gender? value) {
//                 // ref.readで、updateGenderを呼び出す
//                 ref.read(genderProvider.notifier).updateGender(value!);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }