part of 'search_cubit.dart';

enum SearchStatus { initial, loading, loaded, error }

@immutable
class SearchState extends Equatable {
  final List<User> users;
  final SearchStatus status;
  final Failure failure;

factory SearchState.initial(){
  return const SearchState(users: [], status: SearchStatus.initial, failure: Failure());
}

  const SearchState(
      {@required this.users, @required this.status, @required this.failure});

  @override
  List<Object> get props => [users,status,failure];

  SearchState copyWith({
    final List<User> users,
    final SearchStatus status,
    final Failure failure,
  }) {
    return SearchState(
      users: users ?? this.users,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}

