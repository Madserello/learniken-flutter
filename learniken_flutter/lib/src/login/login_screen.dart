import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learniken_flutter/src/login/login_service.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String ulrikenLogo = 'assets/images/AlternateUlrikenLogo.svg';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // Alltid dispose controllers for å spare ressurser
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() {
      _isLoading = true;
    });

    // Kaller servicen vår
    final success = await LoginService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Naviger til profile screen om oki doki
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/auth');
    } else {
      // Roast brukeren om feil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Woopsie, prøv igjen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          ulrikenLogo,
          height: 50,
          semanticsLabel: 'Ulriken logo',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Epost',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Vennligst oppgi epost'
                    : null,
              ),
              const SizedBox(height: 16.0),
              // Password Input Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Passord',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Vennligst oppgi passord'
                    : null,
              ),
              const SizedBox(height: 32.0),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          minimumSize: Size(200, 50)),
                      onPressed: _login,
                      child: const Text('Logg inn'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
