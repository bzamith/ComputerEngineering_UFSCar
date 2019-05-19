from cli import *
from gui import *
import json
from physical import *
import random
import re
from simulation import *
from tcp import *

client = None
broker_address = ""
username = ""
password = ""
subscriptions = []
messages = []
events = []
pingreq_sent = False
pingresp_received = False
pdu_color = 0x79237c

on_connect_callback = None
on_disconnect_callback = None
on_subscribe_callback = None
on_unsubscribe_callback = None
on_publish_callback = None
on_message_received_callback = None
on_gui_update_callback = None

setDeviceProperty(getName(), "MQTT_CLIENT_BROKER_ADDRESS", broker_address)
setDeviceProperty(getName(), "MQTT_CLIENT_USERNAME", username)
setDeviceProperty(getName(), "MQTT_CLIENT_PASSWORD", password)
setDeviceProperty(getName(), "MQTT_CLIENT_SUBSCRIPTIONS", str(subscriptions))
setDeviceProperty(getName(), "MQTT_CLIENT_MESSAGES", str(messages))

def init():
	import simulation
	
	global client
	
	if client is None:
		client = TCPClient()
		client.onConnectionChange(on_connection_change)
		client.onReceiveWithPDUInfo(process_mqtt_packet)
	
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

def connect(broker, user, pwd):
	global broker_address, username, password
	
	regex = r"^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$|^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$"
	
	if re.match(regex, broker) is None:
		if on_connect_callback is not None:
			on_connect_callback("Error", "Invalid broker address.", {})
	elif not username and password:
		if on_connect_callback is not None:
			on_connect_callback("Error", "Username cannot be empty while password is non-empty.", {})
	else:
		client.connect(broker, 1883)
		broker_address = broker
		setDeviceProperty(getName(), "MQTT_CLIENT_BROKER_ADDRESS", broker_address)
		username = user
		setDeviceProperty(getName(), "MQTT_CLIENT_USERNAME", username)
		password = pwd
		setDeviceProperty(getName(), "MQTT_CLIENT_PASSWORD", password)

def disconnect():
	out_packet = {}
	out_packet["cmd"] = "DISCONNECT"
	out_packet["client"] = client.ID
	pdu_info = PDUInfo(pdu_color)
	pdu_info.addOutMessage("The MQTT client sends a DISCONNECT message to the MQTT broker.")
	pdu_info.setOutFormat("MQTT", "MQTT DISCONNECT", {})
	client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
	on_disconnected()
	print_event(out_packet)
	
	if on_disconnect_callback is not None:
		on_disconnect_callback("Success", "Disconnected from MQTT broker.", out_packet)

def subscribe(topic):
	if topic:
		if topic[0] == "$":
			if on_gui_update_callback is not None:
				on_gui_update_callback("subscribe_fail", {"topic": topic})
			
			if on_subscribe_callback is not None:
				on_subscribe_callback("Error", "Topic cannot start with $.", {})
		elif "#" in topic and topic[-1] is not "#":
			if on_gui_update_callback is not None:
				on_gui_update_callback("subscribe_fail", {"topic": topic})
			
			if on_subscribe_callback is not None:
				on_subscribe_callback("Error", "Multi-level wildcard must be at the end of the topic.", {})
		elif topic in subscriptions:
			if on_gui_update_callback is not None:
				on_gui_update_callback("subscribe_fail", {"topic": topic})
			
			if on_subscribe_callback is not None:
				on_subscribe_callback("Error", "Already subscribed to " + topic + ".", {})
		else:
			out_packet = {}
			out_packet["cmd"] = "SUBSCRIBE"
			out_packet["client"] = client.ID
			out_packet["packetId"] = random.randint(1, 65535)
			out_packet["topic"] = topic
			out_packet["qos"] = 0
			pdu_info = PDUInfo(pdu_color)
			pdu_info.addOutMessage("The MQTT client sends a SUBSCRIBE message to the MQTT broker.")
			pdu_info.setOutFormat("MQTT", "MQTT SUBSCRIBE", {})
			client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
			print_event(out_packet)
	else:
		if on_gui_update_callback is not None:
			on_gui_update_callback("subscribe_fail", {"topic": topic})
		
		if on_subscribe_callback is not None:
			on_subscribe_callback("Error", "Topic cannot be empty.", {})

