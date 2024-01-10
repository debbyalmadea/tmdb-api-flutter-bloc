import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_event.dart';
import 'package:flutter_tmdb/features/movie/presentation/pages/home/trending_movies.dart';
import 'package:flutter_tmdb/features/movie/presentation/pages/my_list/my_list.dart';
import 'package:flutter_tmdb/injection_container.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade900),
        useMaterial3: true,
      ),
      home: BlocProvider<RemoteMoviesBloc>(
        create: (context) => sl()..add(const GetMovies()),
        child: Scaffold(
          bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              surfaceTintColor: Colors.white,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              selectedIndex: currentPageIndex,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Ionicons.home_outline),
                  selectedIcon: Icon(Ionicons.home, color: Colors.red.shade900),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: const Icon(Ionicons.search_outline),
                  selectedIcon:
                      Icon(Ionicons.search, color: Colors.red.shade900),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: const Icon(Ionicons.tv_outline),
                  selectedIcon: Icon(Ionicons.tv, color: Colors.red.shade900),
                  label: 'My List',
                ),
              ]),
          body: <Widget>[
            const TrendingMovies(),
            const Center(child: Text('Search')),
            const MyList(),
          ][currentPageIndex],
        ),
      ),
    );
  }
}
