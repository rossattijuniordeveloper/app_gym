import 'package:app_gym/_common/meu_snackbar.dart';
import 'package:app_gym/_common/minhas_cores.dart';
import 'package:app_gym/services/autenticacao_service.dart';
import 'package:flutter/material.dart';
import '../components/decoraco_campo_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool queroAcessar = true;
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  AutenticacaoService _autenticacao = AutenticacaoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.fundoDark,
      // Color(0xFF494848)
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MinhasCores.blackTopoGradiente,
                  MinhasCores.blackBaixoGradiente
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          "images/AppMaromba.png",
                          height: queroAcessar ? 128 : 55,
//                        width: queroAcessar? 22:22,
//                        fit: BoxFit.cover,
//                        fit:BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'AppGym',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        validator: (String? value) {
                          if (value == null) {
                            return 'o E-mail não pode ser vazio!';
                          }
                          if (!value.contains('@')) {
                            return 'formato de E-mail INVÁLIDO!';
                          }
                          if (value.length < 6) {
                            return 'o e-mail é muito curto (INVÁLIDO!)';
                          }
                          return null;
                        },
                        decoration: getLoginInputDecoration(
                            'E-Mail', Icons.mail_outline, 14, Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _senhaController,
                        validator: (String? value) {
                          if (value == null) {
                            return 'A Senha não pode ser vazia (INVÁLIDA!) ';
                          }
                          if (value.length < 8) {
                            return 'Senha muito curta (INVÁLIDA!) ';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: getLoginInputDecoration(
                            'Senha', Icons.lock_outline, 14, Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: !queroAcessar,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (String? value) {
                                if (value == null) {
                                  return 'A Confirmação de Senha não pode ser vazia (INVÁLIDA!) ';
                                }
                                if (value.length < 8) {
                                  return 'A Confirmação de Senha é muito curta (INVÁLIDA!) ';
                                }
                                if (value != _senhaController.text) {
                                  return 'A senhas não são iguais (INVÁLIDA!) ';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: getLoginInputDecoration(
                                'Confirme a Senha',
                                Icons.lock_outline,
                                14,
                                Colors.yellow,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _nomeController,
                              validator: (String? value) {
                                if (value == null) {
                                  return 'o Nome não pode ser vazio! (INVÁLIDO!)';
                                }
                                if (value.length < 3) {
                                  return 'o Nome é muito curto (INVÁLIDO!)';
                                }
                                return null;
                              },
                              decoration: getLoginInputDecoration(
                                'Nome',
                                Icons.people_alt_outlined,
                                14,
                                Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          botaoPrincipalClicado();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(queroAcessar ? 'Acessar' : 'Cadastrar'),
                        ),
                      ),
                      Divider(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            queroAcessar = !queroAcessar;
                          });
                        },
                        child: Text(
                          queroAcessar
                              ? 'Ainda não tem uma conta? Cadastre-se!'
                              : 'já tem uma Conta? Acesse!',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  botaoPrincipalClicado() {
    String email = _emailController.text;
    String nome = _nomeController.text;
    String senha = _senhaController.text;

    if (_formkey.currentState!.validate()) {
      print('Form Valido !');
      if (queroAcessar) {
        _autenticacao.logarUsuarios(email: email, senha: senha).then(
          (String? erro) {
            if (erro != null) {
              showSnackbar(context: context, texto: erro);
            } else {
              // showSnackbar(
              //     context: context,
              //     texto: 'Bem Vindo  ${email} !',
              //     isErro: false);
            }
          },
        );
        // print(
        //     'Acessou o Usuario ${_emailController.text} , ${_senhaController.text} , ${_nomeController.text}');
      } else {
        print('Cadastro Validado !');

        // print(
        //     'Cadastrou o Usuario ${_emailController.text} , ${_senhaController.text} , ${_nomeController.text},');
        _autenticacao
            .cadastrarUsuario(email: email, senha: senha, nome: nome)
            .then(
          (String? erro) {
            if (erro != null) {
              // voltou com erro
              showSnackbar(context: context, texto: erro);
            }// else {

            //   showSnackbar(
            //       context: context,
            //       texto: 'Usuário Cadastrado com SUCESSO',
            //       isErro: false);
            // }
          },
        );
      }
    } else {
      print('Form Inválido');
    }
  }
}