def unsubscribe(topic):
	if topic:
		if topic[0] == "$":
			if on_gui_update_callback is not None:
				on_gui_update_callback("unsubscribe_fail", {"topic": topic})
			
			if on_unsubscribe_callback is not None:
				on_unsubscribe_callback("Error", "Topic cannot start with $.", {})
		elif "#" in topic and topic[-1] is not "#":
			if on_gui_update_callback is not None:
				on_gui_update_callback("unsubscribe_fail", {"topic": topic})
			
			if on_unsubscribe_callback is not None:
				on_unsubscribe_callback("Error", "Multi-level wildcard must be at the end of the topic.", {})
		elif topic not in subscriptions:
			if on_gui_update_callback is not None:
				on_gui_update_callback("unsubscribe_fail", {"topic": topic})
			
			if on_unsubscribe_callback is not None:
				on_unsubscribe_callback("Error", "Already unsubscribed from " + topic + ".", {})
		else:
			out_packet = {}
			out_packet["cmd"] = "UNSUBSCRIBE"
			out_packet["client"] = client.ID
			out_packet["packetId"] = random.randint(1, 65535)
			out_packet["topic"] = topic
			out_packet["qos"] = 0
			pdu_info = PDUInfo(pdu_color)
			pdu_info.addOutMessage("The MQTT client sends an UNSUBSCRIBE message to the MQTT broker.")
			pdu_info.setOutFormat("MQTT", "MQTT UNSUBSCRIBE", {})
			client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
			print_event(out_packet)
	else:
		if on_gui_update_callback is not None:
			on_gui_update_callback("unsubscribe_fail", {"topic": topic})
		
		if on_unsubscribe_callback is not None:
			on_unsubscribe_callback("Error", "Topic cannot be empty.", {})

def publish(topic, payload, qos):
	if not topic:
		if on_gui_update_callback is not None:
			on_gui_update_callback("publish_fail", {"topic": topic, "payload": payload, "qos": int(qos)})
		
		if on_publish_callback is not None:
			on_publish_callback("Error", "Topic cannot be empty.", {})
	elif "#" in topic or "+" in topic:
		if on_gui_update_callback is not None:
			on_gui_update_callback("publish_fail", {"topic": topic, "payload": payload, "qos": int(qos)})
		
		if on_publish_callback is not None:
			on_publish_callback("Error", "Topic cannot contain wildcard characters.", {})
	elif int(qos) < 0 or int(qos) > 2:
		if on_gui_update_callback is not None:
			on_gui_update_callback("publish_fail", {"topic": topic, "payload": payload, "qos": int(qos)})
		
		if on_publish_callback is not None:
			on_publish_callback("Error", "Invalid QoS level.", {})
	else:
		out_packet = {}
		out_packet["cmd"] = "PUBLISH"
		out_packet["client"] = client.ID
		out_packet["packetId"] = random.randint(1, 65535)
		out_packet["qos"] = int(qos)
		out_packet["dup"] = 0
		out_packet["topic"] = topic
		out_packet["payload"] = payload
		out_packet["retain"] = 0
		pdu_info = PDUInfo(pdu_color)
		pdu_info.addOutMessage("The MQTT client sends a PUBLISH message to the MQTT broker.")
		pdu_info.setOutFormat("MQTT", "MQTT PUBLISH", {"qos": int(qos)})

		if int(qos) > 0:
			client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		else:
			out_packet.pop("packetId", None)
			client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)

			if on_gui_update_callback is not None:
				on_gui_update_callback("publish_success", {"topic": topic, "payload": payload, "qos": int(qos)})

			if on_publish_callback is not None:
				on_publish_callback("Success", "Published message '" + payload + "' to topic '" + topic + "' with QoS level " + qos + ".", {"topic": topic, "payload": payload, "qos": int(qos)})
		
		print_event(out_packet)

def pingreq():
	global pingreq_sent, pingresp_received
	
	if client is not None and client.connected():
		if not pingreq_sent:
			out_packet = {}
			out_packet["cmd"] = "PINGREQ"
			out_packet["client"] = client.ID
			pdu_info = PDUInfo(pdu_color)
			pdu_info.addOutMessage("The MQTT client sends a PINGREQ message to the MQTT broker.")
			pdu_info.setOutFormat("MQTT", "MQTT PINGREQ", {})
			client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
			print_event(out_packet)
			pingreq_sent = True
			pingresp_received = False
		elif pingreq_sent and not pingresp_received:
			on_disconnected()

def onConnect(callback):
	global on_connect_callback
	
	on_connect_callback = callback

def onDisconnect(callback):
	global on_disconnect_callback
	
	on_disconnect_callback = callback

def onSubscribe(callback):
	global on_subscribe_callback
	
	on_subscribe_callback = callback

