import 'package:cinma_app/controllers/saved_screen_layout_controller.dart';
import 'package:cinma_app/widgets/saved_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedScreenLayout extends StatelessWidget {
  const SavedScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedScreenLayoutController>(
      create: (context) => SavedScreenLayoutController(),
      builder: (context, _) {
        var watch = context.watch<SavedScreenLayoutController>();
        var read = context.read<SavedScreenLayoutController>();
        return RefreshIndicator(
          onRefresh: () async {
            read.refreshList();
          },
          child: Center(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return SavedCardWidget(
                  results: watch.savedList![index],
                  onRemoveTap: () {
                    read.deleteFromBookMarks(
                      watch.savedList![index]!.id.toString(),
                    );
                  },
                );
              },
              itemCount: watch.savedList!.length,
            ),
          ),
        );
      },
    );
  }
}
