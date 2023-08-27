import 'dart:convert';
import 'dart:html';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Utente {
  String name ;
  String surname ;
  var birthDate ;
  String residence ;
  String iban ;
  String documentoID;
  String email ;
  String username ;
  String password ;

  Utente({required this.name, required this.surname, required this.birthDate, required this.residence, required this.iban, required this.documentoID, required this.email, required this.username, required this.password, });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'birthDate': birthDate,
      // Converti la data in formato ISO8601
      'residence': residence,
      'iban': iban,
      'documentoID': documentoID,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _ibanController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  DateTime? _selectedDate;
  String _frontImage = "";
  String _backImage = "";

  final _formKey = GlobalKey<FormState>();

  void _registerUser() async {
    // Esegui qui la registrazione dell'utente con i dati inseriti
    // e le immagini fronte/retro del documento di identità.
    // Puoi accedere ai dati con i controller sopra definiti:
    Utente u = Utente(
    name: _nameController.text,
    surname: _surnameController.text,
    birthDate: _birthDateController.text,
        residence: _addressController.text,
        iban: _ibanController.text,
    documentoID: "AY...",
    email: _emailController.text,
    username: _usernameController.text,
    password: _passwordController.text
    );

    // Esegui qui l'upload delle immagini fronte e retro del documento di identità:

    // operazioni di registrazione dell'utente con i dati sopra acquisiti.
    final String apiUrl = 'http://localhost:8081/utente'; // Sostituisci con l'indirizzo del tuo backend
    //final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: u.toJson(),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registrazione completata con successo!"),
          ),
        );
        print('ID utente creato: $result');
      } else {
        print('Errore durante la creazione dell\'utente.');
      }
    } catch (e) {
      print('Errore durante la connessione al server: $e');
    }

    // Resetta i campi dopo la registrazione
    _nameController.clear();
    _surnameController.clear();
    _birthDateController.clear();
    _addressController.clear();
    _ibanController.clear();
    _emailController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _frontImage = "";
    _backImage = "";

  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Data di partenza per il calendario
      firstDate: DateTime(2000), // Data di inizio selezionabile
      lastDate: DateTime(2100), // Data di fine selezionabile
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:

        Form(
          key: _formKey,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "inserisci un nome";
                  return null;
                },
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nome",
                  border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "inserisci un cognome";
                  return null;
                },
                controller: _surnameController,
                decoration: InputDecoration(
                    hintText: "Cognome",
                    border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                readOnly: true,
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "inserisci un data";
                  return null;
                },
                controller: _birthDateController,
                onTap: _showDatePicker,
                decoration: InputDecoration(
                    hintText: "Data di Nascita",
                    border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "inserisci un indirizzo";
                  return null;
                },
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: "Indirizzo",
                    border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                controller: _ibanController,
                  decoration: InputDecoration(
                      hintText: "IBAN",
                      border: OutlineInputBorder()
                  ),
              ),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "inserisci un Email";
                  return null;
                },
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "inserisci un username";
                  return null;
                },
                controller: _usernameController,
                decoration: InputDecoration(
                    hintText: "username",
                    border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "inserisci un password";
                  return null;
                },
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder()
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate())
                    _registerUser();
                },
                child: Text("Invia"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}