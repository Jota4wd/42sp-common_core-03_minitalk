
# Minitalk

O **Minitalk** é um projeto da 42SP cujo objetivo é implementar uma comunicação entre dois processos (cliente e servidor) utilizando **exclusivamente sinais UNIX** (`SIGUSR1` e `SIGUSR2`).

A ideia principal é entender como funciona a troca de dados em baixo nível, sem sockets, pipes ou qualquer outro meio “confortável”. Aqui é sinal na veia.

---

## 📡 Como funciona

- O **servidor** é iniciado primeiro e imprime seu **PID**.
- O **cliente** recebe:
  1. O PID do servidor
  2. A mensagem a ser enviada
- Cada caractere da mensagem é convertido em bits.
- Cada bit é enviado ao servidor através de sinais:
  - `SIGUSR1` → bit 0
  - `SIGUSR2` → bit 1
- O servidor reconstrói os bits, forma os caracteres e imprime a mensagem recebida.

Na parte bônus, o servidor envia um sinal de confirmação para o cliente ao final da mensagem.

---

## 🧠 Conceitos aprendidos

Durante o desenvolvimento deste projeto, trabalhei principalmente com:

- Comunicação entre processos (IPC)
- Uso de sinais UNIX (`signal`, `sigaction`, `kill`)
- Manipulação de bits
- Sincronização entre processos
- Tratamento de erros e comportamento indefinido
- Organização de código seguindo a **Norma da 42**
- Evitar vazamentos de memória (o `free` também quer carinho)

Esse projeto ajuda bastante a perder o medo de sistemas e a entender melhor o que acontece “por baixo do capô”.

---

## 🛠️ Compilação

O projeto contém um `Makefile` com as regras obrigatórias.

```bash
make
```
Isso irá gerar dois executáveis:

-   `server`

-   `client`


----------

## ▶️ Como usar

### 1️⃣ Inicie o servidor
```bash
./server
```
O servidor irá imprimir algo como:

`Server PID: 12345`

### 2️⃣ Envie uma mensagem com o cliente

Em outro terminal:
```bash
./client 12345 "Olá, Minitalk!"
```
O servidor receberá e imprimirá a mensagem imediatamente.

----------

## 🧪 Testes

### Teste simples
```bash
./client <PID> "Hello World"
```
### Teste com mensagens grandes

Você pode testar com arquivos grandes usando substituição de comando:
```bash
./client <PID> "$(cat arquivo_grande.txt)"
```
Isso é útil para validar:

-   Performance

-   Sincronização dos sinais

-   Estabilidade do servidor


⚠️ Se começar a ficar lento demais, provavelmente você está enviando sinais rápido demais — sinais não fazem fila. Eles têm personalidade forte.

----------

## ⭐ Bônus

-   Confirmação de recebimento:

    -   O servidor envia um sinal ao cliente quando a mensagem é recebida por completo.

-   Suporte a caracteres Unicode (dependendo da implementação).


A parte bônus só é avaliada se a parte obrigatória estiver **100% funcional**.

----------

## 📁 Estrutura do projeto
```bash
.
├── Makefile
├── client.c
├── server.c
├── includes/
│   └── minitalk.h
└── libft/
```
----------

## 🧩 Observações finais

Este projeto faz parte da minha formação na **42SP** e está aqui como parte do meu portfólio pessoal.
O foco foi escrever um código **simples**, **legível** e **confiável**, respeitando a norma e evitando qualquer comportamento inesperado.
