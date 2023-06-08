abstract class SearchEvent {}

class Search extends SearchEvent {
  String searchText;
  Search(this.searchText);
}
