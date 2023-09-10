import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orechanz/pages/widget/checkbox/checkbox_notifier.dart';
/// [checkboxでriverpodを使用した例 ]
class CheckboxExample extends ConsumerWidget {
  const CheckboxExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox Example'),
      ),
       body: Center(
        child: Checkbox(
          value: ref.watch(checkboxNotifierProvider),
          onChanged: (newValue) {
            ref.read(checkboxNotifierProvider.notifier).updateValue(newValue!);
          },
        ),),
    );
  }
}