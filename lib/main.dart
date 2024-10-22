import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Aplicația principală MyApp
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator', // Titlul aplicației
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema principală
      ),
      home: const LoanCalculator(), // Widget-ul principal al aplicației
    );
  }
}

// Widget-ul LoanCalculator
class LoanCalculator extends StatefulWidget {
  const LoanCalculator({Key? key}) : super(key: key);

  @override
  _LoanCalculatorState createState() => _LoanCalculatorState(); // Starea widget-ului
}

// Starea pentru LoanCalculator
class _LoanCalculatorState extends State<LoanCalculator> {
  double amount = 0; // Variabila pentru suma împrumutului
  int months = 1; // Variabila pentru numărul de luni
  double interest = 0; // Variabila pentru procentul de dobândă
  double result = 0; // Variabila pentru rezultatul calculului

  // Funcția de calcul al împrumutului
  void calculateLoan() {
    // Verificăm dacă valorile sunt valide
    if (amount <= 0 || interest <= 0 || months <= 0) {
      setState(() {
        result = 0; // Resetăm rezultatul
      });
      // Afișăm un dialog de eroare
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text("Please enter values greater than 0."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Închide dialogul
                },
              ),
            ],
          );
        },
      );
    } else {
      // Calculăm rezultatul împrumutului
      setState(() {
        result = (amount * (1 + (interest / 100) * months)) / months; // Formula de calcul
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fundal alb pentru AppBar
        elevation: 0, // Fără umbră
        toolbarHeight: 0, // Fără înălțime a toolbar-ului
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0), // Padding general
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aliniere la stânga
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Loan calculator', // Titlul aplicației
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Enter amount', // Eticheta pentru sumă
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number, // Permite introducerea numerelor
              decoration: InputDecoration(
                hintText: 'Amount', // Hint pentru câmp
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounding corners
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 0; // Parsează suma
                });
              },
            ),
            const SizedBox(height: 25),
            const Text(
              'Enter number of months', // Eticheta pentru numărul de luni
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Slider(
              value: months.toDouble(), // Valoarea curentă a slider-ului
              min: 1, // Valoarea minimă
              max: 60, // Valoarea maximă
              divisions: 59, // Numărul de diviziuni
              label: "$months luni", // Eticheta slider-ului
              activeColor: Colors.blue[800], // Culoarea activă
              inactiveColor: Colors.grey, // Culoarea inactivă
              onChanged: (value) {
                setState(() {
                  months = value.toInt(); // Actualizează numărul de luni
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuirea în spațiu
              children: const [
                Text('1', style: TextStyle(color: Colors.grey)), // Eticheta pentru minim
                Text('60 luni', style: TextStyle(color: Colors.grey)), // Eticheta pentru maxim
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Enter % per month', // Eticheta pentru procentul de dobândă
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number, // Permite introducerea numerelor
              decoration: InputDecoration(
                hintText: 'Percent', // Hint pentru câmp
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounding corners
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  interest = double.tryParse(value) ?? 0; // Parsează procentul
                });
              },
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity, // Lățimea maximă
              padding: const EdgeInsets.all(20), // Padding interior
              decoration: BoxDecoration(
                color: Colors.grey[300], // Fundal pentru text
                borderRadius: BorderRadius.circular(10), // Rounding corners
                border: Border.all(color: Colors.grey[100]!),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'You will pay the approximate amount monthly:', // Text informativ
                    style: TextStyle(
                      fontSize: 30, // Dimensiune ajustată
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity, // Lățimea maximă
                    padding: const EdgeInsets.all(10), // Padding interior
                    decoration: BoxDecoration(
                      color: Colors.white, // Fundal alb pentru suma
                      border: Border.all(color: Colors.grey[100]!), // Contur pentru suma
                      borderRadius: BorderRadius.circular(5), // Rounding corners
                    ),
                    child: Text(
                      '${result.toStringAsFixed(2)}€', // Afișarea rezultatului
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700], // Culoarea textului
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: SizedBox(
                width: double.infinity, // Face butonul să ocupe întreaga lățime
                child: ElevatedButton(
                  onPressed: calculateLoan, // Apelează funcția de calcul
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700], // Culoarea de fundal a butonului
                    padding: const EdgeInsets.symmetric(vertical: 15), // Padding vertical
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounding corners
                    ),
                  ),
                  child: const Text(
                    'Calculate', // Textul butonului
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Culoarea textului
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
