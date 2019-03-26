/*
 Controle de Motores usando Arduino
 Alunos:  Bruna Zamith      628093
          Vinicius Peixoto  628263
 Professor: Edílson Kato
 */

#include <rgb_lcd.h>
#include <Keypad.h>
#include <Stepper.h>

rgb_lcd lcd;

int _condic[4] = {0,1,2,3};
int _revCondic[4] ={0,-3,-2,-1};
int _graus[4] = {0,90,180,270};

char comando = '0';
boolean _cstep = 0;
boolean _cdc = 0;

const byte rows = 4; //four rows
const byte cols = 3; //three columns
char keys[rows][cols] = { {'1','2','3'},
                          {'4','5','6'},
                          {'7','8','9'},
                          {'*','0','#'}};
byte rowPins[rows] = {34, 33, 32, 31}; //connect to the row pinouts of the keypad
byte colPins[cols] = {35, 36, 37}; //connect to the column pinouts of the keypad
Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, rows, cols );

// Motor de passo
const int stepsPerRevolution = 4;  
Stepper myStepper(stepsPerRevolution, 50, 51, 52, 53);
int _directionStep = 1;
boolean _runningStep = 0;
int _countStep = 0;

// Motor DC
const int _pHorario = 11;
const int _pAntiHorario = 10;
boolean _runningDC = 0;
int _velDC = 0;
int _pAtual = _pHorario;
int _pCAtual = _pAntiHorario;

// Velocidades
const int _min = 10;
const int _med = 40;
const int _max = 75;
const int _dcmin = 64;
const int _dcmed = 128;
const int _dcmax = 255;


void setup() {
  // Display LCD
   lcd.begin(16, 2);
}

