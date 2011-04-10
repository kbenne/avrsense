#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>   /* required by usbdrv.h */
#include <usbdrv/usbdrv.h>

// Assumptions:
//  LED connected to PORTB
//  F_CPU is defined to be your cpu speed (preprocessor define)

//usbMsgLen_t usbFunctionSetup(uchar data[8]) 
//{
//  return 0;
//}

int main (void)
{
  // set PORTA for output
  DDRA = 0xFF;
  //PORTA = 0x00;

  while (1) 
  {
    // set PORTB high
    PORTA = 0x01;
    _delay_ms(500);
    
    // set PORTB low
    PORTA = 0x02;
    _delay_ms(500);
  }

  return 0;
}