def onUnsubscribe(callback):
	global on_unsubscribe_callback
	
	on_unsubscribe_callback = callback

def onPublish(callback):
	global on_publish_callback
	
	on_publish_callback = callback

def onMessageReceived(callback):
	global on_message_received_callback
	
	on_message_received_callback = callback

def onGUIUpdate(callback):
	global on_gui_update_callback
	
	on_gui_update_callback = callback

def on_connection_change(type):
	if type == 1 or type == 3 or type == 4:
		on_disconnected()

def on_disconnected():
	global client, broker_address, username, password, subscriptions, pingreq_sent, pingresp_received
	
	client.close()
	client = None
	broker_address = ""
	setDeviceProperty(getName(), "MQTT_CLIENT_BROKER_ADDRESS", "")
	username = ""
	setDeviceProperty(getName(), "MQTT_CLIENT_USERNAME", "")
	password = ""
	setDeviceProperty(getName(), "MQTT_CLIENT_PASSWORD", "")
	subscriptions = []
	setDeviceProperty(getName(), "MQTT_CLIENT_SUBSCRIPTIONS", str([]))
	pingreq_sent = False
	pingresp_received = False

	if on_gui_update_callback is not None:
		on_gui_update_callback("disconnected", {})
	
	if on_disconnect_callback is not None:
		on_disconnect_callback("Success", "Disconnected from MQTT broker.", {})

def state():
	state = {}
	
	if client is not None:
		state["connected"] = client.connected()
	else:
		state["connected"] = False
	
	state["broker_address"] = broker_address
	state["username"] = username
	state["password"] = password
	state["subscriptions"] = subscriptions
	state["messages"] = messages
	state["events"] = events
	state["pingreq_sent"] = pingreq_sent
	state["pingresp_received"] = pingresp_received
	return state

def print_event(packet):
	global events

	events.append(packet)

	if on_gui_update_callback is not None:
		on_gui_update_callback("print_event", packet)

