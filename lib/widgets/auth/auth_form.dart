import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  var isLogin = true;
  var userEmail = '';
  var userName = '';
  var userPassword = '';

  void submit(){
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if(isValid){
      formKey.currentState!.save();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email'),
                    validator :(value){
                      if(value!.isEmpty || !value.contains('@')){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email Address',),
                    onSaved: (value){
                      userEmail = value!;
                    },
                  ),
                  if(!isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator :(value){
                      if(value!.isEmpty || value.length < 4){
                        return 'Please enter longer username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (value){
                      userName = value!;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator :(value){
                      if(value!.isEmpty || value.length < 7){
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value){
                      userPassword = value!;
                    },
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(child: Text(isLogin ? 'Login' : 'Sign up'),onPressed:submit,),
                  TextButton(child: Text(isLogin ? 'Create new account' : 'I already have an account'),onPressed: (){
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },),
                ],
            )),
          ),
        ),
      ),
    );
  }
}