void loop() {
    comando = keypad.getKey();

    if(comando=='0'){
        lcd.clear();
        lcd.print("0. Parada forcada");
        lcd.setCursor(0,0);
        _runningStep = 0;
        _runningDC = 0;
        _cstep = 0;
        _cdc = 0;
        analogWrite(_pAtual,0);
        analogWrite(_pCAtual,0);
    }

    else if(comando =='*'){
        lcd.clear();
        lcd.print("*. Motor de passo selecionado");
        lcd.setCursor(0,0);
        _cstep = !_cstep;
        _cdc = 0;
    }

    else if(comando =='#'){
      lcd.clear();
      lcd.print("#. Motor DC selecionado");
      lcd.setCursor(0,0);
      _cdc = !_cdc;
      _cstep = 0;
    }

    if(_cstep){
      if(comando=='1'){
        lcd.clear();
        lcd.print("1. Vel. Min.");
        lcd.setCursor(0,0);
        myStepper.setSpeed(_min);
      }
      else if(comando=='2'){
        lcd.clear();
        lcd.print("2. Vel. Med.");
        lcd.setCursor(0,0);       
        myStepper.setSpeed(_med);
      }
      else if(comando=='3'){
        lcd.clear();
        lcd.print("3. Vel. Max.");
        lcd.setCursor(0,0);
        myStepper.setSpeed(_max);
      }
      else if(comando=='4'){
        lcd.clear();
        lcd.print("4. Inversao de Sentido");
        lcd.setCursor(0,0);
        _directionStep = _directionStep * -1;
        if(_countStep == _condic[0]){
          _countStep = _revCondic[0];
        }
        else if(_countStep == _condic[1]){
          _countStep = _revCondic[1];
        }
        else if(_countStep == _condic[2]){
          _countStep = _revCondic[2];
        }
        else if(_countStep == _condic[3]){
          _countStep = _revCondic[3];
        }
        else if(_countStep == _revCondic[0]){
          _countStep = _condic[0];
        }
        else if(_countStep == _revCondic[1]){
          _countStep = _condic[1];
        }
        else if(_countStep == _revCondic[2]){
          _countStep = _condic[2];
        }
        else if(_countStep == _revCondic[3]){
          _countStep = _condic[3];
        }
      }
      else if(comando=='5'){
        lcd.clear();
        lcd.print("5. Running");
        lcd.setCursor(0,0);
        _runningStep = 1;
      }
      else if(comando=='6'){
        lcd.clear();
        lcd.print("6. Stop");
        lcd.setCursor(0,0);
        _runningStep = 0;
      }
      else if(comando=='7'){
        lcd.clear();
        lcd.print("7. 0 graus");
        lcd.setCursor(0,0); 
        if(_directionStep==1){
          while(_countStep!=_condic[0]){
            lcd.clear();
            lcd.print(_countStep);
            lcd.setCursor(0,0); 
             myStepper.step(_directionStep);
            _countStep += _directionStep;
            if(_countStep == 4){
              _countStep = 0;
            }  
          }
        }
        else if(_directionStep==-1){
          while(_countStep!= _revCondic[0]){
            myStepper.step(_directionStep);
            _countStep += _directionStep;
            if(_countStep == -4){
              _countStep = 0;
            }
          }
        }
        _runningStep = 0;
      }
      else if(comando=='8'){
        lcd.clear();
        lcd.print("8. 90 graus");
        lcd.setCursor(0,0); 
        if(_directionStep==1){
          while(_countStep!=_condic[1]){
             myStepper.step(_directionStep);
            _countStep += _directionStep;
            if(_countStep == 4){
              _countStep = 0;
            }  
          }
        }
        else if(_directionStep==-1){
          while(_countStep!= _revCondic[1]){
            myStepper.step(_directionStep);
            _countStep += _directionStep;
            if(_countStep == -4){
              _countStep = 0;
            }
          }
        }
        _runningStep = 0;
      }
      else if(comando=='9'){     
        lcd.clear();
        lcd.print("9. 180 graus");
        lcd.setCursor(0,0); 
        if(_directionStep==1){
          if (_countStep == 2){
            _runningStep = 0;
          }
          else if(_countStep == 1){
            fazStep();
          }
          else if(_countStep == 3){
            fazStep();
            fazStep();
            fazStep();  
          }
          else if(_countStep == 0){
            fazStep();
            fazStep();
          }
        }
        else if(_directionStep==-1){
          if (_countStep == -2){
            _runningStep = 0;
          }
          else if(_countStep == -1){
            fazStep();
          }
          else if(_countStep == -3){
            fazStep();
            fazStep();
            fazStep();  
          }
          else if(_countStep == 0){
            fazStep();
            fazStep();
          }
        }
        _runningStep = 0;
      }

    if(_runningStep){
      lcd.clear();
      lcd.print(_countStep);
      lcd.setCursor(0,0); 
          myStepper.step(_directionStep);
          _countStep += _directionStep;
          if(_countStep == 4 || _countStep == -4){
            _countStep = 0;
          } 
      }
    
    }

    if(_cdc){
      if(comando=='1'){
        lcd.clear();
        lcd.print("1. Vel. Min.");
        lcd.setCursor(0,0);
        _velDC = _dcmin;
      }
      else if(comando=='2'){
        lcd.clear();
        lcd.print("2. Vel. Med.");
        lcd.setCursor(0,0);
        _velDC = _dcmed;
      }
      else if(comando=='3'){
        lcd.clear();
        lcd.print("3. Vel. Max.");
        lcd.setCursor(0,0);
        _velDC = _dcmax;      
      }
      else if(comando=='4'){
        lcd.clear();
        lcd.print("4. Inversao de Sentido");
        lcd.setCursor(0,0);
        int temp = _pAtual;
        _pAtual = _pCAtual;
        _pCAtual = temp;
      }
      else if(comando=='5'){
        lcd.clear();
        lcd.print("5. Running");
        lcd.setCursor(0,0);
        _runningDC = 1;
      }
      else if(comando=='6'){
        lcd.clear();
        lcd.print("6. Stop");
        lcd.setCursor(0,0);
        analogWrite(_pAtual,0);
        _runningDC = 0;
      }
       if(_runningDC){
          analogWrite(_pAtual,_velDC);
          analogWrite(_pCAtual,0);
        }
        if(_runningStep){
          myStepper.step(_directionStep);
          _countStep += _directionStep;
          if(_countStep == 4 || _countStep == -4){
            _countStep = 0;
          } 
      }
    }
    
}

void fazStep(){
    myStepper.step(_directionStep);
    _countStep += _directionStep;
    if(_countStep == 4 || _countStep == -4){
      _countStep = 0;
    }
}
