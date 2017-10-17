 
SEL * FROM

(
SEL * FROM
EDW_SCVER_CODA.RPTNG_CODA_MEARS_SORTATION_br br
INNER JOIN
(SEL 
UPPER(SPED.Recipient_Surname) as Surname2, DA.PAF_UDPRN as PAF_UDPRN
, Count(SPE.item_ref) as SPS_Count
--,SPE.item_ref, SPE.location_Id,  LDX.Address_Id
FROM
EDW_SCVER_CODA.SERVICEPOINT_EVENT SPE
INNER JOIN
EDW_SCVER_CODA.SERVICEPOINT_EVENT_DETAIL SPED
ON SPE.Item_Ref = SPED.Item_Ref 
AND SPED.Recipient_SurName <> ''
INNER JOIN
EDW_SCVER_CODA.LOCATION_DIMADDRESS_XREF LDX
ON LDX.location_Id = SPE.location_Id
INNER JOIN
EDW_SCVER_CODA.DIM_ADDRESS DA
ON DA.Address_Id = LDX.Address_Id
AND DA.PAF_UDPRN <> 0
GROUP BY 1,2
Having SPS_Count > 1

and UPPER(SPED.RECIPIENT_SURNAME) NOT LIKE ALL (
--/*Removing Unknown SURNAMES*/
'%UNKNOWN%',
--/*Removing Surnames of common words found in business names that are NOT Surnames*/
'%SERVICE%', '%ACADEMY%' , '%INDUSTRIE%' , '%CONTRACT%','%LIMITED%','%MEDICAL%', '%COOLING%',
'%PROPERT%', '%ACCOUNTANCY%' , '%COMMUNICATION%' , '%SOLUTION%','%COTTAGE SHOP%','%OUTDOOR%',
'%COMPANY%', '%ELECTRONI%' , '%ENTERTAIN%' , '%CONSULT%','%FOUNDATION%','%CAR SALES%','%DIRECT%',
'%ACCESSO%', '%INTERIOR%' , '%THERAPIES%', '%LTD%','%DEPARTMENT%','% UK%','%RETURN%','%SIMPLY%',
'%INVESTMENT%', '%SOLICITOR%' , '%ADVENTURES%','%COMMERCIAL%','%ICITORS%','%MANAGER%','%OFFICE%',
--/*Removing Surnames with apostrophes in them*/
'%''%','%?%','%(%','%.%','%/%','%`%','%&%','%,%',

--/*Removing Surnames with numbers in them*/
'%0%' , '%1%' , '%2%' , '%3%' , '%4%',
'%5%' , '%6%' , '%7%' , '%8%' , '%9%',
--/*Removing Surnames with common email address parts*/
'%GMAIL%', '%GOOGLEMAIL%' , '%OUTLOOK%' , '%HOTMAIL%' , '%YAHOOCOM%',
'%NTLWORLD%' , '%TISCALICOUK%' , '%OPENWORLD%' , '%TELECOM%',
--/*Removing Surnames with more than 3 repeating consecutive characters*/
'%AAA%' , '%BBB%' , '%CCC%' , '%DDD%' , '%EEE%' ,
'%FFF%' , '%GGG%' , '%HHH%' , '%III%' , '%JJJ%' ,
'%KKK%' , '%LLL%' , '%MMM%' , '%NNN%' , '%OOO%' ,
'%PPP%' , '%QQQ%' , '%RRR%' , '%SSS%' , '%TTT%' ,
'%UUU%' , '%VVV%' , '%WWW%' , '%XXX%' , '%YYY%' ,
'%ZZZ%' ,
--/*Does not Starts with MRS....*/
'MRS%')
and UPPER(SPED.RECIPIENT_SURNAME) NOT LIKE ALL ('DOCTOR' , 'MR' ,  'MS' , 'MISTER' , 'MISS' , 'DR'  , 'AUNT' , 'UNCLE' )
--/*Removing Prefx and MRS records*/
AND LENGTH(SURNAME2) >1 
AND LENGTH(SURNAME2) <26
)x

ON x.PAF_UDPRN = br.UDPRN
AND x.SURNAME2 = br.SURNAME
)z


;