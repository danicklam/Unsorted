----------------------------------------
/* QUERY TO CREATE MEARS VOLUME TABLE */
----------------------------------------

SEL 
count (distinct dim.Paf_udprn||ind.lastname) 
--dim.Paf_udprn, ind.LastName, Count (distinct MEARS_Tag_Id||MEARS_TAG_CREATION_DT) as MEARSCOUNT
FROM 
EDW_SCVER_CODA_BO_VIEWS.V_FCT_PIECE_EVENT fct
inner join EDW_SCVER_CODA_BO_VIEWS.v_dim_address dim
on fct.recipient_address_id = dim.address_id
and dim.Current_Record_Ind = 1
inner join EDW_SCVER_CODA_ACCS_VIEWS.V_INDIVIDUAL ind
on ind.party_id = fct.recipient_party_id
WHERE 
MEARS_Tag_Id is not null
and ind.lastName is not null
and ind.lastname NOT LIKE ALL (
/*Removing Unknown SURNAMES*/
'%UNKNOWN%',
/*Removing Surnames of common words found in business names that are NOT Surnames*/
'%SERVICE%', '%ACADEMY%' , '%INDUSTRIE%' , '%CONTRACT%',
'%PROPERT%', '%ACCOUNTANCY%' , '%COMMUNICATION%' , '%SOLUTION%',
'%COMPANY%', '%ELECTRONI%' , '%ENTERTAIN%' , '%CONSULT%',
'%ACCESSO%', '%INTERIOR%' , '%THERAPIES%',
'%INVESTMENT%', '%SOLICITOR%' , '%ADVENTURES%',
/*Removing Surnames with apostrophes in them*/
'%''%',
/*Removing Surnames with numbers in them*/
'%0%' , '%1%' , '%2%' , '%3%' , '%4%',
'%5%' , '%6%' , '%7%' , '%8%' , '%9%',
/*Removing Surnames with common email address parts*/
'%GMAIL%', '%GOOGLEMAIL%' , '%OUTLOOK%' , '%HOTMAIL%' , '%YAHOOCOM%',
'%NTLWORLD%' , '%TISCALICOUK%' , '%OPENWORLD%' , '%TELECOM%',
/*Removing Surnames with more than 3 repeating consecutive characters*/
'%AAA%' , '%BBB%' , '%CCC%' , '%DDD%' , '%EEE%' ,
'%FFF%' , '%GGG%' , '%HHH%' , '%III%' , '%JJJ%' ,
'%KKK%' , '%LLL%' , '%MMM%' , '%NNN%' , '%OOO%' ,
'%PPP%' , '%QQQ%' , '%RRR%' , '%SSS%' , '%TTT%' ,
'%UUU%' , '%VVV%' , '%WWW%' , '%XXX%' , '%YYY%' ,
'%ZZZ%' ,
/*Does not Starts with MRS....*/
'MRS%'
)
/*Removing Prefx and MRS records*/
AND ind.lastname <> ALL (
'DOCTOR' , 'MR' ,  'MS' , 'MISTER' , 'MISS' , 'DR'  , 'AUNT' , 'UNCLE' 
)
AND CHARACTER_LENGTH (ind.lastname) >1 AND CHARACTER_LENGTH (ind.lastname) < 26
;