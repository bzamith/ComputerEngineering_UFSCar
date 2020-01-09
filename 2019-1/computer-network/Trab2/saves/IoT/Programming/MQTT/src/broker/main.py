from cli import *
from gui import *
import json
import mqttbroker
from time import *

def guiEvent(type, args):
	data = json.loads(args)
	
	if type == "state":
		GUI.update("state", json.dumps(mqttbroker.state()))
		mqttbroker.update_authorized_users_table()
		mqttbroker.update_clients_table()
		mqttbroker.update_subscriptions_table()
	elif type == "enable_service":
		mqttbroker.enable_service()
	elif type == "disable_service":
		mqttbroker.disable_service()
	elif type == "add_user":
		if mqttbroker.add_user(data["username"], data["password"]):
			GUI.update("add_user_success", json.dumps({"username": data["username"], "password": data["password"]}))
		else:
			GUI.update("add_user_fail", json.dumps({"username": data["username"], "password": data["password"]}))
	elif type == "remove_user":
		if mqttbroker.remove_user(data["username"]):
			GUI.update("remove_user_success", json.dumps({"username": data["username"]}))
		else:
			GUI.update("remove_user_fail", json.dumps({"username": data["username"]}))

def cliEvent(type, args):
	if type == "invoked" and args[0] == "mqttbroker":
		if len(args) == 1 or len(args) == 2 and args[1] == "-?" or args[1] == "/?":
			print_cli_usage()
			CLI.exit()
		elif len(args) > 1 and args[1] != "-?" and args[1] != "/?":
			if len(args) == 2 and args[1] == "enable-service":
				mqttbroker.enable_service()
				print "Success: MQTT broker service enabled."
				print ""
				CLI.exit()
			elif len(args) == 2 and args[1] == "disable-service":
				mqttbroker.disable_service()
				print "Success: MQTT broker service disabled."
				print ""
				CLI.exit()
			elif len(args) > 2 and len(args) < 5 and args[1] == "add-user":
				password = ""
				
				if len(args) == 4:
					password = args[3]
				
				if mqttbroker.add_user(args[2], password):
					GUI.update("add_user_success", json.dumps({"username": args[2], "password": password}))
					print "Success: added new user " + args[2] + "."
				else:
					GUI.update("add_user_fail", json.dumps({"username": args[2], "password": password}))
					print "Error: could not add new user " + args[2] + "."
				
				print ""
				CLI.exit()
			elif len(args) == 3 and args[1] == "remove-user":
				if mqttbroker.remove_user(args[2]):
					GUI.update("remove_user_success", json.dumps({"username": args[2]}))
					print "Success: removed user " + args[2] + "."
				else:
					GUI.update("remove_user_fail", json.dumps({"username": args[2]}))
					print "Error: could not remove user " + args[2] + "."
				
				print ""
				CLI.exit()
			elif len(args) == 2 and args[1] == "display-last-event":
				events = mqttbroker.state()["events"]
				
				if len(events) > 0:
					print events[-1]
				
				print ""
				CLI.exit()
			elif len(args) == 2 and args[1] == "display-all-events":
				events = mqttbroker.state()["events"]
				
				for event in events:
					print event
				
				print ""
				CLI.exit()
			else:
				print_cli_usage()
				CLI.exit()
	elif type == "interrupted":
		CLI.exit()

def print_cli_usage():
	print "MQTT Broker"
	print ""
	print "Usage:"
	print "mqttbroker enable-service"
	print "mqttbroker disable-service"
	print "mqttbroker add-user <username> [password]"
	print "mqttbroker remove-user <username>"
	print "mqttbroker display-last-event"
	print "mqttbroker display-all-events"
	print ""

def on_gui_update(msg, data):
	GUI.update(msg, data)

def main():
	GUI.setup()
	CLI.setup()
	mqttbroker.init()
	mqttbroker.onGUIUpdate(on_gui_update)
	
	while True:
		delay(60000)

if __name__ == "__main__":
	main()
