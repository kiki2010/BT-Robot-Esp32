/*
  Kiki2010
  Base Code to control a BT Robot
  30/01/2025
*/

#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

//Motors Pins
const int MA_F = 15; //Motor A Front
const int MA_B = 2; //Motor A Back
const int MB_F = 4; //Motor B Front
const int MB_B = 16; //Motor B Back

//Velocity control by PWM
const int freq = 1000;
const int resolution = 8;
int velocity = 180;

// Default command for control
char lastCmd = 'S';

void setup() {
  //We start Serial port and BT Serial
  Serial.begin(115200);
  SerialBT.begin("NovaX"); //Or whatever name you want for your robot

  //Set up motors for PWM
  ledcAttach(MA_F, freq, resolution);
  ledcAttach(MA_B, freq, resolution);
  ledcAttach(MB_F, freq, resolution);
  ledcAttach(MB_B, freq, resolution);

  movement('S');
}

void loop() {
  if (SerialBT.available()) {
    char cmd = SerialBT.read();

    //Ignore line breaks
    if (cmd == '\r' || cmd == '\n') return;

    cmd = toupper(cmd); //Uppercase :D

    //Velocity control
    if (cmd == 'V') {
      velocity = SerialBT.parseInt();
      velocity = constrain(velocity, 0, 255);

      //Replace Velocity
      if (lastCmd != 'S') {
        movement(lastCmd);
        return;
      }
    }

    //Movement control
    lastCmd = cmd;

    movement(cmd);
  }
}

//Default Movement
void movement(char c) {
  switch (c) {
    //Front
    case 'F':
      ledcWrite(MA_F, velocity);
      ledcWrite(MB_F, velocity);
      break;

    //Back
    case 'B':
      ledcWrite(MA_B, velocity);
      ledcWrite(MB_B, velocity);
      break;
    
    case 'L':
      ledcWrite(MA_F, velocity);
      ledcWrite(MB_B, velocity);
      break;
    
    case 'R':
      ledcWrite(MA_B, velocity);
      ledcWrite(MB_F, velocity);
      break;
    
    case 'S':
      ledcWrite(MA_F, 0);
      ledcWrite(MB_F, 0);
      ledcWrite(MA_B, 0);
      ledcWrite(MB_B, 0);
      break;
  }
}