def process_mqtt_packet(in_packet, pdu_info):
	global client, subscriptions, messages, pingreq_sent, pingresp_received
	
	in_packet = json.loads(in_packet)
	print_event(in_packet)
	
	if in_packet["cmd"] == "ID":
		client.ID = getName() + " (" + in_packet["ID"] + ")"

		out_packet = {}
		out_packet["cmd"] = "CONNECT"
		out_packet["client"] = client.ID
		out_packet["protocolId"] = "MQTT"
		out_packet["protocolVersion"] = "3.1.1"
		out_packet["clean"] = 1
		out_packet["clientId"] = in_packet["ID"]
		out_packet["keepalive"] = 60
		out_packet["username"] = username
		out_packet["password"] = password
		out_packet["will"] = {}
		pdu_info.addInMessage("The MQTT client receives a unique ID from the MQTT broker.")
		pdu_info.addOutMessage("The MQTT client sends a CONNECT message to the MQTT broker.")
		pdu_info.setOutFormat("MQTT", "MQTT CONNECT", {})
		client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		print_event(out_packet)
	elif in_packet["cmd"] == "CONNACK":
		pdu_info.addInMessage("The MQTT client receives a CONNACK message from the MQTT broker.")
		pdu_info.setAccepted()
		
		if in_packet["returnCode"] == 0:
			if on_gui_update_callback is not None:
				on_gui_update_callback("connected", {"broker_address": broker_address, "username": username, "password": password, "subscriptions": subscriptions})
			
			if on_connect_callback is not None:
				on_connect_callback("Success", "Connected to broker at " + broker_address + ".", in_packet)
		elif in_packet["returnCode"] == 3:
			on_disconnected()

			if on_gui_update_callback is not None:
				on_gui_update_callback("server_unavailable", {})
			
			if on_connect_callback is not None:
				on_connect_callback("Error", "Server is unavailable.", in_packet)
		elif in_packet["returnCode"] == 5:
			on_disconnected()

			if on_gui_update_callback is not None:
				on_gui_update_callback("unauthorized", {})
			
			if on_connect_callback is not None:
				on_connect_callback("Error", "Unauthorized", in_packet)
	elif in_packet["cmd"] == "SUBACK":
		pdu_info.addInMessage("The MQTT client receives a SUBACK message from the MQTT broker.")
		pdu_info.setAccepted()

		if in_packet["returnCode"] == 0 or in_packet["returnCode"] == 1 or in_packet["returnCode"] == 2:
			subscriptions.append(in_packet["topic"])
			setDeviceProperty(getName(), "MQTT_CLIENT_SUBSCRIPTIONS", str(subscriptions))

			if on_gui_update_callback is not None:
				on_gui_update_callback("subscribe_success", {"topic": in_packet["topic"]})
			
			if on_subscribe_callback is not None:
				on_subscribe_callback("Success", "Subscribed to " + in_packet["topic"] + ".", in_packet)
		elif in_packet["returnCode"] == 128:
			if on_gui_update_callback is not None:
				on_gui_update_callback("subscribe_fail", {"topic": in_packet["topic"]})
			
			if on_subscribe_callback is not None:
				on_subscribe_callback("Error", "Cannot subscribe to " + in_packet["topic"] + ".", in_packet)
	elif in_packet["cmd"] == "UNSUBACK":
		pdu_info.addInMessage("The MQTT client receives an UNSUBACK message from the MQTT broker.")
		pdu_info.setAccepted()
		subscriptions.remove(in_packet["topic"])
		setDeviceProperty(getName(), "MQTT_CLIENT_SUBSCRIPTIONS", str(subscriptions))

		if on_gui_update_callback is not None:
			on_gui_update_callback("unsubscribe_success", {"topic": in_packet["topic"]})
		
		if on_unsubscribe_callback is not None:
			on_unsubscribe_callback("Success", "Unsubscribed from " + in_packet["topic"] + ".", in_packet)
	elif in_packet["cmd"] == "PUBLISH":
		pdu_info.addInMessage("The MQTT client receives a PUBLISH message from the MQTT broker.")
		pdu_info.setAccepted()
		temp_messages = list(messages)
		temp_packet = dict(in_packet)
		temp_packet["client"] = temp_packet["client"][:temp_packet["client"].rindex("(") - 1]
		messages.append(in_packet)
		temp_messages.append(temp_packet)
		setDeviceProperty(getName(), "MQTT_CLIENT_MESSAGES", str(temp_messages))

		if on_gui_update_callback is not None:
			on_gui_update_callback("message_received", {"topic": in_packet["topic"], "payload": in_packet["payload"]})
		
		if on_message_received_callback is not None:
			on_message_received_callback("Success", "Received message '" + in_packet["payload"] + "' from topic '" + in_packet["topic"] + "'.", in_packet)
	elif in_packet["cmd"] == "PUBACK":
		pdu_info.addInMessage("The MQTT client receives a PUBACK message from the MQTT broker.")
		pdu_info.setAccepted()

		if on_gui_update_callback is not None:
			on_gui_update_callback("publish_success", {"topic": in_packet["topic"], "payload": in_packet["payload"], "qos": in_packet["qos"]})
		
		if on_publish_callback is not None:
			on_publish_callback("Success", "Published message '" + in_packet["payload"] + "' to topic '" + in_packet["topic"] + "' with QoS level " + str(in_packet["qos"]) + ".", in_packet)
	elif in_packet["cmd"] == "PUBREC":
		out_packet = {}
		out_packet["cmd"] = "PUBREL"
		out_packet["client"] = client.ID
		out_packet["packetId"] = in_packet["packetId"]
		out_packet["qos"] = in_packet["qos"]
		out_packet["dup"] = in_packet["dup"]
		out_packet["topic"] = in_packet["topic"]
		out_packet["payload"] = in_packet["payload"]
		out_packet["retain"] = in_packet["retain"]
		pdu_info.addInMessage("The MQTT client receives a PUBREC message from the MQTT broker.")
		pdu_info.addOutMessage("The MQTT client sends a PUBREL message to the MQTT broker.")
		pdu_info.setOutFormat("MQTT", "MQTT PUBREL", {})
		client.sendWithPDUInfo(json.dumps(out_packet), pdu_info)
		print_event(out_packet)
	elif in_packet["cmd"] == "PUBCOMP":
		pdu_info.addInMessage("The MQTT client receives a PUBCOMP message from the MQTT broker.")
		pdu_info.setAccepted()
		
		if on_gui_update_callback is not None:
			on_gui_update_callback("publish_success", {"topic": in_packet["topic"], "payload": in_packet["payload"], "qos": in_packet["qos"]})
		
		if on_publish_callback is not None:
			on_publish_callback("Success", "Published message '" + in_packet["payload"] + "' to topic '" + in_packet["topic"] + "' with QoS level " + str(in_packet["qos"]) + ".", in_packet)
	elif in_packet["cmd"] == "PINGRESP":
		pdu_info.addInMessage("The MQTT client receives a PINGRESP message from the MQTT broker.")
		pdu_info.setAccepted()
		pingreq_sent = False
		pingreq_received = True
