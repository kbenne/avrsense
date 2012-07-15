PROJECT(avrsense)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

FIND_LIBRARY( LIBUSB usb )

#SET( AVR_MMCU atmega16a )
SET( AVR_MMCU atmega328 )

SET( AVR_PART m16 )

#SET( AVR_F_CPU 12000000 )
SET( AVR_F_CPU 12500000 )

INCLUDE(avr.cmake)

AVR_ADD_EXECUTABLE( lesson1 
                    lesson1/lesson1.c 
                  )

AVR_ADD_EXECUTABLE( lesson2
                    lesson2/firmware/lesson2.c
                    usbdrv/usbdrv.h
                    usbdrv/usbdrv.c
                    usbdrv/oddebug.c
                    usbdrv/usbdrvasm.S
                  )

ADD_EXECUTABLE( lesson2client
  lesson2/commandline/lesson2client.c
)

AVR_INCLUDE_DIRECTORIES( "${CMAKE_SOURCE_DIR}/lesson3/uip" )
AVR_INCLUDE_DIRECTORIES( "${CMAKE_SOURCE_DIR}/lesson3/drivers/interfaces" )
AVR_INCLUDE_DIRECTORIES( "${CMAKE_SOURCE_DIR}/lesson3/drivers/enc28j60" )
AVR_INCLUDE_DIRECTORIES( "${CMAKE_SOURCE_DIR}/lesson3/apps/simple-httpd" )
AVR_INCLUDE_DIRECTORIES( "${CMAKE_SOURCE_DIR}/lesson3/" )

AVR_ADD_EXECUTABLE( lesson3
                    lesson3/apps-conf.h
                    lesson3/clock-arch.c
                    lesson3/clock-arch.h
                    lesson3/global-conf.h
                    lesson3/uip-conf.h

                    lesson3/apps/simple-httpd/simple-httpd.c
                    lesson3/apps/simple-httpd/simple-httpd.h

                    lesson3/uip/clock.h
                    lesson3/uip/lc-addrlabels.h
                    lesson3/uip/lc-switch.h
                    lesson3/uip/lc.h
                    lesson3/uip/psock.c
                    lesson3/uip/psock.h
                    lesson3/uip/pt.h
                    lesson3/uip/timer.c
                    lesson3/uip/timer.h
                    lesson3/uip/uip-fw.c
                    lesson3/uip/uip-fw.h
                    lesson3/uip/uip-neighbor.c
                    lesson3/uip/uip-neighbor.h
                    lesson3/uip/uip.c
                    lesson3/uip/uip.h
                    lesson3/uip/uip_arch.h
                    lesson3/uip/uip_arp.c
                    lesson3/uip/uip_arp.h
                    lesson3/uip/uiplib.c
                    lesson3/uip/uiplib.h
                    lesson3/uip/uipopt.h

                    lesson3/drivers/enc28j60/avrlibdefs.h
                    lesson3/drivers/enc28j60/avrlibtypes.h
                    lesson3/drivers/enc28j60/enc28j60.c
                    lesson3/drivers/enc28j60/enc28j60.h
                    lesson3/drivers/enc28j60/enc28j60conf.h
                    lesson3/drivers/enc28j60/global.h
                    lesson3/drivers/enc28j60/network.c

                    lesson3/drivers/interfaces/network.h
                    lesson3/main.c
                  )

target_link_libraries( lesson2client ${LIBUSB} )

