## A Procedure to Assemble, Link and Run a Program

For our first three sample programs, we basically copied and edited the same JCL with all the details for running our assembler, linker and our program. Beginning with sample program four (ASM004), we will instead put all of that JCL into a procedure that can be called with a parameter, the program name. The procedure can reference the parameter symbolically by preceding the parameter name with the ampersand character (&). Now our JCL to build and run our program need only call the same procedure passing a different program name.

The procedure is saved on our MVS system in SYS2.PROCLIB(ASMLKED). It is stored in this project in the proclib folder.

ASM - assembler the program  
LINK - link the program  
RUN - run the program

Note that procedures are not jobs. There is no job card. Also there is no end-of-job (//) card at the end.
```
//ASMLKED PROC M=MISSING                                      
//*                                                           
//*            ASSEMBLE THE PROGRAM                           
//*                                                           
//ASM     EXEC PGM=IFOX00,REGION=256K,                        
//             PARM='OBJ,RENT,XREF'                           
//SYSLIB    DD DISP=SHR,DSN=SYS1.MACLIB                       
//          DD DISP=SHR,DSN=DWALL01.DEV.MACLIB                
//SYSUT1    DD DSN=&&SYSUT1,UNIT=SYSSQ,                       
//             SPACE=(1700,(600,100)),SEP=(SYSLIB)            
//SYSUT2    DD DSN=&&SYSUT2,UNIT=SYSSQ,                       
//             SPACE=(1700,(300,50)),SEP=(SYSUT1)             
//SYSUT3    DD DSN=&&SYSUT3,UNIT=SYSSQ,                       
//             SPACE=(1700,(300,50))                          
//SYSPRINT  DD DISP=SHR,DSN=DWALL01.DEV.SYSPRINT(IFOX00)      
//SYSPUNCH  DD SYSOUT=B                                       
//SYSGO     DD DISP=SHR,DSN=DWALL01.DEV.OBJLIB(&M)            
//SYSIN     DD DISP=SHR,DSN=DWALL01.DEV.SORLIB(&M)            
//*                                                           
//*            LINK THE PROGRAM                               
//*                                                           
//LINK    EXEC PGM=IEWL,REGION=256K,COND=(0,LT),              
//             PARM='XREF,LET,LIST,NCAL,RENT'                 
//SYSUT1    DD DSN=&&SYSUT1,UNIT=(SYSDA,SEP=(SYSLIN,SYSLMOD)),
//             SPACE=(1024,(50,20))                           
//SYSPRINT  DD DISP=SHR,DSN=DWALL01.DEV.SYSPRINT(IEWL)        
//SYSLMOD   DD DISP=SHR,DSN=DWALL01.DEV.MODLIB(&M)            
//SYSLIN    DD DISP=SHR,DSN=DWALL01.DEV.OBJLIB(&M)            
//*                                                           
//*            RUN THE PROGRAM                                
//*                                                           
//RUN     EXEC PGM=&M,REGION=256K,COND=(0,LT)                 
//STEPLIB   DD DISP=SHR,DSN=DWALL01.DEV.MODLIB                
//SYSPRINT  DD SYSOUT=*                                       
//SYSABEND  DD SYSOUT=*                                       
//SYSUDUMP  DD SYSOUT=*                                       
//LOG       DD DSN=DWALL01.GDG.LOG(+1),                       
//             DISP=(NEW,CATLG,DELETE),                       
//             UNIT=SYSDA,SPACE=(TRK,(2,1)),                  
//             DCB=DWALL01.GDG.LOGMODEL                       
```

Return to [Sample Programs](Samples.md)  
Return to [README](../README.md)