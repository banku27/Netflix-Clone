import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/screens/movie_detailed_screen.dart';
import 'package:netflix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  SearchModel? searchedMovie;

  void search(String query) {
    apiServices.getSearchedMovie(query).then((results) {
      setState(() {
        searchedMovie = results;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CupertinoSearchTextField(
              controller: searchController,
              padding: const EdgeInsets.all(10.0),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              style: const TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.withOpacity(0.3),
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  search(searchController.text);
                }
              },
            ),
            searchedMovie == null
                ? const SizedBox.shrink()
                : Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: searchedMovie?.results.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1.5 / 2,
                      ),
                      itemBuilder: (context, index) {
                        return searchedMovie!.results[index].backdropPath ==
                                null
                            ? Image.asset("assets/netflix.png")
                            : InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                          movieId:
                                              searchedMovie!.results[index].id),
                                    ),
                                  );
                                },
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '$imageUrl${searchedMovie?.results[index].backdropPath}',
                                ),
                              );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
