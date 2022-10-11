// Constants
#define triggerPin  9
#define echoPin    10
#define unitIncm    1
#define unitIninch  2

#define left_motor_speed 6
#define left_motor_fwd   7
#define left_motor_bck   8

#define right_motor_speed 3
#define right_motor_fwd   4
#define right_motor_bck   5

// Function prototypes. We use this to list the functions the loop function will use
long measure_distance ( int option );
void march_forward( int duration );
void stop_car( int duration );
void left( int duration );
void spin_left(int duration);
void right(int duration);
void spin_right( int duration );
void march_backwards(int duration);

// Global variables
long measured_distance, duration;

void setup() {
  
  // put your setup code here, to run once:

  //Serial Port begin
  Serial.begin (9600);
  
  //Define inputs and outputs
  pinMode( triggerPin, OUTPUT);
  pinMode(    echoPin, INPUT);

  pinMode( left_motor_speed , OUTPUT );
  pinMode( left_motor_fwd   , OUTPUT );
  pinMode( left_motor_bck   , OUTPUT );

  pinMode( right_motor_speed , OUTPUT );
  pinMode( right_motor_fwd   , OUTPUT );
  pinMode( right_motor_bck   , OUTPUT );

}

void loop() {
  // put your main code here, to run repeatedly:

  int set_distance = 8;
  
  measured_distance = measure_distance( unitIninch );

  Serial.print(" Measured Distance ");  
  Serial.print( measured_distance );
  Serial.print(" inch");
  Serial.println();


if (measured_distance < set_distance) {

  march_backwards(1);

  
}

else if (measured_distance > set_distance) {

  march_forward(1);

}

else {

  stop_car(5);
}

  delay(100);

}


// **********************************************************************************
// **********************************************************************************
// **********************************************************************************
// ***********************          FUNCTIONS        ********************************

long measure_distance ( int option )
{
  // Input: option: chooses physical units for distance
  //                option = 1           : distance in cm
  //                option = 2           : distance in inches
  //                option = other value : distance in cm (default)
  
  long transit_time, dcm, dinch;
  
  // 1) Send a short LOW pulse to ensure a clean HIGH pulse:
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(5);
  // 2) Start the HIGH pulse and keep it for 10 us (microseconds)
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  // 3) End the pulse
  digitalWrite(triggerPin, LOW);

  // Read the signal from the ultrasonic sensor: 
  // A HIGH pulse with transit_time equal the time (in microseconds) 
  // from the sending if the wave to the 
  // reception of its echo off of an object.
  transit_time = pulseIn(echoPin, HIGH);
 
  // Convert time to distance
  // Hint: the speed of sound in air at 20 degree Celsius is 343 m/s
  //
  // Conversion: 343 m/s * 100cm/1m * 1s/1,000,000us = 343 x 10^-4 = 0.0343 cm/us
  // transit_time : is the transit time in microseconds. The measured distance is 
  //                covered in half this time
  //
  // So the equation is:
  //
  //  distance(cm) = (transit_time/2) x ( Speed of Sound in air )
  
  dcm     = (transit_time/2) / 29.1;     // Multiply by 0.0343 or divide by 29.1
  dinch   = (transit_time/2) / 74;       // Multiply by 0.0135 or divide by 74

  if ( option == 2 )
    return dinch;
  else
    return dcm;
 
}

// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------

void march_forward( int duration )     // 
{
  // Controlling right motor
  digitalWrite( right_motor_fwd   ,HIGH );  // 
  digitalWrite( right_motor_bck   ,LOW );     
  analogWrite(  right_motor_speed ,165 );   
  
  // Controlling left motor  
  digitalWrite( left_motor_fwd    ,HIGH);  // 
  digitalWrite( left_motor_bck    ,LOW);
  analogWrite(  left_motor_speed  ,165 ); 
  
  delay(duration * 100);   //  
}

// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------

void stop_car( int duration )  //
{
  // Stop Right Motor
  digitalWrite(right_motor_fwd,LOW);
  digitalWrite(right_motor_bck,LOW);
  
  // Stop Left Motor  
  digitalWrite(left_motor_fwd,LOW);
  digitalWrite(left_motor_bck,LOW);
  delay(duration * 100);//  
}

// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------

void left( int duration )         //
{
  // Controlling Right Motor
  digitalWrite(  right_motor_fwd   , HIGH);  // 
  digitalWrite(  right_motor_bck   , LOW);
  analogWrite(   right_motor_speed , 180);

  // Stopping Left Motor
  digitalWrite(  left_motor_fwd    , LOW);   //
  digitalWrite(  left_motor_bck    , LOW);
  analogWrite(   left_motor_speed  , 0); 
  
  delay(duration * 100);  //  
}


// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------

void spin_left(int duration)         //
{
  // Controlling Right Motor
  digitalWrite(  right_motor_fwd   , HIGH);  // 
  digitalWrite(  right_motor_bck   , LOW);
  analogWrite(   right_motor_speed , 200); 

  // Controlling Left Motor
  digitalWrite(  left_motor_fwd    , LOW);   //
  digitalWrite(  left_motor_bck    , HIGH);
  analogWrite(   left_motor_speed  , 200); 
   
  delay(duration * 100);  //   
}

// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------

void right(int duration)
{
  // Controlling Right Motor
  digitalWrite(   right_motor_fwd   , LOW);   //
  digitalWrite(   right_motor_bck   , LOW);
  analogWrite(    right_motor_speed , 0); 

  // Controlling Left Motor
  digitalWrite(   left_motor_fwd    , HIGH);//
  digitalWrite(   left_motor_bck    , LOW);
  analogWrite(    left_motor_speed  , 200); 
  
  delay(duration * 100);  //  
}

// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------

void spin_right( int duration )        //
{

  // Controlling Right Motor
  digitalWrite(  right_motor_fwd   , LOW );
  digitalWrite(  right_motor_bck   , HIGH);
  analogWrite(   right_motor_speed , 150); 

  // Controlling Left Motor
  digitalWrite(  left_motor_fwd    , HIGH);
  digitalWrite(  left_motor_bck    , LOW);
  analogWrite(   left_motor_speed  , 150);
  
  delay(duration * 100);  //   
}

// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------

void march_backwards(int duration)          //
{

  // Controlling Right Motor
  digitalWrite(  right_motor_fwd   , LOW);  //
  digitalWrite(  right_motor_bck   , HIGH);
  analogWrite(   right_motor_speed , 150);

  // Controlling Left Motor 
  digitalWrite(  left_motor_fwd    , LOW);  //
  digitalWrite(  left_motor_bck    , HIGH);
  analogWrite(   left_motor_speed  , 150);
  
  delay(duration * 100);     //  
}
