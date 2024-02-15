import 'package:FounderFlock/viewmodels/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text('Login Page'),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _isLoading ? null : _performLogin,
            )
          ],
        ),
      ),
    );
  }

  void _performLogin() async {
    setState(() {
      _isLoading = true;
    });

    final viewModel = LoginViewModel();
    final response = await viewModel.login(
        context, _emailController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (response.status) {
      GoRouter.of(context).go('/chat');
    } else {
      if (response.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.errorMessage ?? 'An error occurred'),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }
}
