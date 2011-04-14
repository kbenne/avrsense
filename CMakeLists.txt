PROJECT(avrsense)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

SET( AVR_MMCU atmega16a )

SET( AVR_PART m16 )

SET( AVR_F_CPU 1000000 )

INCLUDE(avr.cmake)

AVR_ADD_EXECUTABLE( lesson1 
                    lesson1/lesson1.c 
                    #usbdrv/usbdrv.h
                    #usbdrv/usbdrv.c
                    #usbdrv/oddebug.c
                    #usbdrv/usbdrvasm.S
                  )

AVR_ADD_EXECUTABLE( lesson2
                    lesson2/lesson2.c
                  )

