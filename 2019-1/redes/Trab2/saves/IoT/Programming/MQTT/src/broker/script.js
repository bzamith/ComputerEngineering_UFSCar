guiEvent("state", JSON.stringify({}));

$(document).ready(function() {
	$("#serviceToggle").change(function() {
		update_gui($(this).prop("checked"));
	});
	
	$("#btnAddUser").on("click", function() {
		var username = $("#inputUsername").val();
		var password = $("#inputPassword").val();
		
		if (!username) {
			$("#msgAddUser").removeClass("text-success").addClass("text-warning");
			$("#msgAddUser").text("Error: username cannot be empty.");
		} else if (!username && password) {
			$("#msgAddUser").removeClass("text-success").addClass("text-warning");
			$("#msgAddUser").text("Error: username cannot be empty and password is non-empty.");
		} else {
			guiEvent("add_user", JSON.stringify({"username": username, "password": password}));
		}
	});
});

function update_gui(server_enabled) {
	if (server_enabled) {
		guiEvent("enable_service", JSON.stringify({}));
		$("#authorizedUsersPanel").removeClass("collapse");
		$("#clientsPanel").removeClass("collapse");
		$("#subscriptionsPanel").removeClass("collapse");
	} else {
		guiEvent("disable_service", JSON.stringify({}));
		$("#authorizedUsersPanel").addClass("collapse");
		$("#inputUsername").val("");
		$("#inputPassword").val("");
		$("#msgAddUser").text("");
		$("#msgRemoveUser").text("");
		$("#clientsPanel").addClass("collapse");
		$("#subscriptionsPanel").addClass("collapse");
		$("#clientsTable").empty();
		$("#subscriptionsTable").empty();
	}
}

function state(server_enabled, events) {
	if (server_enabled) {
		$("#serviceToggle").bootstrapToggle("on");
	} else {
		$("#serviceToggle").bootstrapToggle("off");
	}
	
	update_gui(server_enabled);
	
	$.each(events, function(key, value) {
		$("#eventLogPanelBody").append("<samp class=\"event\"></samp><br>");
		$(".event").last().text(JSON.stringify(value));
	});
}

function update_authorized_users_table(data) {
	if (!$.isEmptyObject(data)) {
		$("#authorizedUsersTable").empty();
		
		for (var username in data) {
			$("#authorizedUsersTable").append("<tr><td class=\"username\"></td><td class=\"password\"></td></tr>");
			$(".username").last().text(username);
			$(".password").last().text(data[username]);
		}
		
		$("#authorizedUsersTable tr").click(function() {
			$(this).addClass("warning").siblings().removeClass("warning");
		});
		$("#btnRemoveUser").on("click", function() {
			var username = $("#authorizedUsersTable tr.warning td:first").text();
			
			if (username) {
				guiEvent("remove_user", JSON.stringify({"username": username}));
			}
		});
	}
}

function update_clients_table(data) {
	$("#clientsTable").empty();
	
	data.forEach(function(client) {
		$("#clientsTable").append("<tr><td>" + client + "</td></tr>");
	});
}

function update_subscriptions_table(data) {
	$("#subscriptionsTable").empty();
	
	for (var topic in data) {
		if (data[topic].length > 0) {
			var guid = guid_generator();
			var original_topic = topic.replace("^", "").replace("[^\/]+", "+").replace(".+", "#").replace("$", "");
			
			$("#subscriptionsTable").append("<tr id='" + guid + "'><td>" + original_topic + "</td>");
			
			var clients = "";
			for (var i = 0; i < data[topic].length; i++) {
				clients += data[topic][i] + "<br>";
			}
			
			$("#" + guid).append("<td>" + clients + "</td>");
			$("#subscriptionsTable").append("</tr>");
		}
	}
}

function add_user_success(username, password) {
	$("#authorizedUsersPanelBody").removeClass("collapse");
	$("#authorizedUsersTable").append("<tr><td class=\"username\"></td><td class=\"password\"></td></tr>");
	$(".username").last().text(username);
	$(".password").last().text(password);
	$("#authorizedUsersTable tr").click(function() {
		$(this).addClass("warning").siblings().removeClass("warning");
	});
	$("#btnRemoveUser").on("click", function() {
		var username = $("#authorizedUsersTable tr.warning td:first").text();
		
		if (username) {
			guiEvent("remove_user", JSON.stringify({"username": username}));
		}
	});
	$("#msgAddUser").removeClass("text-warning").addClass("text-success");
	$("#msgAddUser").text("Success: added " + username + " as an authorized user.");
}

function add_user_fail(username) {
	$("#msgAddUser").removeClass("text-success").addClass("text-warning");
	$("#msgAddUser").text("Error: " + username + " is already an authorized user.");
}

function remove_user_success(username) {
	$("#authorizedUsersTable tr.warning").remove();
	$("#msgRemoveUser").removeClass("text-warning").addClass("text-success");
	$("#msgRemoveUser").text("Success: Removed " + username + " as an authorized user.");
}

function remove_user_fail(username) {
	$("#msgRemoveUser").removeClass("text-success").addClass("text-warning");
	$("#msgRemoveUser").text("Error: " + username + " is not an authorized user.");
}

function print_event(data) {
	$("#eventLogPanelBody").append("<samp class=\"event\"></samp><br>");
	$(".event").last().text(JSON.stringify(data));
}

function guid_generator() {
	var S4 = function() {
		return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
	};
	
    return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}

function update(type, args) {
	data = JSON.parse(args);
	
	if (type === "state") {
		state(data.server_enabled, data.events);
	} else if (type === "update_authorized_users_table") {
		update_authorized_users_table(data);
	} else if (type === "update_clients_table") {
		update_clients_table(data);
	} else if (type === "update_subscriptions_table") {
		update_subscriptions_table(data);
	} else if (type === "add_user_success") {
		add_user_success(data.username, data.password);
	} else if (type === "add_user_fail") {
		add_user_fail(data.username);
	} else if (type === "remove_user_success") {
		remove_user_success(data.username);
	} else if (type === "remove_user_fail") {
		remove_user_fail(data.username);
	} else if (type === "print_event") {
		print_event(data);
	}
}
