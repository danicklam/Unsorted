sel max(mears_event_timestamp) from
EDW_SCVER_CODA_ACCS_VIEWS.v_prep_mears_adf_scv
where tag_creation_date > date'2016-11-30'
;

sel tag_creation_date, count (*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_prep_mears_adf_scv
where tag_creation_date > date'2016-10-25'
group by 1
;



sel tag_creation_date, count (*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_adf_stg
where tag_creation_date > date'2016-10-25'
group by 1
;

sel tag_creation_date, count (*)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_creation_date > date'2016-10-25'
group by 1
;



/*CLUSTERS WITH NO LETTERS*/

sel count (distinct addressid||clusterid) from (
SEL fpe.recipient_party_id as partyid, i.indiv_cluster_id as clusterid, fpe.recipient_address_id as addressid
from
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event fpe
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_address_cluster i
ON i.party_id = fpe.recipient_party_id
and i.indiv_cluster_id is not null
and i.address_id = fpe.recipient_address_id
and fpe.mears_tag_id is not null
and fpe.data_source_type_id = 8
--and fpe.event_actual_date >= date'2016-09-01'
--and fpe.event_actual_date >= date'2016-11-30'
)x;


/* Daily new clusters */

SEL paclusterdate, COUNT (*) from (
sel pa.address_id, i.indiv_cluster_id, cast(min(i.SCVER_Load_dttm) as date) as paclusterdate
FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pa
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_individual i
ON i.party_id = pa.party_id
and i.indiv_cluster_id is not null
group by 1,2
)x
WHERE paclusterdate > date '2016-11-20'
group by paclusterdate
;

/**/




SELECT DISTINCT
    PC.Party_Id,
    --PC.Event_Actual_Date,
    --CASE WHEN PC.Source_System = 'TODS' THEN 'T' WHEN PC.Source_System = 'RMGTT' THEN 'R' END AS Source_System,
    --VPA.Address_Id,
    --VI.Name_Prefix,
    --VI.Forename,
    --VI.Lastname,
    VI.Indiv_Cluster_Id,
    VEA.Electronic_Address as Email,
    VTA.Msisdn_Number as Telephone,
    --VDA.PAF_UDPRN
    TRIM(OREPLACE(VDA.Postcode, ' ', '')) || TRIM(VDA.Delivery_Point_Suffix_Val) AS PCDPS
FROM (
        SELECT DISTINCT
        VEP.party_id
        --VD.Source_System
        --VD.Event_Actual_Date
        --VD.Signed_Ind
        --count(*) as party_count    
        --vpa1.Address_Type_Id
        FROM (SELECT * FROM EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
                 WHERE CAST(event_actual_dttm AS date) between '2016-07-01' AND '2016-12-01') VD
            INNER JOIN (SELECT * FROM EDW_SCVER_CODA_ACCS_VIEWS.v_event_party
                  WHERE event_actual_dt between '2016-07-01' AND '2016-12-01'
                  AND Event_Party_Role_Id = 1) VEP  --Event_Party_Role_Id = 1 is 'recipient'.
                        --Note: this isn't 1 to 1. events can have multiple parties, hence the group by.
                ON VEP.event_id = VD.event_id
            INNER JOIN ( SELECT * FROM EDW_SCVER_CODA_ACCS_VIEWS.v_party
                    WHERE Party_Type_Id=1) VP -- 1 is 'Individual'
                ON VEP.Party_Id = VP.Party_Id
        ) PC
LEFT JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_party_address VPA
    ON PC.Party_Id = VPA.Party_Id
LEFT JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_individual VI
    ON PC.Party_Id = VI.Party_Id
LEFT JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_electronic_address VEA
    ON VPA.Address_Id = VEA.Electronic_Address_Id
LEFT JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_telephonic_address VTA
    ON VPA.Address_Id = VTA.Telephonic_Address_Id
LEFT JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address VDA
    ON VPA.Address_Id = VDA.Address_Id;
--WHERE VDA.Loc_Posttown = 'Birmingham'
--ORDER BY PC.Party_Id

    
    
    SELECT TOP 9000000
l.LOCATION_NAME_RLN do_name,
r.route_num route_number,
r.Route_name route_name,
s.Route_Sequence_Num rsn,
a.Latitude_Meas latitude,
a.Longitude_Meas longitude,
a.Postcode postcode,
a.delivery_point_suffx_val delivery_point
FROM EDW_SCVER_BO_VIEWS.v_route r
INNER JOIN EDW_SCVER_BO_VIEWS.v_route_delivery_schedule s
    ON r.route_id = s.Delivery_Route_Id
INNER JOIN EDW_SCVER_BO_VIEWS.v_delivery_point_address a
    ON s.Point_Address_Id = a.Point_Address_Id
INNER JOIN "EDW_SCVER_BO_VIEWS"."v_location" l
    ON r.ROUTE_OWNER_LOCATION_ID = l.LOCATION_ID
WHERE r.RECORD_STATUS LIKE '%A%'
   AND s.Route_Dp_Del_Ind=0
    and l.location_name_rln in (
 :parameter1

   ) ;
   
   
   
SEL TOP 100
Telephonic_Address_id,
CASE WHEN MSISDN_NUMBER IS NOT NULL THEN 'X' END AS TelephoneIndicator 
FROM 
EDW_SCVER_CODA_ACCS_VIEWS.v_telephonic_address;






SEL top 1000 * FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results
where DQ_batch_id =21759
;


SEL top 1000 * FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_match_results
where DQ_batch_id =21759
;

SEL COUNT (*) FROM
--SEL TOP 100 * FROM 
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where event_Actual_date =date '2016-10-11'
and MEARS_TAG_ID IS NOT NULL
; 


SEL Event_actual_date, COUNT (*) FROM
--SEL TOP 100 * FROM 
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where event_Actual_date >= date '2016-10-01'
and event_actual_date <= date '2016-10-31'
and MEARS_TAG_ID IS NOT NULL
Group by 1
;


SEL data_source_type_id, Event_actual_date, COUNT (*) FROM
--SEL TOP 100 * FROM 
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where event_Actual_date >= date '2016-10-10'
and event_actual_date <= date '2016-10-15'
Group by 1, 2
;


SEL * FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_CC_BATCH_QUEUE
where scv_handover_dttm >= date '2016-10-01'
and scv_handover_dttm <= date '2016-10-31'
and scv_data_source = 'MEARS_ADF';


SEL event_actual_date, ETL_MODULE_RUN_ID, count (*) FROM EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
WHERE
EVENT_ACTUAL_DATE >= date'2016-10-10'
and EVENT_aCTUAL_daTE <= date'2016-10-12'
and data_source_type_id = 8
GROUP BY 1, 2
;

2248388
2248112
2247989
2247916
2247798
2247688
2247629
2247432
2247369
2247088
2246943



