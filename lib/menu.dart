import 'menu_item.dart'; 
import 'pizza_data.dart';
import 'package:flutter/material.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Pizza> pizzasSelecionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pizza menu"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: pizzaData.map((pizza) {
                  return MenuItem(
                    pizza: pizza,
                    selecionado: pizzasSelecionadas.contains(pizza),
                    onTap: () => _selecionarPizza(pizza),
                  );
                }).toList(),
              ),
            ),
          ),
          if (isOpen())
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: pizzasSelecionadas.isEmpty ? null : _fazerPedido,
                child: Text("Order Now!"),
              ),
            ),
        ],
      ),
    );
  }

  bool isOpen() {
    var horaInicial = 00;
    var horaFinal = 24;
    var horaAtual = DateTime.now().hour;

    return horaAtual >= horaInicial && horaAtual < horaFinal;
  }

  void _selecionarPizza(Pizza pizza) {
    setState(() {
      if (pizzasSelecionadas.contains(pizza)) {
        pizzasSelecionadas.remove(pizza);
      } else {
        if (!pizza.soldOut) { // só deixa selecionar se não estiver esgotada
          pizzasSelecionadas.add(pizza);
        }
      }
    });
  }

  void _fazerPedido() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pedido Realizado!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: pizzasSelecionadas.map((pizza) => Text(pizza.name)).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  pizzasSelecionadas.clear(); // limpa depois do pedido
                });
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
