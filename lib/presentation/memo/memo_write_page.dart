import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_note/presentation/memo/memo_write_view_model.dart';

class MemoWritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Consumer<MemoWriteViewModel>(
              builder: (context, viewModel, child) {
                return Text(
                  '${viewModel.formattedDate}  ${viewModel.formattedTime}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<MemoWriteViewModel>(
                builder: (context, viewModel, child) {
                  return TextField(
                    controller: viewModel.memoController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '메모 내용을 입력하세요.',
                    ),
                    onChanged: viewModel.updateMemoText,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final viewModel = context.read<MemoWriteViewModel>();
                await viewModel.saveMemo();
                Navigator.pop(context);
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
