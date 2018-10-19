#!/bin/bash

while true; do                                                                                                                                                                                 
  mpuTemp=$(./omapconf show hwtemp mpu | head -21 | tail -1)                                                                                                                                     
  timestamp=$(./timestamp)                                                                                                                                                                       
  echo "$timestamp $mpuTemp" >> Temperatures.log                                                                                                                                               
  usleep 1000                                                                                                                                                                                    
done

