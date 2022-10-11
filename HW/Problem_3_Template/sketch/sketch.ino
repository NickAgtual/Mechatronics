# define switch_1 7
# define switch_2 8
# define RED_LED 2
# define GREEN_LED 3
# define MOTOR 6

// Initializing both pushbottons in the off position
int switch_1_state = LOW;
int switch_2_state = LOW;

void setup() {

  // Defining IO
  pinMode(switch_1, INPUT);
  pinMode(switch_2, INPUT);
  pinMode(RED_LED, OUTPUT);
  pinMode(GREEN_LED, OUTPUT);
  pinMode(MOTOR, OUTPUT);

}

void loop() {
  
  // Determining the state of both swithces
  switch_1_state = digitalRead(switch_1);
  switch_2_state = digitalRead(switch_2);

  // IF the first swithc is pressed
  if (switch_1_state == HIGH && switch_2_state == LOW) {

    // Turn on the motor
    digitalWrite(MOTOR, HIGH);

    // Turn red LED on and green LED off
    digitalWrite(RED_LED, HIGH);
    digitalWrite(GREEN_LED, LOW);

    // Set state of swich 1 to off
    switch_1_state == LOW;

  }

  // If swith 2 is pressed
  else if (switch_2_state == HIGH && switch_1_state == LOW) {

    // Turn the motor off
    digitalWrite(MOTOR, LOW);  

    // Turn the red LED off and green LED on
    digitalWrite(RED_LED, LOW);
    digitalWrite(GREEN_LED, HIGH);

    // Set the state of switch 2 back to 0
    switch_2_state == LOW;

  }

  // If both buttons are pressed simultaneously
  else if (switch_1_state == HIGH && switch_2_state == HIGH) {

    // Turn the motor off
    digitalWrite(MOTOR, LOW);

    // Turn the red LED off and the green LED on
    digitalWrite(RED_LED, LOW);
    digitalWrite(GREEN_LED, HIGH);

    // Set the state of both swithces to 0
    switch_1_state == LOW;
    switch_2_state == LOW;

  }

}
