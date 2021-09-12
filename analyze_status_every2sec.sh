#!/bin/sh

# INPUTS
t=0
t_steps=4
dt=2
LOGNAME="runtime.log"
PWM_2='0.4800'

# instead of this static textfile can be taken any stdout/stderr
robo_p=$(cat synthetic_data/output_to_analyze.txt)
robo_temp=$(cat synthetic_data/output_to_analyze.txt)

# clear log-file
:>$LOGNAME

HEADER="step; time; PWM_1; PWM_2; RPM; Battery; temp_1; temp_2; PWM_MBRUSH; RPM_MBRUSH; CUR_MBRUSH; PWM_SBRUSH; RPM_SBRUSH; CUR_SBRUSH" 
echo "$HEADER"| tee -a $LOGNAME

while [ $t -le $t_steps ]
do
	time=$(date +%T)
    PWM_1=$(echo "$robo_p" | awk -F '[][]' '/Blower:/ {print $2}')
    RPM=$(echo "$robo_p" | awk -F '[][]' '/Blower:/ {print $4}')
    BAT=$(echo "$robo_p" | awk '/Battery capacity:/ {print substr($3, 1, length($3)-1)}')
    TEMP_1=$(echo "$robo_temp" | awk '/Temp, Main Board:/ {print substr($4, 1, length($4)-2)}')
    TEMP_2=$(echo "$robo_temp" | awk '/Temp, TOF Camera:/ {print substr($4, 1, length($4)-2)}')

    # Main-Brush
    PWM_MBRUSH=$(echo "$robo_p" | awk -F '[][]' '/Main brush:/ {print $2}')
    RPM_MBRUSH=$(echo "$robo_p" | awk -F '[][]' '/Main brush:/ {print $4}')
    CUR_MBRUSH=$(echo "$robo_p" | awk -F '[][]' '/Main brush:/ {print $6}')

    # Side-Brush
    PWM_SBRUSH=$(echo "$robo_p" | awk -F '[][]' '/Side brush:/ {print $2}')
    RPM_SBRUSH=$(echo "$robo_p" | awk -F '[][]' '/Side brush:/ {print $4}')
    CUR_SBRUSH=$(echo "$robo_p" | awk -F '[][]' '/Side brush:/ {print $6}')

    # echo $PWM_SBRUSH
    # echo $RPM_SBRUSH
    # echo $CUR_SBRUSH
 
    # write to Log-file
	echo "$t; $time; $PWM_1; $PWM_2; $RPM; $BAT; $TEMP_1; $TEMP_2; $PWM_MBRUSH; $RPM_MBRUSH; $CUR_MBRUSH; $PWM_SBRUSH; $RPM_SBRUSH; $CUR_SBRUSH" | tee -a $LOGNAME

	sleep $dt
	t=$(( $t + 1))
done
