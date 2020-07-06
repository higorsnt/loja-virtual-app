<h1 align="center">
  <p>🛍️ Loja Virtual</p>
</h1>
<p align="center">
  <img alt="gif" src=".github/animation.gif" width="100px" />
</p>

## :package: Dependências

* [url_launcher](https://pub.dev/packages/url_launcher): Plug-in que auxilia no redirecionamento de uma URL, dando suporte à telefone, e-mail, SMS e browser.
* [transparent_image](https://pub.dev/packages/transparent_image): Oferece apenas uma imagem transparente, útil para que imagens carregadas de forma externa não apareçam repentinamente assim que for carregada.
* [firebase_auth](https://pub.dev/packages/firebase_auth): Permite o uso da API de autenticação do Firebase.
* [scoped_model](https://pub.dev/packages/scoped_model): Plug-in utilizado para facilitar o compartilhamento de dados dentro do aplicativo e notificar os widgets que dependem do dado este for modificado e necessitar que o widget seja atualizado.
* [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view): Oferece uma _grid view_ para múltiplas colunas e linha, onde cada item pode possuir tamanho variado.
* [carousel_pro](https://pub.dev/packages/carousel_pro): Plug-in que oferece um **widget** de carrosel.
* [cloud_firestore](https://pub.dev/packages/cloud_firestore): Permite o uso do banco de dados noSQL, que possui sincronização em tempo real, oferecido pelo Firebase.
* [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter): Plug-in com os ícones oferecidos pelo pacote FontAwesome.
* [path_provider](https://pub.dev/packages/path_provider): Utilizado para obter diretórios comuns, como _temp_ e _app data_, aos sistemas de arquivos dos sistemas operacionais.

## :newspaper: Funcionalidades
  * Cadastro e Login utilizando Firebase
  * Listagem de produtos por categoria
  * Selecionar tamanhos dos produtos
  * Adicinar produtos em um carrinho
  * Finalizar compra dos produtos adicionado no carrinho

## :shipit: Models

### :octocat: User Model
Esta entidade possui como atributos a instância do _FirebaseAuth_, um _FirabaseUser_ para indicar o
usuário logado, e um mapa com as informações do mesmo, enquanto que a variável _isLoading_ é usada para indicar que está ocorrendo algum tipo de operação assíncrona e se faz necessário indicar ao usuário isso.

Ao longo de toda a execução do aplicativo existirá apenas uma entidade de UserModel, tornando-o um
singleton, e para utilizar esta entidade basta chamar o método `.of(context)`, onde `context` é o contexto cujo Widget foi contruído.

#### :flags: Métodos
* `singUp`: Método que realiza o cadastro de um usuário. Como parâmetros, recebe um _Map_ com os dados do usuário, a senha escolhida pelo usuário e duas funções indicando o que ocorrerá quando o cadastro for concluído com sucesso e outra que será executada caso ocorra alguma falha durante o processo.
* `signIn`: Método que realiza o login de um usuário. Como parâmetros, recebe duas _Strings_, sendo uma o email e a outra a senha escolhida pelo usuário no momento do cadastro, e duas funções indicando o que ocorrerá quando o cadastro for concluído com sucesso e outra que será executada caso ocorra alguma falha durante o processo.
* `recoverPass`: Realiza a alteração da senha de um usuário, sendo necessário apenas o email utilizado no momento do cadastro.
* `isLoggedIn`: Informa se existe algum usuário logado no aplicativo.
* `signOut`: Realiza o logout do usuário.
* `_saveUserData`: Método privado que realiza a criação de um usuário no banco de dados do Firebase.
* `_loadCurrentUser`: Método privado que incialmente pega o usuário presente na instância única do _FirebaseAuth_, e caso tenha algum usuário será buscado os dados salvos no banco de dados.

### :octocat: Cart Model
Essa classe também é um singleton, podendo ser buscado pelo método `.of(context)`, e como atributos possui o usuário dono do carrinho de compras, a lista de produtos adicionados, o cupom promocional e a porcentagem de desconto que esse cupom oferece.

#### :flags: Métodos
* `addCartItem`: Este método adiciona um produto ao carrinho do usuário logado.
* `removeCartItem`: Este método remove um produto do carrinho do usuário logado.
* `incProduct`: Após adicionar o produto no carrinho o usuário pode aumentar a quantidade de unidades do produto. Portanto, esta função é que realiza esta ação.
* `decProduct`: Realiza a ação contrária da função anterior, ou seja, o decréscimo de unidades de um produto do carrinho.
* `setCupom`: Adiciona um cupom promocional válido que dá desconto aos produtos presentes no carrinho.
* `getDiscount`: Retorna o desconto aplicado à compra.
* `getShipPrice`: Retorna o valor do frete, que está de forma estática.
* `updatePrices`: Ao ser chamado este método atualizará os widgets que estão observando os dados modificados.
* `finishOrder`: Realiza todos os procedimentos necessários para finalizar a compra: cria uma nova compra na tabela `orders`, guarda uma referência dessa compra no registro do usuário e limpa o carrinho do mesmo e por fim notifica os widgets que ocorreram mudanças.
* `_loadCartItems`: Este método realiza a busca de produtos do carrinho no Firebase.


## :construction: Modelo das Entidades no Banco de Dados

### Usuário (`users`)

```json
  {
    "name": "<user name>",
    "email": "<user email>",
    "address": "<user address>",
    "orders": {
      "<order id>": {
        "orderId": "<order id>"
      }
    }
  }
```

### Produtos (`products`)

```json
  {
    "<category name>": {
      "icon": "<icon url>",
      "title": "<category name>",
      "items": {
        "<item id>": {
          "description": "",
          "images": [
            "<images url>"
          ],
          "price": 0.0,
          "sizes": [
            "size, e.g. M"
          ],
          "title": "<product title>"
        }
      }
    }
  }
```

### Endereço das Lojas (`places`)

```json
  {
    "<place id>": {
      "address": "<store addres>",
      "image": "<store image url>",
      "lat": 0.0,
      "long": 0.0,
      "phone": "<store phone>",
      "title": "<store name>"
    }
  }
```

### Pedidos (`orders`)

```js
  {
    "<order id>": {
      "clientId": "<client id>",
      "discount": 0.0,
      "productsPrice": 0.0,
      "shipPrice": 0.0,
      // valores possíveis de status:
      // 1 (Preparação), 2 (Transporte), 3(Entrega), 4 (Concluído)
      "status": 0,
      "totalPrice": 0.0
    }
  }
```

### Novidades (`home`)

```json
  {
    "<id>": {
      "image": "<image url>",
      "pos": 0,
      "x": 0,
      "y": 0
    }
  }
```

### Cupons (`coupons`)

```json
  {
    "<coupom name>": {
      "percent": 0
    }
  }
```