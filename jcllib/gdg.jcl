//GDG      JOB (001),'DWALL01',CLASS=A,MSGCLASS=A,
//             MSGLEVEL=(1,1),NOTIFY=DWALL01
//*
//*            DELETE BASE AND GENERATIONS
//*            R04  - NOT FOUND
//*            R08+ - ERROR
//*
//JS010   EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=A
//AMSDUMP   DD *
//SYSIN     DD *
 LISTCAT ENTRIES(DWALL01.GDG.LOG) ALL
 IF LASTCC = 0 THEN DELETE DWALL01.GDG.LOG GDG FORCE PURGE
/*
//*
//*            DEFINE BASE
//*
//JS020   EXEC PGM=IDCAMS,COND=(8,LT)
//SYSPRINT  DD SYSOUT=A
//AMSDUMP   DD *
//SYSIN     DD *
 DEFINE GDG(NAME(DWALL01.GDG.LOG) LIMIT(3) NOEMPTY SCRATCH)
/*
//*
//*            DETECT CATALOGED MODEL
//*            R00  - FOUND
//*
//JS030   EXEC PGM=IDCAMS,COND=(8,LT)
//SYSPRINT  DD SYSOUT=A
//AMSDUMP   DD *
//SYSIN     DD *
 LISTCAT ENTRIES(DWALL01.GDG.LOGMODEL) ALL
/*
//*
//*            DELETE MODEL IF FOUND
//*
//JS040   EXEC PGM=IEFBR14,COND=(0,NE,JS030)
//SYSUT1    DD DSN=DWALL01.GDG.LOGMODEL,DISP=(OLD,DELETE)
//*
//*            CREATE MODEL
//*
//JS050   EXEC PGM=IEFBR14,COND=(8,LT)
//SYSUT1    DD DSN=DWALL01.GDG.LOGMODEL,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,SPACE=(TRK,5),
//             DCB=(LRECL=80,RECFM=FB,BLKSIZE=3120,DSORG=PS)
//*
//*            CREATE GENERATION (FOR TEST ONLY)
//*            NORMAL  - COND=(0,LE)
//*            TEST    - COND=(8,LT)
//*
//JS060   EXEC PGM=IEBGENER,COND=(0,LE)
//SYSPRINT  DD SYSOUT=A
//SYSIN     DD DUMMY
//SYSUT2    DD DSN=DWALL01.GDG.LOG(+1),
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,SPACE=(TRK,5),
//             DCB=DWALL01.GDG.LOGMODEL
//SYSUT1    DD *
 TEST DATA
/*
//
