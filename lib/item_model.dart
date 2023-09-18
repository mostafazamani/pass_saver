class ItemModel {

  final String name;
  final String username;
  final String pass;

  const ItemModel({required this.name,required this.username,required this.pass});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'pass': pass
    };
  }
  @override
  String toString() {
    return 'Item{name: $name, username: $username, pass: $pass}';
  }

}