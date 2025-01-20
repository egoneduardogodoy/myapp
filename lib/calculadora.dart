class Calculadora {
  double adicionar(double a, double b) => a + b;

  double subtrair(double a, double b) => a - b;

  double multiplicar(double a, double b) => a * b;

  double dividir(double a, double b) {
    if (b == 0) {
      throw ArgumentError("Divisão por zero não é permitida");
    }
    return a / b;
  }
}
