class ProductEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final String image;
  final RatingEntity rating;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.image,
    required this.rating,
  });
}

class RatingEntity {
  final double rate;
  final int count;

  const RatingEntity({
    required this.rate,
    required this.count,
  });
}