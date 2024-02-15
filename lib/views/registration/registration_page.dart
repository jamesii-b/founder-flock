import 'package:FounderFlock/viewmodels/registration_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: _isLoading ? _buildLoadingIndicator() : _buildRegistrationForm(),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _performRegistration,
            child: Text('Register'),
          ),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/login');
              },
              child: const Text('Login')),
        ],
      ),
    );
  }

  Future<void> _performRegistration() async {
    setState(() {
      _isLoading = true;
    });

    final viewModel = RegistrationViewModel();
    final result = await viewModel.register(
        _emailController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      GoRouter.of(context).go('/login');
      // Registration successful, navigate to another page or show success message.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registration failed: "),
      ));
      if (result.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result.errorMessage!),
        ));
      }
    }
  }
}
