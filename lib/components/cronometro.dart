import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/cronometro_botao.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (_) {
        final titulo = store.estaTrabalhando() ? 'Trabalhando' : 'Descansando';
        final colorStatus = store.estaTrabalhando() ? Colors.red : Colors.green;

        return Container(
          color: colorStatus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(titulo, style: TextStyle(fontSize: 40, color: Colors.white)),
              SizedBox(height: 20),
              Text(
                '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 120,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!store.iniciado)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CronometroBotao(
                        texto: 'Iniciar',
                        icone: Icons.play_arrow,
                        onClick: store.iniciar,
                      ),
                    ),
                  if (store.iniciado)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CronometroBotao(
                        texto: 'Parar',
                        icone: Icons.stop,
                        onClick: store.parar,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CronometroBotao(
                      texto: 'Reiniciar',
                      icone: Icons.refresh,
                      onClick: store.reiniciar,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
