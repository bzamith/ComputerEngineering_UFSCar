# Sistemas Distribuídos
Trabalho desenvolvido para a disciplina de Sistemas Distribuídos, professor Dr. Fredy Valente, 1o semestre de 2019. 

### Alunos
- Bruna Zamith Santos, 628093
- Marcos Augusto Faglioni Junior, 628301

### Trabalho
Implementação do Linda e de um servidor Pub-Sub em python. 

### Projeto
- [x] client.py = Interface do cliente, faz as chamadas no linda de acordo com o input no Shell
- [x] linda.py = Biblioteca do Linda, com as funções básicas (linda_in(), linda_out(), linda_rd() e outras)
- [x] tupplespace.py = Classe do TuppleSpace
- [x] server.py = Servidor, trata as requisições vindas de um objeto da classe Linda. O servidor teve sua implementação baseada no material de [Kuntal Chandra](https://kuntalchandra.wordpress.com/2017/08/23/python-socket-programming-server-client-application-using-threads/)
- [x] ip_config.txt = Arquivo para configuração do ip e porta do servidor. Clientes e servidores devem ter o mesmo arquivo ip_config para poderem se conectar. Primeira linha deve conter o ip do servidor, segunda deve conter a porta. O restante é ignorado.

### Execução
Rodar o server em uma sessão shell:
```bash
> python3 server.py
```

Rodar o cliente em uma (ou múltiplas) sessão shell:
```bash
> python3 client.py
```

Quando o cliente inicializar, ele solicitará:
- Hostname: Nome de usuário desejado (não há login)
- Topic: Nome do tópico ao qual deseja se inscrever, se não houver nenhum com esse nome, é criado.
