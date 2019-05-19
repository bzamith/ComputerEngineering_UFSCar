guiEvent("state", JSON.stringify({}));

$(document).ready(function() {
	$("#btnConnect").on("click", function() {
		if ($("#btnConnect").text() == "Connect") {
			var broker_address = $("#inputBrokerAddress").val();
			var username = $("#inputUsername").val();
			var password = $("#inputPassword").val();
			
			if (!is_valid_address(broker_address)) {
				$("#msgConnection").removeClass("text-success").addClass("text-warning");
				$("#msgConnection").text("Error: invalid broker address.");
			} else if (!username && password) {
				$("#msgConnection").removeClass("text-success").addClass("text-warning");
				$("#msgConnection").text("Error: username cannot be empty while password is non-empty.");
			} else {
				guiEvent("connect", JSON.stringify({"broker_address": broker_address, "username": username, "password": password}));
			}
		} else {
			guiEvent("disconnect", JSON.stringify({}));
		}
	});
	
	$("#btnSubscribe").on("click", function() {
		var topic = $("#inputSubscribeTopic").val();
		
		if (!topic) {
			$("#msgSubscribeTopic").removeClass("text-success").addClass("text-warning");
			$("#msgSubscribeTopic").text("Error: topic cannot be empty.");
		} else if (topic.indexOf("$") === 0) {
			$("#msgSubscribeTopic").removeClass("text-success").addClass("text-warning");
			$("#msgSubscribeTopic").text("Error: topic cannot start with $.");
		} else if ((topic.indexOf("#") > -1) && (topic.slice(-2) !== "/#")) {
			$("#msgSubscribeTopic").removeClass("text-success").addClass("text-warning");
			$("#msgSubscribeTopic").text("Error: multi-level wildcard must be at the end of the topic.");
		} else {
			guiEvent("subscribe", JSON.stringify({"topic": $("#inputSubscribeTopic").val()}));
		}
	});
	
	$("#btnUnsubscribe").on("click", function() {
		var topic = $("#selectUnsubscribeTopic").val();
		
		if (!topic) {
			$("#msgUnsubscribeTopic").removeClass("text-success").addClass("text-warning");
			$("#msgUnsubscribeTopic").text("Error: no topic selected.");
		} else {
			guiEvent("unsubscribe", JSON.stringify({"topic": $("#selectUnsubscribeTopic").val()}));
		}
	});
	
	$("#inputQoS").keydown(function(e) {
		var input = $("#inputQoS")[0];
		var val = $("#inputQoS").val();
		
		if (!val && e.which !== 48 && e.which !== 49 && e.which !== 50) {
			e.preventDefault();
		} else if (val && !is_text_selected(input) && e.which !== 8) {
			e.preventDefault();
		} else if (val && is_text_selected(input) && e.which !== 8 && e.which !== 48 && e.which !== 49 && e.which !== 50) {
			e.preventDefault();
		}
	});

	$("#btnPublish").on("click", function() {
		var topic = $("#inputPublishTopic").val();
		var qos = $("#inputQoS").val();
		
		if (!qos) {
			qos = "0";
		}
		
		if (topic && (topic.indexOf("#") === -1) && (topic.indexOf("+") === -1)) {
			guiEvent("publish", JSON.stringify({"topic": topic, "payload": $("#inputPublishPayload").val(), "qos": qos}));
		} else if (topic === "") {
			$("#msgPublish").removeClass("text-success").addClass("text-warning");
			$("#msgPublish").text("Error: topic cannot be empty.");
		} else if ((topic.indexOf("#") !== -1) || (topic.indexOf("+") !== -1)) {
			$("#msgPublish").removeClass("text-success").addClass("text-warning");
			$("#msgPublish").text("Error: topic cannot contain wildcard characters.");
		}
	});
});

function is_valid_address(addr) {
    return /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$|^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/.test(addr);
}

function is_text_selected(input) {
	if (typeof input.selectionStart === "number") {
		return input.selectionStart === 0 && input.selectionEnd === input.value.length;
	} else if (typeof document.selection !== "undefined") {
		input.focus();
		return document.selection.createRange().text === input.value;
	}
}

function state(bConnected, broker_address, username, password, subscriptions, messages, events) {
	if (bConnected) {
		connected(broker_address, username, password, subscriptions, messages);
	}
	
	$.each(events, function(key, value) {
		$("#eventLogPanelBody").append("<samp class=\"event\"></samp><br>");
		$(".event").last().text(JSON.stringify(value));
	});
}

