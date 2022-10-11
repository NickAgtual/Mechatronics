#define PWM 6 // ARDUINO PIN 6 - PWM

#define POT A1 // ARDUINO ANALOG PIN 1 - POTENTIOMETER

int pot_val; // DEFINING POTENTIOMETER VALUE AS INTEGER
// RANGE = 0 - 1023

int PWM_val; // DEFINING PWM VALUE AS INTEGER
// RANGE = 0 - 255

void setup() {


pinMode(PWM, OUTPUT); // DEFINING PWM PIN AS OUTPUT

pinMode(POT, INPUT); // DEFINING POT PIN AS INPUT

Serial.begin(9600); // STARTING SERIAL MONITOR

}

void loop() {

// READING POTENTIOMETER VALUE AND ASSIGNING TO pot_val
pot_val = analogRead(POT); 

// MAPPING pot_val TO PWM_val
// MINIMUM PWM VALUE = 39 ; THE MOTOR DOES NOT FUNCTION BELOW THAT VALUE
PWM_val = map(pot_val, 0 , 1023, 39, 255);

// WRITING PWM VALUE TO PWM PIN
analogWrite(PWM, PWM_val);

// PRINTING POTENIIOMETER VALUE AND MAPPED PWM VALUE
Serial.print("; Potentiometer Value =");
Serial.println(pot_val);
Serial.print("PWM Value = ");
Serial.print(PWM_val);
// 10ms DELAY
delay(10);

}
