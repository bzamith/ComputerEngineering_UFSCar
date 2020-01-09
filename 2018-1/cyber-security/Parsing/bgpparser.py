import os
import re
import ipaddress as ipa


SEP = os.sep
ARRAY_NAMES = ['suppressed', 'dumped', 'history', 'valid', 'best', 'internal', 'rib', 'stale', 'removed', 'network',
               'next_hop', 'metric', 'loc_prf', 'weight', 'path', 'igp', 'egp', 'incomplete', 'mask']
STATUS_CODE_TO_NAME = {'s': 'suppressed', 'd': 'dumped', 'h': 'history', '*': 'valid', '>': 'best', 'i': 'internal'}
ORIGIN_CODES_TO_NAME = {'i': 'igp', 'e': 'egp', '?': 'incomplete'}


class ValueIndexContainer:
    def __init__(self, content_list):
        self.first_index = content_list[0]
        self.last_index = content_list[1]
        self.value = content_list[2]
        self.header = None

            
class HeaderContainer(ValueIndexContainer):
    def __init__(self, content_list):
        ValueIndexContainer.__init__(self, content_list)


class LineItemContainer(ValueIndexContainer):
    def __init__(self, content_list):
        ValueIndexContainer.__init__(self, content_list)

    def have_intersection(self, header_container):
        if (self.first_index == header_container.first_index) or (self.last_index == header_container.last_index):
            return True
        else:
            return False


    def find_correct_header(self, header_container_list):
        match_header = None
        for header_container in header_container_list:
            if self.have_intersection(header_container=header_container):
                match_header = header_container

        self.header = match_header
        return match_header


def get_table_version(is_ipv6, input_path, archive_name):

    numbers = None

    with open(input_path+archive_name) as input_file:
        for line in input_file:
            if line.startswith('BGP table version is'):
                numbers = [s for s in re.findall(r'-?\d+\.?\d*', line)]

    if numbers != None:
        version_number = int(numbers[0])
        del numbers[0]
        local_router_id = '.'.join(numbers)
        return version_number, ip_to_num(local_router_id, is_ipv6=is_ipv6)
    else:
        return -1,-1


def find_number_of_lines(input_path, archive_name):
    header_line_index = None
    last_content_line_index = None

    with open(input_path+archive_name, 'r') as input_file:
        counter = 0
        searching_for_end = False
        for line in input_file:

            if searching_for_end:
                if line == '\n':
                    last_content_line_index = counter - 1
                    break
            else:
                if 'Network' in line:
                    header_line_index = counter
                    searching_for_end = True
            counter += 1
        if header_line_index != None and last_content_line_index == None:
            last_content_line_index = counter - 1
        if header_line_index == None and last_content_line_index == None:
            header_line_index = 0
            last_content_line_index = 0
    return header_line_index+1, last_content_line_index, last_content_line_index - header_line_index


def aloc_init_arrays(number_of_lines):
    content_dict = {}
    # for name in ARRAY_NAMES:
    #     if name == 'path':
    #         content_dict[name] = np.zeros(number_of_lines, dtype=list)
    #     else:
    #         content_dict[name] = np.zeros(number_of_lines, dtype=int)

    content_dict['number_of_lines'] = number_of_lines
    content_dict['local_router_id'] =''
    content_dict['table_version'] = ''
    content_dict['network'] = [0] * number_of_lines
    content_dict['next_hop'] = [0] * number_of_lines
    content_dict['weight'] = [0] * number_of_lines
    content_dict['path'] = [0] * number_of_lines
    content_dict['igp'] = [0] * number_of_lines
    content_dict['egp'] = [0] * number_of_lines
    content_dict['incomplete'] = [0] * number_of_lines
    content_dict['mask'] = [''] * number_of_lines
    content_dict['loc_prf'] = [''] * number_of_lines
    content_dict['metric'] = [''] * number_of_lines
    content_dict['suppressed'] = [0] * number_of_lines
    content_dict['dumped'] = [0] * number_of_lines
    content_dict['history'] = [0] * number_of_lines
    content_dict['valid'] = [0] * number_of_lines
    content_dict['best'] = [0] * number_of_lines
    content_dict['internal'] = [0] * number_of_lines
    content_dict['rib'] = [0] * number_of_lines
    content_dict['stale'] = [0] * number_of_lines
    content_dict['removed'] = [0] * number_of_lines

    return content_dict


def ip_to_num(ip, is_ipv6):
    if is_ipv6:
        return int(ipa.ip_address(ip))
    else:
        return int(ipa.ip_address(ip))


def process_status_codes(content_dict, raw_status_code, line_number):
    status_code_list = [c for c in raw_status_code]

    for status_code in status_code_list:
        content_dict[STATUS_CODE_TO_NAME[status_code]][line_number] = 1


