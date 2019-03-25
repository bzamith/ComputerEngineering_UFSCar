import bgp_sql_v2 as sql
import re
import mysql.connector

def check_file(archive_name, show=True):
    db = mysql.connector.connect(host='localhost', port=3306, user='bruna', password='root', db='bgp_database')
    idfile = sql.consulta_generico('file', ['idfile'], ['file'], ['='], [''],
                                   ["'" + str(archive_name) + "'"], db)
    db.close()
    if idfile:
        if show:
            print("File " + archive_name + " already in database!")
            print("Shuting down...")
            print("*****************************")
            print('')
        return False
    return True

def insertion_bgp_sql(content_dict, archive_name, show=True):
    if content_dict['number_of_lines'] == 0:
        print("Won't insert file " + archive_name)
    else:
        db = mysql.connector.connect(host='localhost', port=3306, user='bruna', password='root', db='bgp_database')
        print("Making insertions")
        if show:
            print("Inserting into table File...", end='')
        sql.insere_generico('file', 'file', '("' + archive_name + '")', db)
        if show:
            print(" OK!")

        # Insere local_router_id
        if show:
            print("Inserting local_router_id into table Ip...", end='')
        values = "'" + str(content_dict['local_router_id']) + "'"
        idip = sql.consulta_insere_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'], [values, '32'], db)
        if show:
            print(" OK!")

        # Insere networks e suas mascaras sem repeticao
        networks_unique = []
        masks_unique = []
        all_set = set()
        # Deixa sem repeticoes
        for i in range(0, len(content_dict['network'])):
            s = str(content_dict['network'][i])+"/"+str(content_dict['mask'][i])
            if s not in all_set:
                all_set.add(s)
                networks_unique.append("'" + str(content_dict['network'][i]) + "'")
                if content_dict['mask'][i] == '':
                    masks_unique.append("'" + str(32) + "'")
                else:
                    masks_unique.append("'" + str(content_dict['mask'][i]) + "'")
        for i in range(0, len(networks_unique)):
            if show:
                print("Inserting networks and maks into table Ip (" + str(i + 1) + "/" + str(len(networks_unique)) + ")...",end='')
            sql.consulta_insere_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                         [networks_unique[i], masks_unique[i]], db)
            if show:
                print(" OK!")

        # Insere next_hop sem repeticao
        next_hop_unique = []
        all_set_two = set()
        # Deixa sem repeticoes
        for i in range(0, len(content_dict['next_hop'])):
            s = str(content_dict['next_hop'][i])
            if s not in all_set_two:
                all_set_two.add(s)
                next_hop_unique.append("'" + str(content_dict['next_hop'][i]) + "'")
        for i in range(0, len(next_hop_unique)):
            if show:
                print("Inserting next_hop into table Ip (" + str(i + 1) + "/" + str(len(next_hop_unique)) + ")...", end='')
            sql.consulta_insere_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                         [next_hop_unique[i], '32'], db)
            if show:
                print(" OK!")

        if show:
            print("Inserting file and table version into table Files Description...", end='')
        values = "'" + str(archive_name) + "'"
        idfile = sql.consulta_generico('file', ['idfile'], ['file'], ['='], [''], [values], db)
        values = "'" + str(content_dict['local_router_id']) + "'"
        idlocalrouterid = sql.consulta_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'], [values, '32'], db)

        if idfile and idlocalrouterid:
            columns = 'idfile, bgptable_version, local_router_id'
            values = "(" + str((re.sub('[(,)\']', '', str(idfile)))) + "," + str(
                content_dict['table_version']) + "," + str((re.sub('[( , )\']', '', str(idlocalrouterid)))) + ")"
            sql.insere_generico('files_description', columns, values, db)
        if show:
            print(" OK!")

        # Insere routes
        '''
        numero_routes = len(content_dict['network'])
        for i in range(0, numero_routes):
            if show:
                print("Inserting routes into table Routes (" + str(i + 1) + "/" + str(numero_routes) + ")...", end='')
            columns = ['idfile', 'network', 'nexthop', 'supressed', 'dumped', 'history', 'valid', 'best',
                       'internal', 'rib_failure', 'stale', 'removed', 'oc_igp', 'oc_egp', 'oc_incomplete', 'weight']
            equals = ['='] * len(columns)
            ands = ['and'] * (len(columns) - 1)
            if content_dict['mask'][i] == '':
                idnetwork = sql.consulta_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                                  ["'" + str(content_dict['network'][i]) + "'", '32'], db)
            else:
                idnetwork = sql.consulta_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                                  ["'" + str(content_dict['network'][i]) + "'",
                                                   "'" + str(content_dict['mask'][i]) + "'"], db)
            idnexthop = sql.consulta_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                              ["'" + str(content_dict['next_hop'][i]) + "'", '32'], db)

            if idfile and idnetwork and idnexthop:
                values = ["'" + str((re.sub('[(,)\']', '', str(idfile)))) + "'",
                          "'" + str((re.sub('[(,)\']', '', str(idnetwork)))) + "'",
                          "'" + str((re.sub('[(,)\']', '', str(idnexthop)))) + "'",
                          "'" + str(content_dict['suppressed'][i]) + "'", "'" + str(content_dict['dumped'][i]) + "'",
                          "'" + str(content_dict['history'][i]) + "'", "'" + str(content_dict['valid'][i]) + "'",
                          "'" + str(content_dict['best'][i]) + "'", "'" + str(content_dict['internal'][i]) + "'",
                          "'" + str(content_dict['rib'][i]) + "'", "'" + str(content_dict['stale'][i]) + "'",
                          "'" + str(content_dict['removed'][i]) + "'", "'" + str(content_dict['igp'][i]) + "'",
                          "'" + str(content_dict['egp'][i]) + "'", "'" + str(content_dict['incomplete'][i]) + "'",
                          "'" + str(content_dict['weight'][i]) + "'"]
                if not content_dict['metric'][i] == '':
                    columns.append('metric')
                    values.append("'" + str(content_dict['metric'][i]) + "'")
                    equals.append('=')
                    ands.append('and')
                if not content_dict['loc_prf'][i] == '':
                    columns.append('loc_prf')
                    values.append("'" + str(content_dict['loc_prf'][i]) + "'")
                    equals.append('=')
                    ands.append('and')
                sql.consulta_insere_generico('routes', ['idfile'], columns, equals, ands, values, db)
                if show:
                    print(" OK!")
            else:
                if show:
                    print(" Couldn't insert network")

        # Insere ases e paths
        #for i in range(0, numero_routes):
            
            if isinstance(content_dict['path'][i], int):
                content_dict['path'][i] = [content_dict['path'][i]]
            numero_paths = len(content_dict['path'][i])
            for j in range(0, numero_paths):
                if show:
                    print("Inserting ases and paths into table Ases and BGP_Path (" + str(j + 1) + "/" + str(numero_paths) + ") (" + str(i + 1) + "/" + str(numero_routes) + ")...", end='')
                path = "'" + str(content_dict['path'][i][j]) + "'"
                sql.consulta_insere_generico('ases', ['idases'], ['ases', 'lg'], ['=', '='], ['and'], [path, '1'], db)
                idases = sql.consulta_generico('ases', ['idases'], ['ases', 'lg'], ['=', '='], ['and'], [path, '1'], db)

                if content_dict['mask'][i] == '':
                    idnetwork = sql.consulta_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                                      ["'" + str(content_dict['network'][i]) + "'", '32'], db)
                else:
                    idnetwork = sql.consulta_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                                      ["'" + str(content_dict['network'][i]) + "'",
                                                       "'" + str(content_dict['mask'][i]) + "'"], db)
                idnexthop = sql.consulta_generico('ip', ['idip'], ['ip', 'mask'], ['=', '='], ['and'],
                                                  ["'" + str(content_dict['next_hop'][i]) + "'", '32'], db)

                idroute = sql.consulta_generico('routes', ['idroute'], ['idfile', 'network', 'nexthop'],
                                                ['=', '=', '='], ['and', 'and'],
                                                ["'" + str((re.sub('[(,)\']', '', str(idfile)))) + "'",
                                                 "'" + str((re.sub('[(,)\']', '', str(idnetwork)))) + "'",
                                                 "'" + str((re.sub('[(,)\']', '', str(idnexthop)))) + "'"], db)
                if idases and idroute:
                    sql.consulta_insere_generico('bgp_path', ['idbgp_path'], ['idroute', 'idases'], ['=', '='],
                                                 ['and'], ["'" + str((re.sub('[(,)\']', '', str(idroute)))) + "'",
                                                           "'" + str((re.sub('[(,)\']', '', str(idases)))) + "'"], db)
                    if show:
                        print(" OK!")
                else:
                    if show:
                        print(" Couldn't insert path")
                '''
        db.close()
    print("*****************************")
    print('')