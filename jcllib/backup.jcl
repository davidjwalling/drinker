//BACKUP   JOB (001),'DWALL01',CLASS=A,MSGCLASS=A,                      00010000
//             MSGLEVEL=(1,1),NOTIFY=DWALL01                            00020000
//*                                                                     00030000
//*        --> RUN THIS JOB FROM DWALL01.DEV.JCLLIB <--                 00040000
//*                                                                     00050000
//JS001   EXEC PGM=IEFBR14                                              00060000
//*                                                                     00070000
//*            DELETE THE TARGET DATA SETS                              00080000
//*                                                                     00090000
//JS010   EXEC PGM=IEFBR14,COND=(0,LE)                                  00100000
//SYSPRINT  DD SYSOUT=*                                                 00110000
//SYSUT1    DD DSN=DWALL01.BACKUP.JCLLIB,DISP=(OLD,DELETE)              00120000
//SYSUT2    DD DSN=DWALL01.BACKUP.MACLIB,DISP=(OLD,DELETE)              00130000
//SYSUT3    DD DSN=DWALL01.BACKUP.SORLIB,DISP=(OLD,DELETE)              00140000
//*                                                                     00150000
//*            CREATE THE TARGET DATASETS                               00160000
//*                                                                     00170000
//JS020   EXEC PGM=IEFBR14,COND=(0,LT)                                  00180000
//SYSPRINT  DD SYSOUT=*                                                 00190000
//SYSUT1    DD DSN=DWALL01.BACKUP.JCLLIB,                               00200000
//             DISP=(NEW,CATLG,DELETE),                                 00210000
//             UNIT=3390,VOL=SER=DAA291,                                00220000
//             SPACE=(CYL,(40,5,20)),                                   00230000
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120)                     00240000
//SYSUT2    DD DSN=DWALL01.BACKUP.MACLIB,                               00250000
//             DISP=(NEW,CATLG,DELETE),                                 00260000
//             UNIT=3390,VOL=SER=DAA291,                                00270000
//             SPACE=(CYL,(40,5,20)),                                   00280000
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120)                     00290000
//SYSUT3    DD DSN=DWALL01.BACKUP.SORLIB,                               00300000
//             DISP=(NEW,CATLG,DELETE),                                 00310000
//             UNIT=3390,VOL=SER=DAA291,                                00320000
//             SPACE=(CYL,(40,5,20)),                                   00330000
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120)                     00340000
//*                                                                     00350000
//*            BACKUP THE MEMBERS                                       00360000
//*                                                                     00370000
//JS030   EXEC PGM=IEBCOPY,COND=(0,LT)                                  00380000
//SYSPRINT  DD DISP=SHR,DSN=DWALL01.DEV.SYSPRINT(BACKUP)                00390000
//SYSUT1    DD DISP=SHR,DSN=DWALL01.DEV.JCLLIB                          00400000
//SYSUT2    DD DISP=SHR,DSN=DWALL01.BACKUP.JCLLIB                       00410000
//SYSUT3    DD DISP=SHR,DSN=DWALL01.DEV.MACLIB                          00420000
//SYSUT4    DD DISP=SHR,DSN=DWALL01.BACKUP.MACLIB                       00430000
//SYSUT5    DD DISP=SHR,DSN=DWALL01.DEV.SORLIB                          00440000
//SYSUT6    DD DISP=SHR,DSN=DWALL01.BACKUP.SORLIB                       00450000
//SYSIN     DD *                                                        00460000
 COPY INDD=((SYSUT1,R)),OUTDD=SYSUT2                                    00470000
 COPY INDD=((SYSUT3,R)),OUTDD=SYSUT4                                    00480000
 COPY INDD=((SYSUT5,R)),OUTDD=SYSUT6                                    00490000
/*                                                                      00500000
//                                                                      00510000
