//ASM003   JOB (001),'DWALL01',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=DWALL01
//*
//*            ASSEMBLE THE PROGRAM
//*
//JS010   EXEC PGM=IFOX00,REGION=256K,
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
//SYSGO     DD DISP=SHR,DSN=DWALL01.DEV.OBJLIB(ASM003)
//SYSIN     DD DISP=SHR,DSN=DWALL01.DEV.SORLIB(ASM003)
//*
//*            LINK THE PROGRAM
//*
//JS020   EXEC PGM=IEWL,REGION=256K,COND=(0,LT),
//             PARM='XREF,LET,LIST,NCAL,RENT'
//SYSUT1    DD DSN=&&SYSUT1,UNIT=(SYSDA,SEP=(SYSLIN,SYSLMOD)),
//             SPACE=(1024,(50,20))
//SYSPRINT  DD DISP=SHR,DSN=DWALL01.DEV.SYSPRINT(IEWL)
//SYSLMOD   DD DISP=SHR,DSN=DWALL01.DEV.MODLIB(ASM003)
//SYSLIN    DD DISP=SHR,DSN=DWALL01.DEV.OBJLIB(ASM003)
//SYSIN     DD *
NAME ASM003(R)
/*
//*
//*            RUN THE PROGRAM
//*
//JS030   EXEC PGM=ASM003,REGION=256K,COND=(0,LT)
//STEPLIB   DD DISP=SHR,DSN=DWALL01.DEV.MODLIB
//SYSPRINT  DD SYSOUT=*
//SYSABEND  DD SYSOUT=*
//SYSUDUMP  DD SYSOUT=*
//
