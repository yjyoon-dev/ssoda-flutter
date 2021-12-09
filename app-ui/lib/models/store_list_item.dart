class StoreListItem {
  final id;
  final name;
  final logo;

  StoreListItem({required this.id, required this.name, required this.logo});

  factory StoreListItem.fromJson(Map<String, dynamic> json) {
    return StoreListItem(
        id: json['id'], name: json['name'], logo: json['logoImagePath']);
  }
}
