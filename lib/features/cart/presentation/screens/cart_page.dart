import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item.dart';
import '../cubit/cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              context.read<CartCubit>().clearCart();
            },
            tooltip: 'Clear All',
          )
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final items = state.items;
            final totalPrice = items.fold<double>(
              0,
                  (sum, item) => sum + (item.price * item.quantity),
            );

            if (items.isEmpty) {
              return const Center(child: Text('Your cart is empty.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(item.image, width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$${item.price.toStringAsFixed(2)}'),
                              Text('Total: \$${item.total.toStringAsFixed(2)}'),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () => context.read<CartCubit>().decreaseQuantity(item.productId),
                                      ),
                                      Text('${item.quantity}'),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () => context.read<CartCubit>().increaseQuantity(item.productId),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing:                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => context.read<CartCubit>().removeItem(item.productId),
                              ),

                        ),
                      );
                    },
                  ),
                ),
                const Divider(thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Items:', style: TextStyle(fontSize: 16)),
                          Text('${items.length}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Price:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('\$${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Checkout not implemented yet')),
                            );
                          },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }

          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
