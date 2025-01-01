import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printing Press Payment System'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/hp_back.jpg'), // backgroung image
            fit: BoxFit.cover,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Make Payment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black54,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Expanded(
                child: PaymentForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final TextEditingController _photocopyController = TextEditingController();
  final TextEditingController _laminationController = TextEditingController();
  final TextEditingController _shirtPrintingController = TextEditingController();
  final TextEditingController _mugPrintingController = TextEditingController();

  double _totalCost = 0.0;

  // Fixed rates for each service
  final double photocopyRate = 1.5;  // GH₵1.50 per photocopy
  final double laminationRate = 3.0;  // GH₵3.00 per lamination
  final double shirtPrintingRate = 50.0;  // GH₵50.00 per shirt printing
  final double mugPrintingRate = 30.0;  // GH₵30.00 per mug printing

  void _calculateTotalCost() {
    final int? photocopies = int.tryParse(_photocopyController.text);
    final int? laminations = int.tryParse(_laminationController.text);
    final int? shirts = int.tryParse(_shirtPrintingController.text);
    final int? mugs = int.tryParse(_mugPrintingController.text);

    setState(() {
      _totalCost = (photocopies ?? 0) * photocopyRate +
          (laminations ?? 0) * laminationRate +
          (shirts ?? 0) * shirtPrintingRate +
          (mugs ?? 0) * mugPrintingRate;
    });
  }

  void _makePayment() {
    if (_totalCost > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment of GH₵${_totalCost.toStringAsFixed(2)} successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please calculate the total cost first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select Items and Enter Quantities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Photocopy Input
              TextField(
                controller: _photocopyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Photocopies (GH₵1.50 each)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.print),
                ),
              ),
              const SizedBox(height: 16),
              // Lamination Input
              TextField(
                controller: _laminationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Lamination (GH₵3.00 each)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.folder), // Updated icon
                ),
              ),
              const SizedBox(height: 16),
              // Shirt Printing Input
              TextField(
                controller: _shirtPrintingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Shirt Printing (GH₵50.00 each)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.print),
                ),
              ),
              const SizedBox(height: 16),
              // Mug Printing Input
              TextField(
                controller: _mugPrintingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Mug Printing (GH₵30.00 each)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_cafe),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateTotalCost,
                child: const Text('Calculate Total Cost'),
              ),
              const SizedBox(height: 20),
              Text(
                'Total Cost: GH₵${_totalCost.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _makePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('Make Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
