PROJECT(avrsense)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

SET( AVR_MMCU atmega8 )

SET( AVR_PART m8 )

SET( AVR_F_CPU 1000000 )

INCLUDE(avr.cmake)

AVR_ADD_EXECUTABLE( lesson1 
                    lesson1.c 
                    #usbdrv/usbdrv.h
                    #usbdrv/usbdrv.c
                    #usbdrv/oddebug.c
                    #usbdrv/usbdrvasm.S
                  )

