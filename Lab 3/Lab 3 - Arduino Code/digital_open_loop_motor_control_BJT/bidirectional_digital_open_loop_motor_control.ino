#define ENABLE 5 // ARDUINO PIN 5 – L298N ENABLE A used for MOTOR ENABLE AND PWM

#define DIRA 3 // ARDUINO PIN 3 – L298N IN1 USED FOR MOTOR DIRECTION

#define DIRB 4 // ARDUINO PIN 4 – L298N IN2 USED FOR MOTOR DIRECTION  

#define POT A1 // ARDUINO ANALOG PIN A1 - POTENTIOMETER

void setup() {
// DEFINING PIN MODES
pinMode(ENABLE,OUTPUT);

pinMode(DIRA,OUTPUT); 

pinMode(DIRB,OUTPUT);
 
Serial.begin(9600); // STARTING SERIAL MONITOR

}

void loop() {

// DEFINING read_position as integer & setting equal to potentiometer value (0 - 1023)
int read_position=analogRead(POT); 

// DEFINING converted_position AS INTEGER AND MAPPING TO (-255:255)
int converted_position = map(read_position,0,1023,-255,255); 

// DEFINING forward_stall_PWM & reverse_stall_PWM as integers & setting values
// MOTOR DOES NOT OPERATRE WITHIN THIS RANGE (converted_position)
int forward_stall_PWM = 21;
int reverse_stall_PWM = -11;

// DISPLAYING MAPPED PWM VALUE
Serial.print("PWM VALUE =");
Serial.println(converted_position);



// IF THE CONVERTED VALUE FALLS WITHIN THE MOTOR'S INOPERABLE RANGE
if ((converted_position > reverse_stall_PWM )&&(converted_position < forward_stall_PWM)){ 

  // TURNING MOTOR OFF
  digitalWrite(DIRA, LOW);
  digitalWrite(DIRB, LOW);

  // DISPAYING BOOLEAN VALUES FOR DIRECTION OF MOTOR
  Serial.print("DIRA = ");
  Serial.println(0);
  Serial.print("DIRB = ");
  Serial.println(0);
} 

// IF converted_position IS GREATER THAN 0
else if (converted_position > 0){ 

  // WRITING CONVERTED POSITION VALUE TO MOTOR
  analogWrite(ENABLE, converted_position);

  // SETTING DIRECTION OF MOTOR SPIN
  digitalWrite(DIRA, LOW);
  digitalWrite(DIRB, HIGH);

  //DISPLAYING BOOLEAN VALUES FOR DIRECTION OF MOTOR
  Serial.print("DIRA = ");
  Serial.println(0);
  Serial.print("DIRB = ");
  Serial.println(1);

    } 

// IF converted_position IS LESS THAN 0
else { 
      
  // WRITING CONVERTED POSITION VALUE TO MOTOR
  analogWrite(ENABLE, -converted_position);
  
  // SETTING DIRECTION OF MOTOR SPIN  
  digitalWrite(DIRA, HIGH);
  digitalWrite(DIRB, LOW);

  // DISPLAYING BOOLEAN VALUES FOR DIRECTION OF MOTOR
  Serial.print("DIRA = ");
  Serial.println(1);
  Serial.print("DIRB = ");
  Serial.println(0);

    } 

    // 50ms DELAY
    delay(50); 
}
