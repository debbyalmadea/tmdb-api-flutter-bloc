import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/config/routes/routes.dart';
import 'package:flutter_tmdb/config/themes/themes.dart';
import 'package:flutter_tmdb/core/widgets/bottom_navigation_bar.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';
import 'package:flutter_tmdb/features/movie/presentation/bloc/movie/remote/remote_movie_event.dart';
import 'package:flutter_tmdb/features/movie/presentation/pages/home/trending_movies.dart';
import 'package:flutter_tmdb/features/movie/presentation/pages/my_list/my_list.dart';
import 'package:flutter_tmdb/injection_container.dart';
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
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: BlocProvider<RemoteMoviesBloc>(
        create: (context) => sl()..add(const GetMovies()),
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              currentPageIndex: currentPageIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
            body: _buildPages()[currentPageIndex],
          ),
        ),
      ),
    );
  }

  void _onDestinationSelected(int? index) {
    setState(() {
      currentPageIndex = index ?? 0;
    });
  }

  List<Widget> _buildPages() {
    return <Widget>[
      const TrendingMovies(),
      const MyList(),
    ];
  }
}
