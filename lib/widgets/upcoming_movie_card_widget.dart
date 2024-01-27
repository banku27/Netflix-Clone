import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_model.dart';

class UpcomingMovieCard extends StatelessWidget {
  final Future<MovieModel> future;
  final String headlineText;
  const UpcomingMovieCard({
    super.key,
    required this.future,
    required this.headlineText,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headlineText,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(3),
                          scrollDirection: Axis.horizontal,
                          itemCount: data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(
                                '$imageUrl${data[index].posterPath}',
                                fit: BoxFit.fitHeight,
                              ),
                            );
                          },
                        ),
                      )
                    ]));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
