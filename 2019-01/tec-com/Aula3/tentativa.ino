const long interval = 10000; // interval at which to blink (milliseconds)
unsigned long previousMillis = 0; // will store last time LED was updated
int ADDRESS = 3;
int DELAY = 100;
int DELAY_READ = 20;
char read_buffer[50];
int index_buffer=0;
int sensor_temp_receb = 0;

struct Mensagem {
   int  pini_id = 21;
   int  end_orig;
   int  end_dest;
   int  tipo;
   int  valor;
   int  checksum = 0;
   int  pfim_id = 12;
   int  count = 0;
   boolean descarta_msg = false;
};

#include <SoftwareSerial.h>
SoftwareSerial RS485(2, 3); // RX, TX
void setup() {
  pinMode(13, OUTPUT);
  pinMode(6, OUTPUT);
  digitalWrite(6, LOW);
  Serial.begin(115200);
  while (!Serial);
  RS485.begin(9600);
  digitalWrite(6, HIGH);
  delay(DELAY);
  delay(DELAY);
  digitalWrite(6, LOW);
}

Mensagem leMensagem(){
  Mensagem read_msg;
  index_buffer = 0;
  read_msg.count = 1;

  while(read_msg.count < 6){
    do{
      read_buffer[index_buffer] = RS485.read();
      index_buffer++;
    } while(read_buffer[index_buffer] != ',');
    
    if(read_msg.count == 1){
      read_msg.end_orig = String(read_buffer).substring(index_buffer).toInt();
      index_buffer = 0;
      read_msg.count++;
    }

    if(read_msg.count == 2){
      read_msg.end_dest = String(read_buffer).substring(index_buffer).toInt();
      index_buffer = 0;
      read_msg.count++;
    }
    
    if(read_msg.count == 3){
      read_msg.tipo = String(read_buffer).substring(index_buffer).toInt();
      index_buffer = 0;
      read_msg.count++;
    }

    if(read_msg.count == 4){
      read_msg.valor = String(read_buffer).substring(index_buffer).toInt();
      index_buffer = 0;
      read_msg.count++;
    }

    if(read_msg.count == 5){
      read_msg.checksum = String(read_buffer).substring(index_buffer).toInt();
      index_buffer = 0;
      read_msg.count++;
    }

    if(read_msg.count == 6){
      read_msg.pfim_id = String(read_buffer).substring(index_buffer).toInt();
      if(read_msg.pfim_id != 12){
        read_msg.descarta_msg = true;
      }
      index_buffer = 0;
      read_msg.count++;
    }
    
  }

  return read_msg;
}

void trataMensagem(Mensagem read_msg){
  if(read_msg.end_orig != ADDRESS){
    //
  }
  else if(read_msg.tipo == 1){
    digitalWrite(13,read_msg.valor);
    //
  }
  else if(read_msg.tipo == 2){
    //
  }
  else if(read_msg.tipo == 3){
    sensor_temp_receb = read_msg.valor;
  }
  else if(read_msg.tipo == 4){
    //
  }
  else if(read_msg.tipo == 5){
    //
  }
  else if(read_msg.tipo == 6){
    //
  }
}

void loop() { // run over and over  
  while (Serial.available()>0) {
    Serial.println("A");
    // Fica lendo o buffer
    read_buffer[index_buffer]= atoi(Serial.read());
    Serial.println(read_buffer[index_buffer]);
    index_buffer++;
    
    if(index_buffer==3){
      // Vê se começa 21
      if(read_buffer[0] == '2' && read_buffer[1] == '1' && read_buffer[2] == ','){
        Mensagem read_msg = leMensagem();
        if (read_msg.descarta_msg == false){
          trataMensagem(read_msg);
        } 
      }
      // Senão, descarta
      else{
         index_buffer = 0;
      }
    }
  }
  if (Serial.available()) {
    delay(100);
    digitalWrite(13, HIGH);
    digitalWrite(6, HIGH);
    delay(DELAY_READ);
    RS485.write(Serial.read());
    delay(DELAY_READ);
    digitalWrite(13, LOW);
    digitalWrite(6, LOW);
    delay(DELAY_READ);
  }
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    delay(100);
    digitalWrite(13, HIGH);
    digitalWrite(6, HIGH);
    delay(DELAY);
    RS485.print(currentMillis);
    RS485.print(" ");
    RS485.print(ADDRESS);
    RS485.println("MATURIDADE");
    delay(DELAY);
    digitalWrite(13, LOW);
    digitalWrite(6, LOW);
    delay(DELAY);
  }
}
