
char buffer[10];
int bufferIndex;
char caracter;

#define MAX 6
int valoresRecebidos[MAX];
int posicaoRecebidos=0;

bool dadoPronto = false;
int dadosRecebidos=0;

unsigned long previousMillis = 0; 
const long interval = 50; 

void setup() {
  Serial.begin(115200);
  bufferIndex=0;
  pinMode(8, OUTPUT);
  digitalWrite(8,1);   
}

void loop() {
  lePortaSerial();
  
  if (dadoPronto) {
    //Serial.print("Dados recebidos: ");
    //Serial.println(dadosRecebidos);
    
    if ((valoresRecebidos[0] == 5) && (dadosRecebidos==3)) {
      //Serial.println("Beep");
      tone(8, valoresRecebidos[1], valoresRecebidos[2]);
      delay(valoresRecebidos[2]);
      //noTone(8);
      digitalWrite(8,1);      
    }
    
    if ((valoresRecebidos[0] == 1) && (dadosRecebidos==2)) {
      //Serial.println("LED");
      analogWrite(13, valoresRecebidos[1]);
    }
    
    dadoPronto=false;
    dadosRecebidos=0;
  }
  
  unsigned long currentMillis = millis(); 
  if(currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;    

    Serial.print(valoresRecebidos[0]);
    Serial.print(",");
    Serial.print(valoresRecebidos[1]);
    Serial.print(",");  
    //Serial.println(valoresRecebidos[2]);  
    Serial.println(analogRead(A8));  
  }
  
}

void lePortaSerial() {
  while (Serial.available() > 0) {
    caracter = Serial.read();
    
    if (((caracter >= '0') && (caracter <= '9')) || (caracter == '-')) {
      buffer[bufferIndex] = caracter;
      bufferIndex++;
    }
    else
    {   
      if ((caracter == ',') && (buffer > 0) && (posicaoRecebidos < MAX)) {
        buffer[bufferIndex]=0;      
        valoresRecebidos[posicaoRecebidos] = atoi(buffer);        
        posicaoRecebidos++;
        bufferIndex=0;
      }
      if (caracter == '\n') {
        if ((buffer > 0) && (posicaoRecebidos < MAX)) {
          buffer[bufferIndex]=0;      
          valoresRecebidos[posicaoRecebidos] = atoi(buffer);        

        }
        bufferIndex=0;
        dadosRecebidos=posicaoRecebidos+1;
        posicaoRecebidos=0;
        //  Serial.println("----");
        //for (int i=0; i<MAX; i++) {
        //  Serial.print("valor[");
        //  Serial.print(i);
        //  Serial.print("] = ");
        //  Serial.println(valoresRecebidos[i]);
        //}
        dadoPronto = true;
      }
    }                
  }
}

