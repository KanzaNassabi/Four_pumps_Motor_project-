
list p=16F887
#include <p16F887.inc>
__CONFIG    _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF
__CONFIG    _CONFIG2, _WRT_OFF & _BOR21V & _CP_OFF & _MCLRE_ON & _PWRTE_ON & _WDT_OFF & _INTRC_OSC_NOCLKOUT 



;------ configuration des port -------

ORG 0x00           ; debut du prog
BANKSEL OSCCON     ;definition de l'oscilateur soit interne soit externe ici on utilise l'externe
BCF OSCCON ,0      ;oscilateur exterene
BANKSEL ANSEL      ;selection du bank ou se trouve le resistre ANSEL pour la definition des mode de port soit numerique soit analogique 
CLRF ANSEL         ;les entree I:O en mode numérique 
CLRF ANSELH        ;tt les port sont en mode numérique
BANKSEL TRISB      ;selection du bank ou se trouve le registe trisb
CLRF TRISB         ; le port b en mode OUTPUT
BANKSEL TRISA      ;selection du bank ou se trouve le registe trisA
MOVLW 0xFF  ;
MOVWF TRISA        ;trisA EN MODE INPUT
BANKSEL PORTB      ;selection du bank ou se trouve le registe PORTB
CLRF PORTB         ;mettre en raz le mortB

;------- PGM principale --------

START
      BTFSS PORTA,0
      GOTO START
      BTFSS PORTA,1
      GOTO P1ON
      BTFSS PORTA,2
      GOTO P2ON
      BTFSS PORTA,3
      GOTO P3ON
      GOTO P4ON
;------- OUVERTURE DES INTERUP
P1ON
     MOVLW B'00010001'
     MOVWF PORTB  ; P1 ON
     CALL  NTB
     
P2ON
     MOVLW B'00110011'
     MOVWF PORTB  ; P1,P2 ON
     CALL  NB
P3ON
     MOVLW B'01110111'
     MOVWF PORTB  ; P1,P2,P3 ON
     CALL  NH 
P4ON
     MOVLW B'11111111'
     MOVWF PORTB  ; P1,P2,P3,P4 ON
     CALL  NTH 


;----- TEST PR LA FERMETURE

NTB 
     BTFSS PORTA,0
     goto  P1OFF
     GOTO  NTB

NB 
     BTFSS PORTA,1
     GOTO  P2OFF
     GOTO  NB

NH
     BTFSS PORTA,2
     GOTO  P3OFF
     GOTO  NH

NTH
     BTFSS PORTA,3
     GOTO  P4OFF
     GOTO  NTH

;------ LA FERMETTURE DES INTERP
P1OFF 
     MOVLW B'00000000'
     MOVWF PORTB  ; P1 OFF
     GOTO  START
P2OFF 
     MOVLW B'00010001'
     MOVWF PORTB  ; P2 OFF
     GOTO  NTB
P3OFF 
     MOVLW B'00110011'
     MOVWF PORTB  ; P3 OFF
     GOTO  NB

P4OFF 
     MOVLW B'01110111'
     MOVWF PORTB  ; P4 OFF
     GOTO  NH

END
