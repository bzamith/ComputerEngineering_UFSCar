#include <TimerOne.h>

int count = 0;
int parar = 0;

void setup() 
{
  pinMode(3, INPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);

  Timer1.initialize(1000000);
  attachInterrupt(0, contarPeca, FALLING);
  Timer1.stop();
}
 
void loop()
{
  parar = digitalRead(3);
  if(!parar){
    digitalWrite(5, LOW);
  }
}

void alarmeInterruption()
{
    Timer1.stop();
    digitalWrite(5, HIGH);
}

void contarPeca(){
  
  Timer1.stop();  
  
  count++;

  switch(count){
    case 4: digitalWrite(4, HIGH); break;
    case 15: digitalWrite(4, HIGH); break;
    case 75: digitalWrite(4, HIGH); break;
    case 100: count = 0; break;
    default: digitalWrite(4, LOW); break;
  }

  Timer1.restart();
  Timer1.attachInterrupt(alarmeInterruption, 1000000);
}
