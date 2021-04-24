class Paginator {
  List<dynamic> pageRange;
  int current;
  int previous;
  int next;

  Paginator(this.pageRange, this.current, this.next, this.previous);

  Paginator.fromMap(Map<String, dynamic> map) {
    pageRange = map["page_range"];
    current = map["current"];
    previous = map["previous"];
    next = map["next"];
  }
}
