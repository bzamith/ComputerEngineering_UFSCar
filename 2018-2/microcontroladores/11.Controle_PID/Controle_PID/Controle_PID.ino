// Controle de temperatura
// Pino 10 aquecedor/resfriador
// 0 --> resfriando (MAX)
// 50 --> desligar
// 100 --> aquecendo (MAX)

// Temperatura: A0 (0 - 1023)
// 0:0
// 1023:100

#define pSENSOR A0
#define pCONTROLE 10

void setup() {
	Serial.begin(9600);
	pinMode(pSENSOR, INPUT);
	pinMode(pCONTROLE, OUTPUT);
}

double error = 0;
double temperature;
double lastTemperature;

double
	KP = 18.0,
	KI = 9.0,
	KD = 10.0;

double 
	P = 0, 
	I = 0, 
	D = 0;

double PID = 0;

double setPoint = 30;
int controlePwm = 50;

long lastProcess = 0;

void loop() {
	//Lê temperatura
	int rawTemp = analogRead(pSENSOR);
	double temperature = map(rawTemp,0,1023,0,100);

	// Implementação do PID
	error = setPoint - temperature;
	float deltaTime = (millis() - lastProcess)/1000.0;
	lastProcess = millis();

	//P
	P = error*KP;

	//I
	I += (error*KI)*deltaTime;

	//D
	D = (lastTemperature - temperature)*KD*deltaTime;
	lastTemperature = temperature;

	//Soma tudo
	PID = P + I + D;

	// converte para controle
	controlePwm = (PID + 50);

  if(controlePwm < 0){
    controlePwm = 0;
  }if(controlePwm > 254){
    controlePwm = 254;
  }

	// Saída de Controle
	analogWrite(pCONTROLE,controlePwm);
}
