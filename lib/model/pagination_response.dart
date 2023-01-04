class PaginationResponse<T> {
  PaginationResponse({
    required this.data,
    this.meta,
  });

  final T data;
  final PaginationMeta? meta;
}

class PaginationMeta {
  PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
  });

  final int currentPage;
  final int lastPage;
  final int perPage;

  PaginationMeta.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        lastPage = json['last_page'],
        perPage = json['per_page'];

  bool hasNextPage() {
    return lastPage > currentPage;
  }

  int getNextPage() {
    return currentPage + 1;
  }

  int getLengthToCurrentPage() {
    return perPage * currentPage;
  }
}
