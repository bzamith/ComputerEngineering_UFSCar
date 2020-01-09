# Sistemas Distribuídos
Trabalho desenvolvido para a disciplina de Sistemas Distribuídos, professor Dr. Fredy Valente, 1o semestre de 2019. 

### Alunos
- Bruna Zamith Santos, 628093
- Marcos Augusto Faglioni Junior, 628301

### Trabalho
Implementação do Monitor de Bolsa de Valores usando Zmq.

### Projeto
- [x] sub.py = Interface do cliente, se inscreve nas bolsas que desejar, pode ter quantas instancias quiser
- [x] pub.py = Publishers das bolsas (uma thread pra cada bolsa), só deve ter um processo com ele para não haver conflito
- [x] proxy.py = Broker XSUB/XPUB
- [x] companies.txt = Sigla das empresas por bolsa de valores

### Execução
Rodar o proxy em uma sessão shell:
```bash
> pip3 install -r requirements.txt
> python3 proxy.py
```
Rodar o pub em uma sessão shell:
```bash
> python3 pub.py
```

Rodar o cliente em uma (ou múltiplas) sessão shell:
```bash
> python3 sub.py
```

Quando o cliente inicializar, ele solicitará:
- Bolsas que deseja se inscrever