function connected(broker_address, username, password, subscriptions, messages) {
	$("#inputBrokerAddress").prop("readonly", true).val(broker_address);
	$("#inputUsername").prop("readonly", true).val(username);
	$("#inputPassword").prop("readonly", true).val(password);
	$("#btnConnect").removeClass("btn-success").addClass("btn-danger").text("Disconnect");
	$("#msgConnection").text("");
	$("#subscriptionsPanel").removeClass("collapse");
	
	$.each(subscriptions, function(key, value) {
		$("#selectUnsubscribeTopic").append($("<option></option>").attr("value", value).text(value));
	});
	
	$("#publishPanel").removeClass("collapse");
	$("#messagesPanel").removeClass("collapse");

	$.each(messages, function(key, value) {
		$("#messagesPanelBody").append("<samp class=\"message\"></samp><br>");
		$(".message").last().text(JSON.stringify(value));
	});
}

function server_unavailable() {
	$("#msgConnection").removeClass("text-success").addClass("text-warning");
	$("#msgConnection").text("Error: connection refused, server unavailable.");
}

function unauthorized() {
	$("#msgConnection").removeClass("text-success").addClass("text-warning");
	$("#msgConnection").text("Error: connection refused, not authorized.");
}

function disconnected() {
	$("#inputBrokerAddress").prop("readonly", false);
	$("#inputUsername").prop("readonly", false);
	$("#inputPassword").prop("readonly", false);
	$("#btnConnect").removeClass("btn-danger").addClass("btn-success").text("Connect");
	$("#msgConnection").text("");
	$("#subscriptionsPanel").addClass("collapse");
	$("#inputSubscribeTopic").val("");
	$("#msgSubscribeTopic").text("");
	$("#selectUnsubscribeTopic").empty();
	$("#msgUnsubscribeTopic").text("");
	$("#publishPanel").addClass("collapse");
	$("#inputPublishTopic").val("");
	$("#inputPublishPayload").val("");
	$("#msgPublish").text("");
	$("#messagesPanel").addClass("collapse");
	$("#messagesPanelBody").html("");
}

function subscribe_success(topic) {
	$("#selectUnsubscribeTopic").append($("<option></option>").attr("value", topic).text(topic));
	$("#msgSubscribeTopic").removeClass("text-warning").addClass("text-success");
	$("#msgSubscribeTopic").text("Success: subscribed to " + topic + ".");
}

function subscribe_fail(topic) {
	$("#msgSubscribeTopic").removeClass("text-success").addClass("text-warning");
	$("#msgSubscribeTopic").text("Error: already subscribed to " + topic + ".");
}

function unsubscribe_success(topic) {
	$("#selectUnsubscribeTopic option[value='" + topic + "']").remove();
	$("#msgUnsubscribeTopic").removeClass("text-warning").addClass("text-success");
	$("#msgUnsubscribeTopic").text("Success: unsubscribed from " + topic + ".");
}

function unsubscribe_fail(topic) {
	$("#msgUnsubscribeTopic").removeClass("text-success").addClass("text-warning");
	$("#msgUnsubscribeTopic").text("Error: already unsubscribed from " + topic + ".");
}

function publish_success(topic, payload, qos) {
	$("#msgPublish").removeClass("text-warning").addClass("text-success");
	$("#msgPublish").text("Success: published " + payload + " to " + topic + " with QoS " + qos + ".");
}

function publish_fail(topic, payload, qos) {
	$("#msgPublish").removeClass("text-success").addClass("text-warning");
	$("#msgPublish").text("Error: could not publish " + payload + " to " + topic + " with QoS " + qos + ".");
}

function message_received(data) {
	$("#messagesPanelBody").append("<samp class=\"message\"></samp><br>");
	$(".message").last().text(JSON.stringify(data));
}

function print_event(data) {
	$("#eventLogPanelBody").append("<samp class=\"event\"></samp><br>");
	$(".event").last().text(JSON.stringify(data));
}

function update(type, args) {
	data = JSON.parse(args);
	
	if (type === "state") {
		state(data.connected, data.broker_address, data.username, data.password, data.subscriptions, data.messages, data.events);
	} else if (type === "connected") {
		connected(data.broker_address, data.username, data.password, data.subscriptions);
	} else if (type === "server_unavailable") {
		server_unavailable();
	} else if (type === "unauthorized") {
		unauthorized();
	} else if (type === "disconnected") {
		disconnected();
	} else if (type === "subscribe_success") {
		subscribe_success(data.topic);
	} else if (type === "subscribe_fail") {
		subscribe_fail(data.topic);
	} else if (type === "unsubscribe_success") {
		unsubscribe_success(data.topic);
	} else if (type === "unsubscribe_fail") {
		unsubscribe_fail(data.topic);
	} else if (type === "publish_success") {
		publish_success(data.topic, data.payload, data.qos);
	} else if (type === "publish_fail") {
		publish_fail(data.topic, data.payload, data.qos);
	} else if (type === "message_received") {
		message_received(data);
	} else if (type === "print_event") {
		print_event(data);
	}
}
