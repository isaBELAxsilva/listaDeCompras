// Realizado em aula com o professor (dias 1 e 2)

import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Produto {
  String nome;
  String categoria;
  String precoMaximo;

  Produto({
    required this.nome,
    required this.categoria,
    required this.precoMaximo,
  });
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Produto - por Isabela',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Adiciona a imagem do logo
                Image.asset(
                  'images/logo.png',
                  height: 244, // Ajuste conforme necessário
                  width: 275, // Ajuste conforme necessário
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Verificar credenciais
                if (_usernameController.text == 'Vedilson' &&
                    _passwordController.text == 'trocar123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductsListPage()),
                  );
                } else {
                  // Exibir mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  // Lista de alunos (simulando um banco de dados)
  List<Produto> products = [
    Produto(
      nome: 'Morangos',
      categoria: 'Fruta',
      precoMaximo: '14,00 reais',
    ),
    Produto(
      nome: 'Macarrows',
      categoria: 'Doce',
      precoMaximo: '8,00 reais',
    ),
    Produto(
      nome: 'Trufa',
      categoria: 'Doce',
      precoMaximo: '8,00 reais',
    ),
    Produto(
      nome: 'Kiwi',
      categoria: 'Fruta',
      precoMaximo: '8,00 reais',
    ),
    Produto(
      nome: 'Abacaxi',
      categoria: 'Fruta',
      precoMaximo: '15,00 reais',
    ),
    Produto(
      nome: 'Uva Verde',
      categoria: 'Fruta',
      precoMaximo: '12,00 reais',
    ),
    Produto(
      nome: 'Torta de Morango',
      categoria: 'Doce',
      precoMaximo: '22,00 reais',
    ),
    Produto(
      nome: 'Torta de Maçã',
      categoria: 'Doce',
      precoMaximo: '20,00 reais',
    ),
    Produto(
      nome: 'Torta de Banoffe',
      categoria: 'Doce',
      precoMaximo: '22,00 reais',
    ),
    Produto(
      nome: 'Mousse de Maracujá',
      categoria: 'Doce',
      precoMaximo: '20,00 reais',
    ),
    Produto(
      nome: 'Torta de Limão',
      categoria: 'Doce',
      precoMaximo: '20,00 reais',
    ),
    Produto(
      nome: 'Biscoito Goiabinha Caseira',
      categoria: 'Doce',
      precoMaximo: '10,00 reais',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].nome),
            subtitle: Text(products[index].categoria),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir produto
                products.removeAt(index);
                // Atualizar a interface
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Produto removido')),
                );
                // Atualizar a lista de produtos
                setState(() {});
              },
            ),
            onTap: () async {
              // Editar o produto
              Produto updatedStudent = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: products[index].nome);
                  TextEditingController _categoriaController =
                      TextEditingController(text: products[index].categoria);
                  TextEditingController _precoMaximoController =
                      TextEditingController(text: products[index].precoMaximo);

                  return AlertDialog(
                    title: Text('Editar Produto'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nomeController,
                          decoration: InputDecoration(labelText: 'Nome'),
                        ),
                        TextField(
                          controller: _categoriaController,
                          decoration: InputDecoration(labelText: 'Categoria'),
                        ),
                        TextField(
                          controller: _precoMaximoController,
                          decoration:
                              InputDecoration(labelText: 'Preço Maximo'),
                          obscureText: true,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Validar e salvar as alterações
                          if (_nomeController.text.isNotEmpty &&
                              _categoriaController.text.isNotEmpty &&
                              _precoMaximoController.text.isNotEmpty) {
                            Navigator.pop(
                              context,
                              Produto(
                                nome: _nomeController.text.trim(),
                                categoria: _categoriaController.text.trim(),
                                precoMaximo: _precoMaximoController.text.trim(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedStudent != null) {
                // Atualizar o produto na lista
                products[index] = updatedStudent;
                // Atualizar a interface
                setState(() {});
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Adicionar novo produto
          Produto newStudent = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _categoriaController =
                  TextEditingController();
              TextEditingController _precoMaximoController =
                  TextEditingController();

              // Adicionar novo aluno
              return AlertDialog(
                title: Text('Novo Produto'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: _categoriaController,
                      decoration: InputDecoration(labelText: 'Categoria'),
                    ),
                    TextField(
                      controller: _precoMaximoController,
                      decoration: InputDecoration(labelText: 'Preço Maximo'),
                      obscureText: true,
                    ),
                  ],
                ),
                // Cancelar operação
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),

                  // Validar e adicionar o novo produto
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _categoriaController.text.isNotEmpty &&
                          _precoMaximoController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Produto(
                            nome: _nomeController.text.trim(),
                            categoria: _categoriaController.text.trim(),
                            precoMaximo: _precoMaximoController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );

          // Verificar espaço a ser alocado para a adição do novo produto
          if (newStudent != null) {
            // Adicionar o novo produto à lista
            products.add(newStudent);

            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
