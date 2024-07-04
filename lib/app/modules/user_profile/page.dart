
import 'package:app_hortifruti_pratico/app/modules/user_profile/controller.dart';
import 'package:app_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Meu Perfil'),
          centerTitle: true,
      ),
      body: controller.obx((state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
             horizontal: 16
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () => Get.toNamed(Routes.userAddressList),
                        child: Text('Meus endereços')
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Form(
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
                        if(value != null && value.isNotEmpty && value.length < 8){
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
                              child: Text('Atualizar'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: controller.logout,
                            child: Text('Sair da minha conta'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                 ),
                ),
            ],
          )
          ),
        ),
        onError: (error) => Center(
          child: ElevatedButton(
            child: const Text('Entrar com a minha conta'),
            onPressed: () => Get.toNamed(Routes.login),
          ),
        )
      ),
    );
  }
}
