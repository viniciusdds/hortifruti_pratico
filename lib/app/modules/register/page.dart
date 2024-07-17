import 'package:app_hortifruti_pratico/app/modules/register/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (String? value){
                    if(value != null && value.isEmpty){
                      return 'Preencha o seu nome';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (String? value){
                    if(value != null && value.isEmpty){
                      return 'Preencha o seu e-mail';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                  ),
                  validator: (String? value){
                    if(value != null && value.isEmpty){
                      return 'Preencha o seu número de telefone';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  validator: (String? value){
                    if(value != null && (value.isEmpty || value.length < 8)){
                      return 'Informe uma senha válida e maior que 8 caracteres';
                    }

                    return null;
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.submit,
                          child: Text('Cadastrar'),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
