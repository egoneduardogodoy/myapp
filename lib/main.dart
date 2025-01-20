import 'package:flutter/material.dart';
import 'calculadora.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Desativar o banner de debug
      home: CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  final Calculadora calculadora = Calculadora();
  String _entrada = '';
  String _operador = '';
  String _display = '';
  double _resultado = 0;
  final TextEditingController _controller = TextEditingController();

  void _atualizarEntrada(String entrada) {
    setState(() {
      _entrada += entrada;
      _display += entrada;
      _controller.text = _display;
    });
  }

  void _setOperador(String operador) {
    setState(() {
      if (_entrada.isNotEmpty) {
        _resultado = double.parse(_entrada);
        _entrada = '';
        _operador = operador;
        _display += ' $operador ';
        _controller.text = _display;
      }
    });
  }

  void _calcularResultado() {
    setState(() {
      if (_entrada.isNotEmpty) {
        double num2 = double.parse(_entrada);
        switch (_operador) {
          case '+':
            _resultado = calculadora.adicionar(_resultado, num2);
            break;
          case '-':
            _resultado = calculadora.subtrair(_resultado, num2);
            break;
          case '*':
            _resultado = calculadora.multiplicar(_resultado, num2);
            break;
          case '/':
            _resultado = calculadora.dividir(_resultado, num2);
            break;
        }
        _display = _resultado.toString();
        _controller.text = _display;
        _entrada = '';
        _operador = '';
      }
    });
  }

  void _limpar() {
    setState(() {
      _entrada = '';
      _operador = '';
      _resultado = 0;
      _display = '';
      _controller.clear();
    });
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Calculadora do Eduardo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.right,
              readOnly: true,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  _buildButton('7', () => _atualizarEntrada('7')),
                  _buildButton('8', () => _atualizarEntrada('8')),
                  _buildButton('9', () => _atualizarEntrada('9')),
                  _buildButton('/', () => _setOperador('/')),
                  _buildButton('4', () => _atualizarEntrada('4')),
                  _buildButton('5', () => _atualizarEntrada('5')),
                  _buildButton('6', () => _atualizarEntrada('6')),
                  _buildButton('*', () => _setOperador('*')),
                  _buildButton('1', () => _atualizarEntrada('1')),
                  _buildButton('2', () => _atualizarEntrada('2')),
                  _buildButton('3', () => _atualizarEntrada('3')),
                  _buildButton('-', () => _setOperador('-')),
                  _buildButton('0', () => _atualizarEntrada('0')),
                  _buildButton('C', _limpar),
                  _buildButton('=', _calcularResultado),
                  _buildButton('+', () => _setOperador('+')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
