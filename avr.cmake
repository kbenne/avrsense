FUNCTION( AVR_ADD_EXECUTABLE target_name )

  IF( NOT AVR_MMCU )
    SET( AVR_MMCU atmega8 )
  ENDIF()

  IF( NOT AVR_PART )
    SET( AVR_PART m8 )
  ENDIF()

  IF( NOT AVR_F_CPU )
    SET( AVR_F_CPU 1000000 )
  ENDIF()

  FOREACH(  src_file ${ARGN} )

    GET_FILENAME_COMPONENT( extension "${src_file}" EXT )

    IF( IS_ABSOLUTE "${src_file}" )

      FILE( RELATIVE_PATH rel_src_file "${CMAKE_CURRENT_SOURCE_DIR}" "${src_file}" )

      SET( full_src_file "${src_file}" )

    ELSE()

      SET( rel_src_file "${src_file}" )

      SET( full_src_file "${CMAKE_CURRENT_SOURCE_DIR}/${src_file}" )

    ENDIF()

    IF( extension STREQUAL ".c" )

      GET_FILENAME_COMPONENT( src_file_name "${src_file}" NAME )

      STRING(REGEX REPLACE "\\.c$" ".o" rel_object_file "${src_file_name}")
  
      LIST( APPEND object_files "${CMAKE_CURRENT_BINARY_DIR}/${rel_object_file}" )
      
      ADD_CUSTOM_COMMAND( OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${rel_object_file}
        COMMAND avr-gcc -mmcu=${AVR_MMCU} -DF_CPU=${AVR_F_CPU} -O1 ${full_src_file} 
                -c 
                -o ${CMAKE_CURRENT_BINARY_DIR}/${rel_object_file} 
                -I"${CMAKE_SOURCE_DIR}"
        DEPENDS ${full_src_file} )

    ENDIF()

    IF( extension STREQUAL ".S" )

      LIST( APPEND asm_files "${full_src_file}" )

    ENDIF()

    IF( extension STREQUAL ".h" )

      LIST( APPEND header_files "${full_src_file}" )

    ENDIF()
  
  ENDFOREACH()

  ADD_CUSTOM_COMMAND( OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.elf
    COMMAND avr-gcc -mmcu=${AVR_MMCU} -DF_CPU=${AVR_F_CPU} -o ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.elf 
    ${object_files} 
    ${asm_files}
    DEPENDS ${object_files} ${header_files} ${asm_files})

  ADD_CUSTOM_COMMAND( OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.hex
    COMMAND avr-objcopy -j .text -j .data -O ihex ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.elf 
            ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.hex 
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.elf )

  ADD_CUSTOM_TARGET( ${target_name} ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.elf )

  ADD_CUSTOM_TARGET( ${target_name}_hex DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.hex )

  ADD_CUSTOM_TARGET( deploy_${target_name} 
                     COMMAND avrdude -P usb -p ${AVR_PART} -c avrisp2 -e -U flash:w:${CMAKE_CURRENT_BINARY_DIR}/${target_name}.hex
                     DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target_name}.hex )

ENDFUNCTION()

