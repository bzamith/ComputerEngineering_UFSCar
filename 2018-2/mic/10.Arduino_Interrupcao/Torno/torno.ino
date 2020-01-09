#include <rgb_lcd.h>
#include <TimerOne.h>

rgb_lcd lcd;

// Botoes e portas
const int botao_start = 5;
const int botao_se = 3;
const int portaA = 8;
const int portaB = 9;
const int porta_c1 = 6;
const int porta_c2 = 7;

// Flags
bool flag_stop = 0;
bool flag_start = 0;
bool sensorA = 0;
bool sensorB = 0;
bool vel_config = 0;
bool c1 = 0;
bool c2 = 0;

// Motor DC
const int motor = 11;
boolean run_motor = 0;
int vel = 0;
int count = 0;

void setup(){
	 // Display LCD
	lcd.begin(16, 2);
	
	// Interrupcao
	attachInterrupt(0, stop_motor, RISING);
	
	// Botoes
	pinMode(botao_start,INPUT);
	pinMode(botao_se,INPUT);
	pinMode(porta_c1,INPUT);
	pinMode(porta_c2,INPUT);
  pinMode(portaA, INPUT);
  pinMode(portaB, INPUT);
  
  pinMode(motor, OUTPUT);

  //Watchdog
  pinMode(13, OUTPUT);

  //Timer
  Timer1.initialize(16667);  //16,67ms = 60Hz
  Timer1.attachInterrupt(watchdog);

  
}

void loop(){
  flag_stop = 0;
	while(!flag_start){
    if(flag_stop){
      lcd.clear();
      lcd.print("STOPPED!");
      break;
    }
		flag_start = digitalRead(botao_start);	
	  if(flag_stop){
      lcd.clear();
      lcd.print("STOPPED!");
      break;
    }
	}
  if(count==0 && !flag_stop){
    lcd.clear();
    lcd.print("TURNED ON!");
    count++;
  }
  while(!sensorA){
    if(flag_stop){
      lcd.clear();
      lcd.print("STOPPED!");
      break;
    }
    sensorA = digitalRead(portaA);
    if(flag_stop){
      lcd.clear();
      lcd.print("STOPPED!");
      break;
    }
  }
  if(sensorA && !flag_stop) {
    lcd.clear();
    lcd.print("ENTRAR COD. VEL.!");
    vel_config=0; 
    while(!vel_config){
      if(flag_stop){
        lcd.clear();
        lcd.print("STOPPED!");
        break;
      }
      vel_config = configura_velocidade();
      if(flag_stop){
        lcd.clear();
        lcd.print("STOPPED!");
        break;
      }
    }
    if(run_motor && !flag_stop){
      set_motor();
    }
    if(flag_stop){
      lcd.clear();
      lcd.print("STOPPED!");
    }
    else{
      lcd.clear();
      lcd.print("RODANDO!");
    }
    while(!sensorB){
      if(flag_stop){
        lcd.clear();
        lcd.print("STOPPED!");
        break;
      }
      sensorB = digitalRead(portaB);
      if(flag_stop){
        lcd.clear();
        lcd.print("STOPPED!");
        break;
      } 
    }
    if(sensorB && !flag_stop){
      lcd.clear();
      lcd.print("FIM DA PECA!");
      wait_motor();
    }
    if(flag_stop){
      lcd.clear();
      lcd.print("STOPPED!");
    }
  }
  sensorA = 0;
  sensorB = 0;
}
	
bool configura_velocidade(){
	if(digitalRead(botao_se)){
		c1 = digitalRead(porta_c1);
		c2 = digitalRead(porta_c2);
		if(!c1 && !c2){ // codigo A
			vel = 51;
			run_motor = 1;
			return 1;
		}
		else if(c1 && !c2){ // codigo B
			vel = 102;
			run_motor = 1;
			return 1;
		}
		else if(!c1 && c2){ // codigo C
			vel = 128;
			run_motor = 1;
			return 1;
		}
		else if(c1 && c2){ // codigo D
			vel = 153;
			run_motor = 1;
			return 1;
		}
	}
	return 0;
}

bool set_motor(){
	if(run_motor){
		analogWrite(motor,vel);
		return 1;
	}
	return 0;

}

bool wait_motor(){
  analogWrite(motor,0);
  lcd.clear();
  lcd.print("NOVA PECA");
  sensorA=0;
  sensorB=0;
}

void stop_motor(){
	flag_start = 0;
  flag_stop = 1;
  run_motor = 0;
  count = 0;
	analogWrite(motor,0);
}

void watchdog(){
  digitalWrite(13, digitalRead(13)^1);
}
