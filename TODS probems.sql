 sel data_source_type_id, event_actual_dt, count (*) from
 EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
 where event_actual_dt between date '2017-02-10' and date '2017-02-20'
 and data_source_type_id = 2
 group by 1,2
 ; 
 
 sel data_source_type_id, event_actual_date, count (*) from
 EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
 where event_actual_date between date '2017-02-10' and date '2017-02-20'
 and data_source_type_id = 2
 --and data_source_type_id IN (1,5,8)
 group by 1,2
 ; 
 
 
 sel data_source_type_id , event_actual_date, count (*)
 from EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
 where event_actual_date is null
 group by 1,2
 ;
 
 sel * from
 EDW_SCVER_CODA_DIM_VIEWS.v_dim_data_source;

 sel 'fpe' as tablename, data_source_type_id , event_actual_date, count (*), count (distinct event_id)
 from EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
 where event_actual_date between date '2017-02-01' and date '2017-02-10'
 group by 1,2,3 
 union sel 'fpe' as tablename, data_source_type_id , event_actual_date, count (*), count (distinct event_id)
 from EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
 where event_actual_date between date '2017-02-11' and date '2017-02-20'
 group by 1,2,3
 union
 sel 'evp' as tablename, data_source_type_id, event_actual_dt, count (*), count (distinct event_id)
 from EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
 where event_actual_dt between date '2017-02-01' and date '2017-02-10'
 group by 1,2,3
 union
 sel 'evp' as tablename, data_source_type_id, event_actual_dt, count (*) , count (distinct event_id)
 from EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
 where event_actual_dt between date '2017-02-11' and date '2017-02-20'
 group by 1,2,3
 ;
 
 sel * from
 EDW_SCVER_CODA_ACCS_VIEWS.v_data_source_type
; 


 show view
 EDW_SCVER_CODA_ACCS_VIEWS.v_party_address_party_desc
 --EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
 ;


select
Address_ID
,Party_Desc
,count (distinct Party_Type_Id)
,count(1)
from 
edw_Scver_coda_accs_views.v_party_address_party_desc
group by 1,2
having count(distinct party_type_id) > 1
;


sel count (distinct recipient_address_id) from 
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where event_actual_date between date '2017-02-01' and date '2017-02-10'
and data_source_type_id = 8
;

sel count (*) from
(
sel fpe.recipient_address_id, p.party_type_id,  p.party_desc, count (distinct fpe.recipient_party_id) as party_id
from EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event fpe
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_party p
ON p.party_id = fpe.recipient_party_id
where event_actual_date between date '2017-02-10' and date '2017-02-20'
--where fpe.event_actual_date = date '2017-02-07'
and fpe.data_source_type_id = 8
and p.party_type_id = 1
group by 1,2,3
having count (distinct fpe.recipient_party_id) >1
)x
;


sel fpe.event_id, fpe.recipent_party_id, fpe.recipient_address_id, count (*)
from EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event fpe
;

sel * from
EDW_SCVER_CODA_ACCS_VIEWS.v_party
;


 
 show view
 EDW_SCVER_CODA_ACCS_VIEWS.v_party_address_party_desc;
 

sel * from EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
sample 1000
where data_source_type_id = 5
and event_actual_dt between '2017-02-01' and date '2017-02-20'
;
 
 
 SEL 'fpe' as tablename, data_source_type_id , event_actual_date, count (*)
 from EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
 where event_actual_date is null
 group by 1,2,3
 union
 sel 'evp' as tablename, data_source_type_id, event_actual_dt, count (*) from
 EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
 where event_actual_dt is null
 group by 1,2,3
 ;
 
 
 sel * from 
 EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
 where event_actual_date between date '2017-02-11' and date '2017-02-20'
 and data_source_type_id =2
 sample 100
 ;
 
 
 Select * From EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where event_id = 2014982703572
and recipient_party_id = 765652484;


Sel * from EDW_SCVER_CODA_ACCS_VIEWS.v_etl_module_instance
where run_date = current_date - interval '1' day
where 
v_etl_module_details.ETL_Module_Run_Id in
(
2554715
,2649612
)
;


  sel * from 
 EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
 where event_actual_dt between date '2017-02-11' and date '2017-02-20'
 sample 100
 ;
 
 
 sel data_source_type_id, event_actual_dt, count (*) from
 EDW_SCVER_CODA_ACCS_VIEWS.V_event_party
 where event_actual_dt is null
 group by 1, 2
 ;
 
 
 sel * from
 EDW_SCVER_CODA_ACCS_VIEWS.v_CC_BATCH_QUEUE
 where SCV_HANDOVER_DTTM > date '2017-01-01'
 and SCV_data_source = 'TODS'
 order by SCV_HANDOVER_DTTM DESC;
 
 
 SELECT

COUNT(D.Event_Id)
,      D.Event_Actual_Date    
       FROM
       EDW_SCVER_CODA_ACCs_VIEWS.V_DELIVERY D
       group by 2
       WHERE D.Source_System  IN ( 'TODS')
       and D.Event_Actual_Date>'2016-11-30'
;




