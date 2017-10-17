SEL DISTINCT POSTCODE||Delivery_Point_Suffix_Val, 'ORG' as Organisation
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE ANY ('AB%','DG%','EC%')
AND ORGANISATION_NAME <> ''
AND Current_Record_Ind = 1
;


SEL 
'AB' as Area, count (distinct Postcode), count(distinct PAF_UDPRN)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'AB%'
AND Current_Record_Ind = 1
UNION SEL 
'DG' as Area, count (distinct Postcode), count(distinct PAF_UDPRN)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'DG%'
AND Current_Record_Ind = 1
UNION SEL
'EC' as Area, count (distinct Postcode), count(distinct PAF_UDPRN)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'EC%'
AND Current_Record_Ind = 1
;

SEL 
'AB' as Area, count (distinct Postcode), count(distinct Postcode||Delivery_Point_Suffix_Val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'AB%'
AND Current_Record_Ind = 1
UNION SEL 
'DG' as Area, count (distinct Postcode), count(distinct Postcode||Delivery_Point_Suffix_Val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'DG%'
AND Current_Record_Ind = 1
UNION SEL
'EC' as Area, count (distinct Postcode), count(distinct Postcode||Delivery_Point_Suffix_Val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'EC%'
AND Current_Record_Ind = 1
;


SEL 
'AB' as Area, count (distinct Postcode), count(distinct PAF_UDPRN), Count(ORGANISATION_NAME)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'AB%'
AND ORGANISATION_NAME <> ''
AND Current_Record_Ind = 1

UNION SEL
'DG' as Area, count (distinct Postcode), count(distinct PAF_UDPRN), Count(ORGANISATION_NAME)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'DG%'
AND ORGANISATION_NAME <> ''
AND Current_Record_Ind = 1

UNION SEL
'EC' as Area, count (distinct Postcode), count(distinct PAF_UDPRN), Count(ORGANISATION_NAME)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Postcode LIKE 'EC%'
AND ORGANISATION_NAME <> ''
AND Current_Record_Ind = 1
;

/* List of all postcodes in EC, AB, DG */
SEL TOP 999999 SUBSTR(POSTCODE,1,2) AS AREA, COUNT (DISTINCT POSTCODE||Delivery_point_suffix_val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE SUBSTR(POSTCODE,1,2) LIKE ANY ('BA','DH','WV')
AND Current_Record_Ind = 1
GROUP BY 1;



SEL TOP 999999
SUBSTR(POSTCODE,1,2) AS AREA, OREPLACE (POSTCODE, ' ','') as PC, Delivery_point_suffix_val
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE SUBSTR(POSTCODE,1,2) LIKE ANY ('EC','DG','AB')
AND Current_Record_Ind = 1
GROUP BY 1,2,3
;

SEL SUBSTR(POSTCODE,1,2) AS AREA, SUBSTR(POSTCODE,1,5) AS SECTOR,  Count (distinct Postcode) as PC, COUNT (distinct Postcode||Delivery_point_suffix_val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE SUBSTR(POSTCODE,1,2) LIKE ANY ('EC','DG','AB')
AND Current_Record_Ind = 1
GROUP BY 1,2
;

-------------------------------
/* Postcode Area for all 125 */
/* Run a search/replace      */
-------------------------------

SEL SUBSTR(POSTCODE,1,2) AS AREA, SUBSTR(POSTCODE,1,5) AS SECTOR,  Count (distinct Postcode) as PC, COUNT (distinct Postcode||Delivery_point_suffix_val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE --SUBSTR(POSTCODE,1,2) LIKE ANY ('DG')
Current_Record_Ind = 1
GROUP BY 1,2
;


SEL SUBSTR(POSTCODE,1,2) AS AREA, SUBSTR(POSTCODE,1,5) AS SECTOR,  Count (distinct Postcode) as PC, COUNT (distinct Postcode||Delivery_point_suffix_val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE SUBSTR(POSTCODE,1,2) LIKE ANY ('DH','BA','WV')
AND Current_Record_Ind = 1
GROUP BY 1,2
;





Sel Count (distinct Tag_Id||Tag_Creation_Date)
FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
GROUP by Area
WHERE Area like any ('EC', 'DG', 'AB')
;

select count(*)
--Select count(distinct Area||District||Sector||Unit||Dps) 
FROM
EDW_SCVER_BO_VIEWS.v_mears_shipper_piece
WHERE Dps is null
AND AREA is not null
;

select count(*)
--Select count(distinct Area||District||Sector||Unit||Dps) 
FROM
EDW_SCVER_BO_VIEWS.v_mears_shipper_piece
;
 

SEL 
SUBSTR(Postcode, 1, POSITION(REGEXP_SUBSTR(OREPLACE(Postcode, ' ', ''), '[0-9]', 1, 1) IN Postcode) -1) AS Area, 
count (distinct Postcode), count(distinct Postcode||Delivery_Point_Suffix_Val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Current_Record_Ind = 1
GROUP BY 1;

SEL 
SUBSTR(Postcode, 1, POSITION(REGEXP_SUBSTR(OREPLACE(Postcode, ' ', ''), '[0-9]', 1, 1) IN Postcode) -1) AS Area,
SUBSTR(POSTCODE,1,5) AS SECTOR,
count (distinct Postcode), count(distinct Postcode||Delivery_Point_Suffix_Val)
FROM EDW_SCVER_CODA_ACCS_VIEWS.V_DIM_ADDRESS
WHERE Current_Record_Ind = 1
GROUP BY 1,2;
