import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasil_task/features/cart/presentation/cubit/cart_cubit.dart';

import '../../domain/entites/product_entity.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Icon(Icons.broken_image),
          ),
        ),
        title: Text(product.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            context.read<CartCubit>().addItem(product.toCartEntity());
          },
          child: const Text("Add to Cart"),
        ),
      ),
    );
  }
}
