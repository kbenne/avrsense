#include <avr/io.h>
#include <util/delay.h>
//#include <avr/pgmspace.h>   /* required by usbdrv.h */
//#include <usbdrv/usbdrv.h>

// Assumptions:
//  LED connected to PORTB
//  F_CPU is defined to be your cpu speed (preprocessor define)

//usbMsgLen_t usbFunctionSetup(uchar data[8]) 
//{
//  return 0;
//}

int main (void)
{
  // set PORTB for output
  DDRB = 0xFF;

  while (1) 
  {
    // set PORTB high
    PORTB = 0xFF;
    _delay_ms(500);
    
    // set PORTB low
    PORTB = 0x00;
    _delay_ms(500);
  }

  return 0;
}


