#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>   /* required by usbdrv.h */
#include <usbdrv/usbdrv.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
//#include <usbdrv/oddebug.h>

// Assumptions:
//  LED connected to PORTB
//  F_CPU is defined to be your cpu speed (preprocessor define)

USB_PUBLIC uchar usbFunctionSetup(uchar data[8])
{
  usbRequest_t    *rq = (void *)data;
  static uchar    replyBuf[2];

    usbMsgPtr = replyBuf;
    if(rq->bRequest == 0){  /* ECHO */
        replyBuf[0] = rq->wValue.bytes[0];
        replyBuf[1] = rq->wValue.bytes[1];
        return 2;
    }
    return 0;
}

int main (void)
{
  uchar i;

  // set PORTA for output
  DDRA = 0xFF;

  DDRD = ~(1 << 2);   /* all outputs except PD2 = INT0 */
  PORTD = 0;
  PORTB = 0;          /* no pullups on USB pins */
  /* We fake an USB disconnect by pulling D+ and D- to 0 during reset. This is
   * necessary if we had a watchdog reset or brownout reset to notify the host
   * that it should re-enumerate the device. Otherwise the host's and device's
   * concept of the device-ID would be out of sync.
   */
  DDRB = ~USBMASK;    /* set all pins as outputs except USB */
  //computeOutputStatus();  /* set output status before we do the delay */
  usbDeviceDisconnect();  /* enforce re-enumeration, do this while interrupts are disabled! */
  i = 0;
  while(--i){         /* fake USB disconnect for > 500 ms */
      wdt_reset();
      _delay_ms(2);
  }
  usbDeviceConnect();
  TCCR0 = 5;          /* set prescaler to 1/1024 */
  usbInit();
  sei();
  for(;;)
  {    /* main event loop */
      wdt_reset();
      usbPoll();
      //if(TIFR & (1 << TOV0))
      //{
      //  TIFR |= 1 << TOV0;  /* clear pending flag */
      //  timerInterrupt();
      //}
  }

  return 0;
}


