import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

enum TipoIntervalo { trabalho, descanso }

abstract class _PomodoroStore with Store {
  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;

  @observable
  bool iniciado = false;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.trabalho;

  Timer? cronometro;

  @action
  void incrementarTempoTrabalho() {
    tempoTrabalho++;

    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoTrabalho() {
    tempoTrabalho--;

    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void incrementarTempoDescanso() {
    tempoDescanso++;

    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempoDescanso() {
    tempoDescanso--;

    if (estaDescansando()) {
      reiniciar();
    }
  }

  @action
  void iniciar() {
    iniciado = true;

    cronometro = Timer.periodic(Duration(seconds: 1), (timer) {
      if (minutos == 0 && segundos == 0) {
        _trocarTipoIntervalo();
      } else if (minutos > 0 && segundos == 0) {
        segundos = 59;
        minutos--;
      } else {
        segundos--;
      }
    });
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();

    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  bool estaTrabalhando() {
    return tipoIntervalo == TipoIntervalo.trabalho;
  }

  bool estaDescansando() {
    return tipoIntervalo == TipoIntervalo.descanso;
  }

  void _trocarTipoIntervalo() {
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.descanso;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.trabalho;
      minutos = tempoTrabalho;
    }

    segundos = 0;
  }
}

class PomodoroStore = _PomodoroStore with _$PomodoroStore;
