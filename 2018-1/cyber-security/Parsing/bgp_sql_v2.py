import mysql.connector
#import pymysql

#db = pymysql.connect("localhost","root","abc123","BGP" )

# insere em 'table' os 'values' nas 'columns'
# ex.: bgp.insere_generico('ip', 'ip, mask', '1000,32')
def insere_generico(table, columns, values, db):
#    db = mysql.connector.connect(host='localhost', port=3306, user='bruna', password='root', db='bgp_database')
    cursor = db.cursor()
    id_insere_generico = -1
    try:
        sql = "insert into %s (%s) values %s" % (table, columns, values)
        cursor.execute(sql)
        db.commit()
        id_insere_generico = cursor.lastrowid
    except mysql.connector.Error as err:
        # Nao estou sabendo inserir em line_error erro!
        # sql =  "insert into %s (%s) values (%s)" % ('line_error', )
        print('insere_generico: Erro no insert da tabela', table, ' - SQL: ', sql)
        db.rollback()
        print(err)
#    db.close()
    return (id_insere_generico)

# consulta em 'table', retornando 'columns1' como resultado e 'columns2' como condicoes no where, sendo que 'signal1' relaciona os campos com os valores e o 'signal2' relaciona os multiplos campos
# ex.: select idip, ip, mask from ip where ip = 1000 and mask = 32;
# ex.: print(bgp.consulta_generico('ip', ['ip','mask','idip'], ['mask'], ['='], [''], ['32'] ))
# ex.: print(bgp.consulta_generico('ip', ['ip','mask','idip'], ['ip','mask'], ['=','='], ['and'], ['1000','32'])[0])
##consulta_generico(table, column1[], column2[], signal1[], signal2[], value[]):
def consulta_generico(table, column1, column2, signal1, signal2, value, db):
    sql = 'select '
    id_consulta_generico = -1
    for i in range(len(column1)):
        sql = sql + column1[i]                      # a cada column1 passado como parametro na funcao, insere seu valor no sql
        if i < len(column1)-1:                      # insere as virgulas entre os campos
            sql = sql + ', '

    sql = sql + ' from ' + table + ' where '        # preenche o 'from', nome da tabela e 'where'

    for i in range(len(column2)):
        sql = sql + column2[i] + signal1[i] + value[i]
        if i < len(column2)-1:                      # insere o signal2 quando existir
            sql = sql + ' ' + signal2[i] + ' '

#    db = mysql.connector.connect(host='localhost', port=3306, user='bruna', password='root', db='bgp_database')
    cursor = db.cursor()
    try:
        cursor.execute(sql)
        id_consulta_generico = cursor.fetchone()
    except mysql.connector.Error as err:
        # Nao estou sabendo inserir em line_error erro!
        # sql =  "insert into %s (%s) values (%s)" % ('line_error', )
        print('consulta_generico: Erro na consulta da tabela', table, ' - SQL: ', sql)
        db.rollback()
        print(err)
#    db.close()
    return (id_consulta_generico)

def consulta_insere_generico(table, column1, column2, signal1, signal2, value, db):
    #bgp.consulta_insere_generico('',[''],[''],[''],[''],[''])

    #primeiro faco a consulta_generico
    id_consulta_insere_generico = consulta_generico(table, column1, column2, signal1, signal2, value, db)

    # se nao existir, cadastra
    if not id_consulta_insere_generico:
        # montar o SQL de insercao
        sql = 'insert into ' + table + ' ('

        for i in range(len(column2)):
            sql = sql + column2[i]  # a cada column1 passado como parametro na funcao, insere seu valor no sql
            if i < len(column2) - 1:  # insere as virgulas entre os campos
                sql = sql + ', '

        sql = sql + ') values ('

        for i in range(len(value)):
            sql = sql + value[i]
            if i < len(value) - 1:  # insere as virgulas entre os campos
                sql = sql + ', '
        sql = sql + ')'

#        db = mysql.connector.connect(host='localhost', port=3306, user='bruna', password='root', db='bgp_database')
        cursor = db.cursor()
        try:
            cursor.execute(sql)
            db.commit()
            id_consulta_insere_generico = cursor.lastrowid
        except mysql.connector.Error as err:
            # Nao estou sabendo inserir em line_error erro!
            # sql =  "insert into %s (%s) values (%s)" % ('line_error', )
            print('consulta_insere_generico: Erro na insercao da tabela ', table, ' - SQL: ', sql)
            db.rollback()
            print(err)
        #db.close()
    return (id_consulta_insere_generico)
