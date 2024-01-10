abstract class RemoteMoviesEvent {
  const RemoteMoviesEvent();
}

class GetMovies extends RemoteMoviesEvent {
  final int? page;
  final String? sortByOption;

  const GetMovies({this.page, this.sortByOption});
}
