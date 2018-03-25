#include <hidef.h>      /* common defines and macros */
#include "derivative.h"      /* derivative-specific definitions */
#include "SCI.H"


void delayby1ms(int x);



unsigned short val; // set as a global variable
  
void main(void) {

//setting Bus clock to 4MHz
/*PLLSEL=1;//choose PLL
OSCE=0;
VCOFRQ=00; //at this point fREF = 1MHz
SYNDIV=3 //VCLOCK=2*1MHz*(SYNDIV+1)= 8MHz
//At this point VCLOCK=8 MHz

LOCK = 1; //then use formula below for PLLCLK
POSTDIV = 0;//PLLCLK=VCLOCK/(POSTDIV+1)=8MHz/1=8MHz */

	
//Bus Clock = PLLCLK/2 = 4MHz

//CODE for Bus Clock

 CPMUCLKS = 0x80;  //PLLSEL = 1
 CPMUOSC  = 0x00;  //OSCE = 0
 CPMUSYNR = 0x1F;  //VCOFRQ = 0, SYNDIV = 31
 
 // Now fREF = 1 MHz and fVCO = 2* fREF * (31+1) = 64MHz
 CPMUFLG  = 0x00; //sets lock=0
 
 
 // PLLCLK = fVCO/4= 16MHz
 // Thus the Bus Clock = 8MHz = PLLCLK/2

 // Setup and enable ADC channel 3 
ATDCTL1 = 0x2F; // set for 10-bit resolution, 8-bit --> 0x00
ATDCTL3 = 0x88; // right justified, one sample per sequence
ATDCTL4 = 0x02; // prescaler = 2; ATD clock = 6.25MHz / (2 * (2 + 1)) == 1.04MHz
ATDCTL5 = 0x2B; // continuous conversion on channel 0 because equivalent for channel 11 0x2B, 0x20, 0x2C 
                // ATDCTL5 is used to configured the pin for the transducer circuit output
SCI_Init(9600); //sets baude rate


for(;;)
{

 val=ATDDR0; // read result from data result register 0 
 SCI_OutUDec(val);   //copies value sends it to SCI
 SCI_OutChar(CR); //new cell 
    
    
   
 delayby1ms(3.33);   //sample frequency: 300Hz. (1/300)*1000=3.333
	
} 
}                   



void delayby1ms(int k)
{
 int ix;
 /* enable timer and fast timer flag clear */
 TSCR1 = 0x90;
 /* disable timer interrupt, set prescaler to 1*/
 TSCR2 = 0x00;
 /* enable OC0 */ //(not necessary)
 TIOS |= 0x01;
 TC0 = TCNT + 8000;
 for(ix = 0; ix < k; ix++) {
 while(!(TFLG1_C0F));
 TC0 += 8000;
 }
 /* disable OC0 */ //(not necessary)
 TIOS &= ~0x01;
}



