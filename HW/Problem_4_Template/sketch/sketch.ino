#define POTENTIOMETER A1  // Defining pin A1 as the potentioketer
#define THERMISTOR A0     // Defining A0 as the thermistor
#define HEATER 3          // Defining pin 3 as the heater
#define RED_LED 2         // Defining pin 2 as the red LED
#define GREEN_LED 4       // Defining pin 4 as the green LED

// Defining integers
int pot_val;
int set_point;

// Defining floats
float current_temp;
float current_temp_F;

// Initializing the heater PWM
int heater_PWM = 0;

void setup() {

  // Defining IO
  pinMode(POTENTIOMETER, INPUT);
  pinMode(THERMISTOR, INPUT);
  pinMode(HEATER, OUTPUT);
  pinMode(RED_LED, OUTPUT);
  pinMode(GREEN_LED, OUTPUT);

}

void loop() {

  // Initialiing the heater as off
  analogWrite(HEATER, heater_PWM);

  // Reading the potentiometer value
  pot_val = analogRead(POTENTIOMETER);

  // Mapping the pot values 
  set_point = map(pot_val, 0, 1023, 0, 100);

  // Reading the thermistor and coverting to Farenheit
  current_temp_F = analogRead(THERMISTOR);

  // Mapping the thermistor values
  current_temp = map(current_temp_F, 50, 100, 0, 100);

  // If the current temperature is lower than the setpoint
  if (current_temp < set_point) { 

    // Heater PWM is set to a duty cycle of 75%
    // Max PWM value is 255
    heater_PWM = 191;

    // Heater is written the PWM value
    analogWrite(HEATER, heater_PWM);

    // Red LED is turned on
    digitalWrite(RED_LED, HIGH);

    // Green LED is turned off
    digitalWrite(GREEN_LED, LOW);
  }

  // If the current temperature is greater than or equal to the setpoint
  else if (current_temp >= set_point) {

    // The heater PWM is set to 0
    heater_PWM = 0;

    // The heater is turned off (PWM = 0)
    analogWrite(HEATER, heater_PWM);

    // Red LED is turned off
    digitalWrite(RED_LED, LOW);

    // Green LED is turned on
    digitalWrite(GREEN_LED, HIGH);
  }

}
