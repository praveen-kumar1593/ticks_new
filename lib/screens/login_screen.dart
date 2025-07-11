import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../constants/r_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    try {
      final credentials = await authController.getSavedCredentials();
      if (credentials['username'] != null && credentials['password'] != null) {
        setState(() {
          userNameController.text = credentials['username']!;
          passwordController.text = credentials['password']!;
          rememberMe = true;
        });
      }
    } catch (e) {
      print('Error loading saved credentials: $e');
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Center(child: const Text('Log in ')),
        backgroundColor: RColors.lightblue,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: 'User ID',
                  labelStyle: TextStyle(color: RColors.orange),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: RColors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: RColors.orange, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your User ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: RColors.orange),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:  BorderSide(color: RColors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: RColors.orange, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  const Text(
                    'Remember Me',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: RColors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          // Note: 'rememberMe' is hardcoded to true for now as per UI design change.
                          // You might want to revisit this logic.
                          authController.login(
                            userNameController.text,
                            passwordController.text,
                            rememberMe: true,
                          );
                        }
                      },
                child: authController.isLoading.value
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              )),
              const SizedBox(height: 20),
              // const Row(
              //   children: [
              //     Expanded(child: Divider()),
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 8.0),
              //       child: Text('or'),
              //     ),
              //     Expanded(child: Divider()),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // TextButton(
              //   onPressed: () {
              //     // TODO: Implement Login with Mobile number OTP
              //   },
              //   child: Text(
              //     'Login with Mobile number OTP',
              //     style: TextStyle(color: RColors.blue, fontSize: 16),
              //   ),
              // ),
              // Obx(() {
              //   if (authController.errorMessage.value.isNotEmpty) {
              //     return Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         authController.errorMessage.value,
              //         style: const TextStyle(color: Colors.red),
              //         textAlign: TextAlign.center,
              //       ),
              //     );
              //   }
              //   return const SizedBox.shrink();
              // }),
            ],
          ),
        ),
      ),
    );
  }
} 