var UMISENSOR = A0;
var TEMPSENSOR = A1;

function setup() {
	pinMode(UMISENSOR, INPUT);
	Serial.println("Starting Sensor Umidade");
	pinMode(TEMPSENSOR,INPUT);
	Serial.println("Starting Sensor Temperatura");
	
}

function loop() {
	// Lê ambos
	var umi = analogRead(UMISENSOR);
	var temp = analogRead(TEMPSENSOR);
	delay(1000);
	Serial.print("Umidade = ");
	Serial.print(umi);
	Serial.print(" | Temperatura = ");
	Serial.println(temp);
}
