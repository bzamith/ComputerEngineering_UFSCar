var SOUNDSENSOR = A0;

function setup() {
	pinMode(SOUNDSENSOR, INPUT);
	Serial.println("Starting Sensor Movimento");
}

function loop() {
	// Lê ambos
	var sound = analogRead(SOUNDSENSOR);
	delay(1000);
	Serial.print("Presenca = ");
	Serial.println(sound);
}
