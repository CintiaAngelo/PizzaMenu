import 'package:flutter/material.dart';
import 'pizza_data.dart';

class MenuItem extends StatelessWidget {
  final Pizza pizza;
  final bool selecionado;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.pizza,
    required this.selecionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: selecionado ? Colors.yellow[100] : null, // muda a cor se selecionado
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ColorFiltered(
                colorFilter: pizza.soldOut
                    ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
                    : ColorFilter.mode(Colors.transparent, BlendMode.saturation),
                child: Image.asset(
                  "images/${pizza.photoName}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pizza.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      pizza.ingredients,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      pizza.soldOut ? "Sold Out" : "\$${pizza.price}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
