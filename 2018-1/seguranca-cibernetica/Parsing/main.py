import os
import fnmatch
import bgpparser as parser
import insertion_bgp_sql_v1 as insert

def main():
    input_path = '/home/zamith/Documents/Grad_e_IC/7o_Semestre/Seguranca/BGP/Tabelas/'
    for archive_name in os.listdir(input_path):
        if fnmatch.fnmatch(archive_name, '*IPv6-BGP*') or fnmatch.fnmatch(archive_name, '*IPv4-BGP*'):
            if insert.check_file(archive_name, True):
                content_dict = parser.parser(input_path, archive_name)
                insert.insertion_bgp_sql(content_dict, archive_name, True)

if __name__ == '__main__':
    main()