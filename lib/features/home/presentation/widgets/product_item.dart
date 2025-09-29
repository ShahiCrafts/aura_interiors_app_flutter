import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String price;
  final String rating;
  final String reviewCount;
  final String imagePath;

  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // color: Color.fromARGB(255, 240, 240, 240),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Positioned(
                right: 2,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline, color: Colors.red),
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text(
            'NRs. $price',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),

          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Rating + Reviews
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 2),
                  Text(
                    rating,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '$reviewCount Reviews',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),

              Icon(Icons.more_vert, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
