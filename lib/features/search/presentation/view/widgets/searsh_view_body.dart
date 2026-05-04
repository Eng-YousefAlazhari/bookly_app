import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/search/presentation/view/widgets/custom_text_field.dart';
import 'package:bookly_app/features/search/presentation/view/widgets/search_list_view.dart';
import 'package:flutter/material.dart';

class SearshViewBody extends StatelessWidget {
  const SearshViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(),
          SizedBox(
            height: 12,
          ),
          Text(
            'Search Result',
            style: Styles.textStyle18,
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: SearchListView(),
          ),
        ],
      ),
    );
  }
}
