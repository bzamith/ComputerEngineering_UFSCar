from cli import *
from gui import *
import json
from physical import *
import re
from simulation import *
from tcp import *
from time import *

server = None
server_enabled = False
authorized_users = {}
clients = {}
subscriptions = {}
unconverted_subscriptions = {}
events = []
pdu_color = 0x79237c
on_gui_update_callback = None

setDeviceProperty(getName(), "MQTT_BROKER_ENABLED", str(server_enabled))
setDeviceProperty(getName(), "MQTT_BROKER_AUTHORIZED_USERS", str(authorized_users))
setDeviceProperty(getName(), "MQTT_BROKER_CLIENTS", str(clients))
setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))

def init():
	global server
	
	if server is None:
		server = TCPServer()
		server.listen(1883)
		server.onNewClient(on_new_client)
		enable_service()
	
	add_custom_mqtt_pdus()

def add_custom_mqtt_pdus():
	if not Simulation.hasCustomPDU("MQTT", "MQTT CONNECT"):
		Simulation.addCustomPDU("MQTT", "MQTT CONNECT", {
			"title": "MQTT CONNECT",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:1",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH (VARIABLE LENGTH)",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT CONNACK"):
		Simulation.addCustomPDU("MQTT", "MQTT CONNACK", {
			"title": "MQTT CONNACK",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:2",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:2",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT PUBLISH"):
		Simulation.addCustomPDU("MQTT", "MQTT PUBLISH", {
			"title": "MQTT PUBLISH",
			"units": "Bits",
			"unit_marks": [1, 3, 4],
			"width": 8,
			"fields": [
				{
					"value": "RETAIN:0",
					"size": 1
				},
				{
					"value": "QOS:{qos}",
					"size": 2
				},
				{
					"value": "DUP:0",
					"size": 1
				},
				{
					"value": "CONTROL PACKET TYPE:3",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH (VARIABLE LENGTH)",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT PUBACK"):
		Simulation.addCustomPDU("MQTT", "MQTT PUBACK", {
			"title": "MQTT PUBACK",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:4",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:2",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT PUBREC"):
		Simulation.addCustomPDU("MQTT", "MQTT PUBREC", {
			"title": "MQTT PUBREC",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:5",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:2",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT PUBREL"):
		Simulation.addCustomPDU("MQTT", "MQTT PUBREL", {
			"title": "MQTT PUBREL",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:2",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:6",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:2",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT PUBCOMP"):
		Simulation.addCustomPDU("MQTT", "MQTT PUBCOMP", {
			"title": "MQTT PUBCOMP",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:7",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:2",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT SUBSCRIBE"):
		Simulation.addCustomPDU("MQTT", "MQTT SUBSCRIBE", {
			"title": "MQTT SUBSCRIBE",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:2",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:8",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH (VARIABLE LENGTH)",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT SUBACK"):
		Simulation.addCustomPDU("MQTT", "MQTT SUBACK", {
			"title": "MQTT SUBACK",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:9",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH (VARIABLE LENGTH)",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT UNSUBSCRIBE"):
		Simulation.addCustomPDU("MQTT", "MQTT UNSUBSCRIBE", {
			"title": "MQTT UNSUBSCRIBE",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:2",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:10",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH (VARIABLE LENGTH)",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT UNSUBACK"):
		Simulation.addCustomPDU("MQTT", "MQTT UNSUBACK", {
			"title": "MQTT UNSUBACK",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:11",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:2",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT PINGREQ"):
		Simulation.addCustomPDU("MQTT", "MQTT PINGREQ", {
			"title": "MQTT PINGREQ",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:12",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:0",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT PINGRESP"):
		Simulation.addCustomPDU("MQTT", "MQTT PINGRESP", {
			"title": "MQTT PINGRESP",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:13",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:0",
					"size": 8
				}
			]
		})
	
	if not Simulation.hasCustomPDU("MQTT", "MQTT DISCONNECT"):
		Simulation.addCustomPDU("MQTT", "MQTT DISCONNECT", {
			"title": "MQTT DISCONNECT",
			"units": "Bits",
			"unit_marks": [4],
			"width": 8,
			"fields": [
				{
					"value": "RESERVED:0",
					"size": 4
				},
				{
					"value": "CONTROL PACKET TYPE:14",
					"size": 4
				},
				{
					"value": "REMAINING LENGTH:0",
					"size": 8
				}
			]
		})

def enable_service():
	global server_enabled
	
	server_enabled = True
	setDeviceProperty(getName(), "MQTT_BROKER_ENABLED", str(server_enabled))
	return True

def disable_service():
	global authorized_users, clients, subscriptions, server_enabled
	
	authorized_users = {}
	setDeviceProperty(getName(), "MQTT_BROKER_AUTHORIZED_USERS", str(authorized_users))
	clients = {}
	setDeviceProperty(getName(), "MQTT_BROKER_CLIENTS", str(clients))
	subscriptions = {}
	unconverted_subscriptions = {}
	setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))
	server_enabled = False
	setDeviceProperty(getName(), "MQTT_BROKER_ENABLED", str(server_enabled))
	return True

def add_user(username, password):
	global authorized_users
	
	if username == "":
		return False
	elif username == "" and password != "":
		return False
	elif username not in authorized_users:
		authorized_users[username] = password
		setDeviceProperty(getName(), "MQTT_BROKER_AUTHORIZED_USERS", str(authorized_users))
		return True
	else:
		return False

def remove_user(username):
	global authorized_users
	
	if username == "":
		return False
	elif username in authorized_users:
		authorized_users.pop(username, None)
		setDeviceProperty(getName(), "MQTT_BROKER_AUTHORIZED_USERS", str(authorized_users))
		return True
	else:
		return False

def on_new_client(client):
	import simulation
	
	global clients
	
	client_id = hex(int(time() * 10000000))[2:]
	clients[client_id] = client
	setDeviceProperty(getName(), "MQTT_BROKER_CLIENTS", str(clients))
	client.onConnectionChange(on_connection_change)
	client.onReceiveWithPDUInfo(process_mqtt_packet)
	
	for topic in subscriptions:
		if client_id in subscriptions[topic]:
			subscriptions[topic].remove(client_id)
	
	for topic in unconverted_subscriptions:
		if client_id in unconverted_subscriptions[topic]:
			unconverted_subscriptions[topic].remove(client_id)
			setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))
	
	update_clients_table()
	update_subscriptions_table()
	
	out_packet = {}
	out_packet["cmd"] = "ID"
	out_packet["ID"] = client_id
	pdu_info = PDUInfo(pdu_color)
	pdu_info.addOutMessage("The MQTT broker sends the MQTT client its unique ID. (Cisco Packet Tracer priorietary)")
	pdu_info.setOutFormat("MQTT", "MQTT CONNECT", {})
	client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
	print_event(out_packet)

def update_authorized_users_table():
	if on_gui_update_callback is not None:
		on_gui_update_callback("update_authorized_users_table", json.dumps(authorized_users))

def update_clients_table():
	if on_gui_update_callback is not None:
		on_gui_update_callback("update_clients_table", json.dumps([client for client in clients]))

def update_subscriptions_table():
	if on_gui_update_callback is not None:
		on_gui_update_callback("update_subscriptions_table", json.dumps(subscriptions))

def state():
	state = {}
	state["server_enabled"] = server_enabled
	state["authorized_users"] = authorized_users
	state["clients"] = clients
	state["subscriptions"] = subscriptions
	state["events"] = events
	return state

def print_event(packet):
	global events

	events.append(packet)

	if on_gui_update_callback is not None:
		on_gui_update_callback("print_event", json.dumps(packet))

def on_connection_change(type):
	global clients, subscriptions
	
	if type == 1 or type == 3 or type == 4:
		for client in clients:
			if not clients[client].connected():
				for topic in subscriptions:
					if client in subscriptions[topic]:
						subscriptions[topic].remove(client)
				
				for topic in unconverted_subscriptions:
					if client in unconverted_subscriptions[topic]:
						unconverted_subscriptions[topic].remove(client[:client.rindex("(") - 1])
						setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))
				
				clients.pop(client, None)
				temp_clients = dict(clients)
				
				for temp_client in temp_clients:
					new_client = temp_client[:client.rindex("(") - 1]
					temp_clients[new_client] = temp_clients.pop(temp_client)
				
				setDeviceProperty(getName(), "MQTT_BROKER_CLIENTS", str(temp_clients))
				update_clients_table()
				update_subscriptions_table()

def process_mqtt_packet(in_packet, pdu_info):
	global clients, subscriptions
	
	in_packet = json.loads(in_packet)
	print_event(in_packet)
	
	if in_packet["cmd"] == "CONNECT":
		clients[in_packet["client"]] = clients.pop(in_packet["clientId"])
		temp_clients = dict(clients)

		for client in temp_clients:
			new_client = client[:client.rindex("(") - 1]
			temp_clients[new_client] = temp_clients.pop(client)
		
		update_clients_table()
		setDeviceProperty(getName(), "MQTT_BROKER_CLIENTS", str(temp_clients))
		out_packet = {}
		out_packet["cmd"] = "CONNACK"
		out_packet["client"] = in_packet["client"]
		out_packet["returnCode"] = 0
		out_packet["sessionPresent"] = 0
		pdu_info.addInMessage("The MQTT broker receives a CONNECT message from the MQTT client.")
		pdu_info.addOutMessage("The MQTT broker sends a CONNACK message to the MQTT client.")
		pdu_info.setOutFormat("MQTT", "MQTT CONNACK", {})

		if not server_enabled:
			out_packet["returnCode"] = 3
			clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		elif authorized_users == {} and in_packet["username"] == "" and in_packet["password"] == "":
			clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		elif in_packet["username"] in authorized_users and in_packet["password"] == authorized_users[in_packet["username"]]:
			clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		else:
			out_packet["returnCode"] = 5
			clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		
		print_event(out_packet)
	elif in_packet["cmd"] == "SUBSCRIBE":
		converted_topic = "^" + in_packet["topic"].replace("+", "[^/]+").replace("#", ".+") + "$"
		
		if converted_topic not in subscriptions:
			subscriptions[converted_topic] = []
			unconverted_subscriptions[in_packet["topic"]] = []
			setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))
		
		out_packet = {}
		out_packet["cmd"] = "SUBACK"
		out_packet["client"] = in_packet["client"]
		out_packet["packetId"] = in_packet["packetId"]
		out_packet["topic"] = in_packet["topic"]
		out_packet["qos"] = in_packet["qos"]
		out_packet["returnCode"] = in_packet["qos"]
		pdu_info.addInMessage("The MQTT broker receives a SUBSCRIBE message from the MQTT client.")
		pdu_info.addOutMessage("The MQTT broker sends a SUBACK message to the MQTT client.")
		pdu_info.setOutFormat("MQTT", "MQTT SUBACK", {})
		
		if in_packet["client"] not in subscriptions[converted_topic]:
			subscriptions[converted_topic].append(in_packet["client"])
			unconverted_subscriptions[in_packet["topic"]].append(in_packet["client"][:in_packet["client"].rindex("(") - 1])
			setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))
			clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		else:
			out_packet["returnCode"] = 128
			clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		
		print_event(out_packet)
		update_subscriptions_table()
	elif in_packet["cmd"] == "UNSUBSCRIBE":
		converted_topic = "^" + in_packet["topic"].replace("+", "[^/]+").replace("#", ".+") + "$"
		
		if converted_topic in subscriptions:
			if in_packet["client"] in subscriptions[converted_topic]:
				subscriptions[converted_topic].remove(in_packet["client"])
				unconverted_subscriptions[in_packet["topic"]].remove(in_packet["client"][:in_packet["client"].rindex("(") - 1])
				setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))
		
		out_packet = {}
		out_packet["cmd"] = "UNSUBACK"
		out_packet["client"] = in_packet["client"]
		out_packet["packetId"] = in_packet["packetId"]
		out_packet["topic"] = in_packet["topic"]
		out_packet["qos"] = in_packet["qos"]
		pdu_info.addInMessage("The MQTT broker receives an UNSUBSCRIBE message from the MQTT client.")
		pdu_info.addOutMessage("The MQTT broker sends an UNSUBACK message to the MQTT client.")
		pdu_info.setOutFormat("MQTT", "MQTT UNSUBACK", {})
		clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		print_event(out_packet)
		update_subscriptions_table()
	elif in_packet["cmd"] == "PUBLISH":
		out_packet = {}
		out_packet["cmd"] = "PUBLISH"
		out_packet["client"] = in_packet["client"]

		if "packetId" in in_packet:
			out_packet["packetId"] = in_packet["packetId"]
		
		out_packet["qos"] = in_packet["qos"]
		out_packet["dup"] = in_packet["dup"]
		out_packet["topic"] = in_packet["topic"]
		out_packet["payload"] = in_packet["payload"]
		out_packet["retain"] = in_packet["retain"]
		pdu_info.addInMessage("The MQTT broker receives a PUBLISH message from the MQTT client.")

		if in_packet["qos"] != 2:
			publish_pdu_info = PDUInfo(pdu_color)
			publish_pdu_info.addOutMessage("The MQTT broker sends a PUBLISH message to the MQTT client.")
			publish_pdu_info.setOutFormat("MQTT", "MQTT PUBLISH", {"qos": in_packet["qos"]})

			for subscription in subscriptions:
				if re.search(subscription, in_packet["topic"]):
					for subscriber in subscriptions[subscription]:						
						clients[subscriber].sendWithPDUInfo(json.dumps(out_packet), publish_pdu_info)
						print_event(out_packet)
			
			if in_packet["qos"] == 1:
				out_packet["cmd"] = "PUBACK"
				pdu_info.addOutMessage("The MQTT broker sends a PUBACK message to the MQTT client.")
				pdu_info.setOutFormat("MQTT", "MQTT PUBACK", {})
				clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
				print_event(out_packet)
		else:
			out_packet["cmd"] = "PUBREC"
			pdu_info.addOutMessage("MQTT broker sends a PUBREC to the MQTT client.")
			pdu_info.setOutFormat("MQTT", "MQTT PUBREC", {})
			clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
			print_event(out_packet)
	elif in_packet["cmd"] == "PUBREL":
		out_packet = {}
		out_packet["cmd"] = "PUBLISH"
		out_packet["client"] = in_packet["client"]
		out_packet["packetId"] = in_packet["packetId"]
		out_packet["qos"] = in_packet["qos"]
		out_packet["dup"] = in_packet["dup"]
		out_packet["topic"] = in_packet["topic"]
		out_packet["payload"] = in_packet["payload"]
		out_packet["retain"] = in_packet["retain"]
		pdu_info.addInMessage("The MQTT broker receives a PUBREL message from the MQTT client.")
		publish_pdu_info = PDUInfo(pdu_color)
		publish_pdu_info.addOutMessage("The MQTT broker sends a PUBLISH message to the MQTT client.")
		publish_pdu_info.setOutFormat("MQTT", "MQTT PUBLISH", {"qos": in_packet["qos"]})
		
		for subscription in subscriptions:
			if re.search(subscription, in_packet["topic"]):
				for subscriber in subscriptions[subscription]:					
					clients[subscriber].sendWithPDUInfo(json.dumps(out_packet), publish_pdu_info)
					print_event(out_packet)
		
		out_packet["cmd"] = "PUBCOMP"
		pdu_info.addOutMessage("The MQTT broker sends a PUBCOMP message to the MQTT client.")
		pdu_info.setOutFormat("MQTT", "MQTT PUBCOMP", {})
		clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		print_event(out_packet)
	elif in_packet["cmd"] == "PINGREQ":
		out_packet = {}
		out_packet["cmd"] = "PINGRESP"
		out_packet["client"] = in_packet["client"]
		pdu_info.addInMessage("The MQTT broker receives a PINGREQ message from the MQTT client.")
		pdu_info.addOutMessage("The MQTT broker sends a PINGRESP message to the MQTT client.")
		pdu_info.setOutFormat("MQTT", "MQTT PINGRESP", {})
		clients[in_packet["client"]].sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		print_event(out_packet)
	elif in_packet["cmd"] == "DISCONNECT":
		for topic in subscriptions:
			if in_packet["client"] in subscriptions[topic]:
				subscriptions[topic].remove(in_packet["client"])
		
		for topic in unconverted_subscriptions:
			if in_packet["client"] in unconverted_subscriptions[topic]:
				unconverted_subscriptions[topic].remove(in_packet["client"][:in_packet["client"].rindex("(") - 1])
				setDeviceProperty(getName(), "MQTT_BROKER_SUBSCRIPTIONS", str(unconverted_subscriptions))
		
		pdu_info.addInMessage("The MQTT broker receives a DISCONNECT message from the MQTT client.")
		pdu_info.setAccepted()
		clients.pop(in_packet["client"], None)
		temp_clients = dict(clients)

		for client in temp_clients:
			new_client = client[:client.rindex("(") - 1]
			temp_clients[new_client] = temp_clients.pop(client)
		
		setDeviceProperty(getName(), "MQTT_BROKER_CLIENTS", str(temp_clients))
		update_clients_table()
		update_subscriptions_table()

def onGUIUpdate(callback):
	global on_gui_update_callback
	
	on_gui_update_callback = callback
