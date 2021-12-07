class ImageDao {
  final int? id;
  final String? imageUrl;

  ImageDao({required this.id, required this.imageUrl});

  Map<String, dynamic> toJson() {
    return {'id': id, 'imageUrl': imageUrl};
  }

  ImageDao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageUrl = json['imageUrl'];
}
