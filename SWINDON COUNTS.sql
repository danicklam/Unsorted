
SEL trim(substr (postcode, 1, 5)) as POSTCODE_AREA , count (*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address
where LOC_POSTTOWN ='SWINDON'
GROUP by 1
;

SEL trim(MEARS_PC_Area||MEARS_PC_District||MEARS_PC_Sector) as PCS , count (distinct Tag_id||TAG_CREATION_DATE), COUNT(*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_creation_date between date '2016-12-01' and date '2016-12-07' 
AND MEARS_PC_AREA = 'SN'
GROUP BY 1;

SEL trim(substr(EIB_BC_ADDR_RESULT,1,5)) as PCS , count (distinct Tag_id||TAG_CREATION_DATE), COUNT(*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_creation_date between date '2016-12-01' and date '2016-12-07' 
AND substr(EIB_BC_ADDR_RESULT,1,2) = 'SN'
GROUP BY 1;





SELECT trim(substr (postcode, 1, 5)) as POSTCODE_AREA , count (distinct fpe.mears_Tag_ID || fpe.MEARS_Tag_Creation_DT)
FROM edw_Scver_coda_dim_views.v_fct_piece_event fpe
--LEFT OUTER JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece msp
--ON fpe.mears_Tag_ID || fpe.MEARS_Tag_Creation_DT = msp.Tag_Id || msp.Tag_Creation_Date
INNER JOIN edw_Scver_coda_dim_views.v_dim_address da
ON da.address_id = fpe.recipient_address_id
WHERE da.Loc_posttown = 'SWINDON'  
AND fpe.Event_Actual_Date BETWEEN            
date '2016-12-01' AND date '2016-12-07'
GROUP BY 1;

SEL 'HAS NOT' as PC,count (Tag_id||TAG_CREATION_DATE), COUNT(*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_creation_date = date '2016-12-01'
AND MEARS_PC_AREA IS NULL

UNION
SEL 'HAS' as PC, count (Tag_id||TAG_CREATION_DATE), COUNT(*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_creation_date = date '2016-12-01'
AND MEARS_PC_AREA IS NOT NULL
;

SELECT 'FPE' as Source, count (distinct mears_Tag_ID || MEARS_Tag_Creation_DT), count(*)
FROM edw_Scver_coda_dim_views.v_fct_piece_event
WHERE MEARS_Tag_Creation_DT = date '2016-12-01' 
UNION
SELECT 'MSP' as Source, count (distinct Tag_id||TAG_CREATION_DATE) , count(*)
FROM EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
WHERE Tag_Creation_DaTe = date '2016-12-01' ;

