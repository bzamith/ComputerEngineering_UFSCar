const long interval = 10000;           // interval at which to blink (milliseconds)
unsigned long previousMillis = 0;        // will store last time LED was updated

int ADDRESS = 31;

#include <SoftwareSerial.h>

SoftwareSerial RS485(2, 3); // RX, TX

void setup() {
  pinMode(13, OUTPUT);
  pinMode(6, OUTPUT);

  digitalWrite(6, LOW);


  // Open serial communications and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  delay(100);

  Serial.print("BOOT Serial Local: ");
  delay(100);

  Serial.println(ADDRESS);



  // set the data rate for the SoftwareSerial port
  RS485.begin(9600);

  digitalWrite(6, HIGH);
  delay(100);

  RS485.print("BOOT Serial Net: ");
  RS485.println(ADDRESS);
  delay(100);

  digitalWrite(6, LOW);


}

void loop() { // run over and over
  if (RS485.available()) {
    char x = RS485.read();
    Serial.write(x);

    if (x == 'A')
      digitalWrite(13, HIGH);


    if (x == 'B')
      digitalWrite(13, LOW);

  }
  if (Serial.available()) {

    delay(100);
    digitalWrite(13, HIGH);
    digitalWrite(6, HIGH);

    delay(100);
    RS485.write(Serial.read());

    delay(100);
    digitalWrite(13, LOW);
    digitalWrite(6, LOW);

    delay(100);

  }



  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;

    delay(100);
    digitalWrite(13, HIGH);
    digitalWrite(6, HIGH);

    delay(100);
    RS485.print(currentMillis);
    RS485.print(" ");
    RS485.print(ADDRESS);
    RS485.println(": Estou aqui!");

    delay(100);
    digitalWrite(13, LOW);
    digitalWrite(6, LOW);

    delay(100);
  }
}