def process_rest_of_line_content(content_dict, raw_line_indices_values, header_indices, line_number, is_ipv6):
    line_item_list = [LineItemContainer(raw_line_indices_values[i]) for i in range(len(raw_line_indices_values))]
    header_container_list = [HeaderContainer(header_indices[i]) for i in range(len(header_indices))]
    found_network = False
    found_metric = False
    found_loc_prf = False
    for line_item_container in line_item_list:
        header_container = line_item_container.find_correct_header(header_container_list=header_container_list)
        curr_item_value = line_item_container.value

        if header_container is not None:
            if header_container.value == 'network':
                found_network = True
                content_dict['network'][line_number] = ip_to_num(curr_item_value.split('/')[0], is_ipv6=is_ipv6)
                try:
                    content_dict['mask'][line_number] = int(curr_item_value.split('/')[1])
                except:
                    content_dict['mask'][line_number] = ''
            elif header_container.value == 'next_hop':
                content_dict['next_hop'][line_number] = ip_to_num(curr_item_value, is_ipv6=is_ipv6)
            elif header_container.value == 'metric':
                content_dict['metric'][line_number] = int(curr_item_value)
                found_metric = True
            elif header_container.value == 'loc_prf':
                content_dict['loc_prf'][line_number] = int(curr_item_value)
                found_loc_prf = True
            elif header_container.value == 'weight':
                content_dict['weight'][line_number] = int(curr_item_value)
            elif header_container.value == 'path':
                content_dict['path'][line_number] = [int(curr_item_value)]
        else:
            try:
                string_list = curr_item_value.lstrip('{').rstrip('}').split(',')
                for s in string_list:
                    if isinstance(content_dict['path'][line_number], int):
                        content_dict['path'][line_number] = int(s)
                    else:
                        content_dict['path'][line_number].append(int(s))
            except:
                content_dict[ORIGIN_CODES_TO_NAME[curr_item_value]][line_number] = 1


    if found_network == False:
        content_dict['network'][line_number] = content_dict['network'][line_number-1]
        content_dict['mask'][line_number] = content_dict['mask'][line_number-1]
    if found_metric == False:
        content_dict['metric'][line_number] = ''
    if found_loc_prf == False:
        content_dict['loc_prf'][line_number] = ''


def process_lines(content_dict, first_line_index, last_line_index, is_ipv6, input_path, archive_name):
    header_indices = find_header_indices(input_path, archive_name)


    with open(input_path+archive_name, 'r') as input_file:
        curr_line_index = 0
        curr_line = None
        first_line_ipv6 = True
        prv_ipv6 = False
        for line in input_file:
            line_number = curr_line_index - first_line_index
            end_boundary = last_line_index+1 if is_ipv6 else last_line_index
            if curr_line_index >= first_line_index and curr_line_index <= end_boundary:
                if is_ipv6  or len(line.split()) <= 2 or prv_ipv6 == True:
                    if prv_ipv6 == True:
                        prv_ipv6 = False
                    if len(line.split()) <= 2:
                        prv_ipv6 = True
                    if line[0] == ' ':
                        curr_line += line
                    else:
                        if first_line_ipv6 == True:
                            curr_line = line
                            first_line_ipv6 = False
                        else:
                            line_indices = get_line_content_indices(line=curr_line, is_header=False, is_ipv6=True)
                            process_status_codes(content_dict=content_dict, raw_status_code=line_indices[0][2],
                                                 line_number=line_number)
                            del line_indices[0]
                            process_rest_of_line_content(content_dict=content_dict,
                                                         raw_line_indices_values=line_indices,
                                                         header_indices=header_indices, line_number=line_number,
                                                         is_ipv6=is_ipv6)
                            curr_line = line
                else:
                    line_indices = get_line_content_indices(line=line, is_header=False, is_ipv6=False)
                    process_status_codes(content_dict=content_dict, raw_status_code=line_indices[0][2],
                                         line_number=line_number)
                    del line_indices[0]
                    process_rest_of_line_content(content_dict=content_dict, raw_line_indices_values=line_indices,
                                                 header_indices=header_indices, line_number=line_number,
                                                 is_ipv6=is_ipv6)


            curr_line_index += 1

    if is_ipv6:
        i = len(content_dict['network']) - 1
        while i > -1:
            if content_dict['network'][i] == 0:
                for name in ARRAY_NAMES:
                    del content_dict[name][i]

            i -= 1


def get_line_content_indices(line, is_header, is_ipv6):

    if is_header:
        line_content = ['network', 'next_hop', 'metric', 'loc_prf', 'weight', 'path']
    else:
        line_content = line.split()

    list_of_indices = []
    counter = 0
    searching_for_end = False
    already_jumped = False
    curr_item_index = -1
    for c in line:
        if searching_for_end:
            if (c == ' ' and is_ipv6) or (not is_ipv6 and (c == ' ' or c == '\n')):
                if is_header and curr_item_index == 1 and already_jumped == False:
                    already_jumped = True
                    pass
                else:
                    searching_for_end = False
                    list_of_indices[curr_item_index][1] = counter
        else:
            if (c != ' ' and is_ipv6) or (not is_ipv6 and (c != ' ' and c != '\n')):
                list_of_indices.append([counter, -1, line_content[curr_item_index+1]])
                searching_for_end = True
                curr_item_index += 1

        if is_ipv6 and c == '\n':
            counter = 0
        else:
            counter += 1

    return list_of_indices


def find_header_indices(input_path, archive_name):
    line_indices = None
    with open(input_path+archive_name, 'r') as input_file:
        for line in input_file:
            if 'Network' in line:
                line_indices = get_line_content_indices(line, True, False)
                break

    return line_indices


def process_content(input_path, archive_name, is_ipv6):
    first_line, last_line, number_of_lines = find_number_of_lines(input_path, archive_name)
    number_of_lines = number_of_lines+1 if is_ipv6 else number_of_lines
    content_dict = aloc_init_arrays(number_of_lines)
    content_dict['table_version'], content_dict['local_router_id'] = get_table_version(is_ipv6=is_ipv6, input_path=input_path, archive_name=archive_name)
    process_lines(content_dict=content_dict, first_line_index=first_line, last_line_index=last_line, is_ipv6=is_ipv6, input_path=input_path, archive_name=archive_name)

    return content_dict


def parser(input_path, archive_name):
    print("Parsing file " + archive_name)
    is_ipv6 = True if 'ipv6' in archive_name else False
    content_dict = process_content(is_ipv6=is_ipv6, input_path=input_path, archive_name=archive_name)

    return  content_dict

