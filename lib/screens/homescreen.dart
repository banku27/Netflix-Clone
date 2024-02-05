import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:netflix_clone/screens/search_screen.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/custom_carousel.dart';
import 'package:netflix_clone/widgets/upcoming_movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices apiServices = ApiServices();

  late Future<MovieModel> upcomingFuture;
  late Future<MovieModel> nowPlaying;
  late Future<TvSeriesModel> topRatedShows;

  @override
  void initState() {
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlaying = apiServices.getNowPlayingMovies();
    topRatedShows = apiServices.getTopRatedSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              onTap: () {},
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<TvSeriesModel>(
              future: topRatedShows,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomCarouselSlider(data: snapshot.data!);
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: UpcomingMovieCard(
                future: nowPlaying,
                headlineText: 'Now Playing',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: UpcomingMovieCard(
                future: upcomingFuture,
                headlineText: 'Upcoming Movies',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
