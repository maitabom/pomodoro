import 'package:flutter/material.dart';

class EntradaTempo extends StatelessWidget {
  final String titulo;
  final int valor;
  final void Function()? incremento;
  final void Function()? decremento;

  const EntradaTempo({
    super.key,
    required this.titulo,
    required this.valor,
    this.incremento,
    this.decremento,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(titulo, style: TextStyle(fontSize: 25)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: decremento,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                backgroundColor: Colors.red,
              ),
              child: Icon(Icons.arrow_downward, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text('${valor.toString()} min', style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: incremento,
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                backgroundColor: Colors.red,
              ),
              child: Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
