import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/overall.dart';
import '../Classes/payment_method.dart';
import '../Classes/vault.dart';
import '../Classes/transaction.dart';
import 'package:flutter/services.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'deposit-dialog.dart';

class DepositPage extends StatefulWidget {
  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final _formKey = GlobalKey<FormState>();
  PaymentMethod? _selectedPaymentMethod; // Keep track of payment method that user selects
  Vault? _selectedVault; // Keep track of vault that user selects
  final TextEditingController _amountController = TextEditingController(); // Keeps track of amount user enters
  List<Map<String, dynamic>> _recentTransactions = [];

  @override
  Widget build(BuildContext context) {
    final overall = Provider.of<Overall>(context);
    final paymentMethods = overall.userInfo.getPaymentMethods();
    final vaults = overall.getListVaults();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/emback.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white), // Back arrow icon color
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Color(0xFF3852C7)],
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF020629),
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  width: 360,
                  height: 650,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          // Dropdown for payment method
                          DropdownButtonFormField<PaymentMethod>(
                            decoration: InputDecoration(
                              labelText: 'Select Payment Method',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            items: paymentMethods.map((PaymentMethod method) {
                              return DropdownMenuItem<PaymentMethod>(
                                value: method,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF4457B1), Color(0xFFA91CB3)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    '************ ${method.getCardNumber().substring(method.getCardNumber().length - 4)}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (PaymentMethod? newValue) {
                              setState(() {
                                _selectedPaymentMethod = newValue;
                              });
                            },
                            validator: (value) => value == null ? 'Please select a payment method' : null,
                          ),
                          SizedBox(height: 16),

                          // Enter amount to deposit
                          TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: 'Amount Desired (\$00.00)',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Dropdown for vault
                          DropdownButtonFormField<Vault>(
                            decoration: InputDecoration(
                              labelText: 'Select Vault',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            items: vaults.map((Vault vault) {
                              return DropdownMenuItem<Vault>(
                                value: vault,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF4457B1), Color(0xFFA91CB3)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(vault.getName(), style: TextStyle(color: Colors.white)),
                                      Icon(
                                        vault.isLocked ? Icons.lock : Icons.lock_open,
                                        color: vault.isLocked ? Colors.red : Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (Vault? newValue) {
                              setState(() {
                                _selectedVault = newValue;
                              });
                            },
                            validator: (value) => value == null ? 'Please select a vault' : null,
                          ),
                          SizedBox(height: 16),

                          // Deposit Action button
                          MouseRegion(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF4457B1), Color(0xFFA91CB3)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF020629),
                                    blurRadius: 8.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),

                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DepositDialog(
                                          amountController: _amountController,
                                          selectedPaymentMethod: _selectedPaymentMethod,
                                          selectedVault: _selectedVault,
                                          recentTransactions: _recentTransactions,
                                        );
                                      },
                                    ).then((updatedTransactions) {
                                      if (updatedTransactions != null) {
                                        setState(() {
                                          _recentTransactions = updatedTransactions;
                                        });
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  'Deposit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32),

                          // ALL RECENT TRANSACTIONS DEPOSITS
                          Text(
                            'Recent Activity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),

                          // Recent transactions
                          Container(
                            height: 200, // Adjust the height as needed
                            child: ListView(
                              children: [
                                ...overall.getDepositTransactions().map((transaction) {
                                  return ListTile(
                                    leading: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction.getVaultName(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '************ ${transaction.getPaymentMethodCardNumber().substring(transaction.getPaymentMethodCardNumber().length - 4)}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '\$${transaction.getAmount().toStringAsFixed(2)}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(Icons.add, color: Colors.green),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Title
            Positioned(
              top: 0,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Deposit',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    'Instant+',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}