SELECT
--     COUNT(PPE.Piece_Id) AS Piece_Id
--     ,
COUNT(D.Event_Id)
,      D.Event_Actual_Date    
--     ,D.Event_Actual_Dttm      AS Del_Scan_Date_Time
--     ,ER.Exception_Reason_Desc  AS Exception_Reason
--     ,TRIM(ER.Exception_Reason_Cd) AS Exception_Reason_Cd
       FROM

       EDW_SCVER_CODA_ACCS_VIEWS.V_DELIVERY D

--INNER JOIN VOL_EVENT_ID PPE
--ON PPE.EVENT_ID =d.EVENT_ID

LEFT OUTER JOIN EDW_SCVER_CODA_ACCS_VIEWS.V_POSTAL_EXCEPTION PEX
       ON D.Event_Id = PEX.Event_Id

       LEFT OUTER JOIN EDW_SCVER_CODA_ACCS_VIEWS.V_EXCEPTION_REASON ER
       ON PEX.Exception_Reason_Id = ER.Exception_Reason_Id

       group by 2

              WHERE D.Source_System  IN ( 'TODS')
       and D.Event_Actual_Date>'2016-11-30';

       
       
       SEL
count(SHP.PIECE_ID)
, STL.Promised_Fulfillment_Dt

FROM
EDW_SCVER_CODA_ACCS_VIEWS.V_SHIPPER_PIECE AS SHP
JOIN EDW_SCVER_CODA_ACCS_VIEWS.V_POSTAL_PIECE_EVENT AS PPE
ON SHP.PIECE_ID = PPE.PIECE_ID
JOIN EDW_SCVER_CODA_ACCS_VIEWS.V_SALES_TRANSACTION_LINE STL
ON PPE.PIECE_ID = STL.PIECE_ID
group by 2
WHERE
SHP.SOURCE_SYSTEM IN ('TODS')
and STL.Promised_Fulfillment_Dt >= CURRENT_DATE - 50;



sel event_actual_date, count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.V_POSTAL_PIECE_EVENT
where event_actual_date > date '2017-01-01'
group by 1
;


sel promised_fulfillment_dt, count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.V_SALES_TRANSACTION_LINE
where promised_fulfillment_dt > date '2017-01-01'
group by 1
;


sel event_actual_date, count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.V_SHIPPER_PIECE
where event_actual_date > date '2017-01-01'
group by 1
;

sel count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.V_SALES_TRANSACTION_LINE;

sel count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.V_SALES_TRANSACTION_LINE
where promised_fulfillment_dt is null;






sel event_actual_date, data_source_type_id, count (*) as ALLCOUNT, count (distinct event_id) as EVENTCOUNT , 
count ( distinct MEARS_TAG_ID) as MAILCOUNT, count (distinct piece_id) as PIECECOUNT
from edw_scver_coda_dim_views.v_fct_piece_event

where event_actual_date between date'2017-01-01' and date '2017-01-10'
group by 1 , 2 

UNION

sel event_actual_date, data_source_type_id, count (*) as ALLCOUNT, count (distinct event_id) as EVENTCOUNT , 
count ( distinct MEARS_TAG_ID) as MAILCOUNT, count (distinct piece_id) as PIECECOUNT
from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date between date'2017-01-11' and date '2017-01-20'
group by 1 , 2 


UNION

sel event_actual_date, data_source_type_id, count (*) as ALLCOUNT, count (distinct event_id) as EVENTCOUNT , 
count ( distinct MEARS_TAG_ID) as MAILCOUNT, count (distinct piece_id) as PIECECOUNT
from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date between date'2017-01-21' and date '2017-01-31'
group by 1 , 2 


UNION

sel event_actual_date, data_source_type_id, count (*) as ALLCOUNT, count (distinct event_id) as EVENTCOUNT , 
count ( distinct MEARS_TAG_ID) as MAILCOUNT, count (distinct piece_id) as PIECECOUNT
from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date between date'2017-02-01' and date '2017-02-10'
group by 1 , 2 



UNION

sel event_actual_date, data_source_type_id, count (*) as ALLCOUNT, count (distinct event_id) as EVENTCOUNT , 
count ( distinct MEARS_TAG_ID) as MAILCOUNT, count (distinct piece_id) as PIECECOUNT
from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date between date'2017-02-11' and date '2017-02-20'
group by 1 , 2 

union
sel event_actual_date, data_source_type_id, count (*) as ALLCOUNT, count (distinct event_id) as EVENTCOUNT , 
count ( distinct MEARS_TAG_ID) as MAILCOUNT, count (distinct piece_id) as PIECECOUNT
from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date between date '2017-02-21' and date '2017-02-28'
group by 1 , 2 

union
sel event_actual_date, data_source_type_id, count (*) as ALLCOUNT, count (distinct event_id) as EVENTCOUNT , 
count ( distinct MEARS_TAG_ID) as MAILCOUNT, count (distinct piece_id) as PIECECOUNT
from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date between date '2017-03-01' and date '2017-03-10'
group by 1 , 2 


;
sel count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.V_CC_SIEBEL_IN
where dq_batch_id = 28399
;

sel count (*) from
edw_scver_coda_accs_views.v_cC_match_results
where dq_batch_id = 28399;
;




