import 'package:cinma_app/models/results.dart';
import 'package:cinma_app/constants/constants.dart';
import 'package:cinma_app/router/router.dart';
import 'package:flutter/material.dart';

class SavedCardWidget extends StatelessWidget {
  const SavedCardWidget({
    super.key,
    this.results,
    this.onRemoveTap,
  });
  final Results? results;
  final void Function()? onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouter.viewMovie, arguments: {
          'results': results,
        });
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(
          12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: results!.backdrop_path != null
                      ? Image.network(
                          results!.backdrop_path!.toNetworkImagePath(),
                        )
                      : Image.asset(
                          "assets/images/cinema_logo.png",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        (results!.title ?? results!.name ?? "").toUpperCase(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: Constants.POPPINS,
                            ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onRemoveTap,
                      splashRadius: 20,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
