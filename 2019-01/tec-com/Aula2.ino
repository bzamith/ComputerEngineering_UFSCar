void setup() {
  #define DELAY 100
  #define PORT 8
  pinMode(PORT,OUTPUT);
}

void loop() {
  boolean O[] = {1,1,1,1,0,0,1,0};
  boolean i[] = {1,0,0,1,0,1,1,0};
  boolean e[] = {1,0,1,0,0,1,1,0};
  boolean exclamacao[] = {1,0,0,0,0,1,0,0};
  boolean newline[] = {0,1,0,1,0,0,0,0};
  boolean cr[] = {1,0,1,1,0,0,0,0};
  boolean espaco[] = {0,0,0,0,0,1,0,0};
  
  escreve(O);
  escreve(i);
  escreve(e);
  escreve(exclamacao);
  escreve(newline);
  escreve(cr);
}

void escreve(boolean letra[]){
   int i=0;
   for(i; i<8; i++){
    if(i==0){
      digitalWrite(PORT,HIGH);
      delay(500);
      digitalWrite(PORT,LOW);
      delayMicroseconds(DELAY);
    }
    boolean element = letra[i];
    digitalWrite(PORT,element);
    delayMicroseconds(DELAY);
    if(i==7){
      digitalWrite(PORT,HIGH);
    }
  }  
}
