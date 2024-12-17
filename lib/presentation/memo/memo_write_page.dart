import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:time_note/config/ui_style/ui_style.dart';
import 'package:time_note/presentation/memo/memo_write_view_model.dart';

class MemoWritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/memo');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<MemoWriteViewModel>(
              builder: (context, viewModel, child) {
                return Text(
                  '${viewModel.formattedDate}  ${viewModel.formattedTime}',
                  style: UiStyle.h2Style.copyWith(
                    fontSize: 20.sp,
                    color: UiStyle.color[900],
                  ),
                );
              },
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: Consumer<MemoWriteViewModel>(
                builder: (context, viewModel, child) {
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: UiStyle.secondaryColorSurface,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: viewModel.memoController,
                      maxLines: null,
                      style: TextStyle(fontSize: 16.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '메모 내용을 입력하세요.',
                      ),
                      onChanged: viewModel.updateMemoText,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () async {
                final viewModel = context.read<MemoWriteViewModel>();
                await viewModel.saveMemo();
                context.go('/memo');
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.h,
                decoration: BoxDecoration(
                  color: UiStyle.secondaryColorSurface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '저장',
                  style: UiStyle.h2Style.copyWith(
                    fontWeight: FontWeight.bold,
                    color: UiStyle.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
