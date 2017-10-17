sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
;

sel top 100 * from
c
;

sel top 100 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_event_party
;

sel top 100 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_item
;


sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_sales_transaction_line
;

sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_sales_transaction_line_dtls
;

sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_shipper_piece
;

sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_postal_piece_event
;

sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_postal_event_type
;

sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_postal_exception

;

sel top 100* from
EDW_SCVER_CODA_ACCS_VIEWS.v_party_source_dtl
;

sel top 100 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_scv_non_postal_address_xref
;

sel top 100 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_data_source_type
;

drop table MgrS_LAM.SE_EVENT_PARTY
;
drop table MgrS_LAM.SE_INDIVIDUAL
;
drop table MgrS_LAM.SE_PARTY_ADDRESS
;

sel count (*) from MgrS_LAM.SN_SELECTION;

/*  PREPARATION TABLE */
create table  MgrS_LAM.SN_SELECTION AS ( 

sel pa.party_id, da.address_id from
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address da
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address pa
on da.address_id = pa.address_id
and pa.address_type_id = 1
and da.loc_posttown = 'SWINDON'
group by 1,2
)with data;
;
/*INDIVIDUALS*/
sel i.* from 
EDW_SCVER_CODA_ACCS_VIEWS.v_individual i
inner join
MgrS_LAM.SN_SELECTION SN
on i.party_id  = SN.party_id
;
/*ADDRESSES*/
sel * from 
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address
where loc_posttown = 'SWINDON'
;

/*      FCT_PIECE DATA       */
-- FCT_PIECE_EVENT (MEARS ONLY)

SELECT fpe.Piece_Id, EVENT_ID, fpe.Recipient_Party_Id, Sender_Party_Id,
Recipient_Address_Id, Sender_Address_Id, Postal_Event_Type_Id,
Product_Id, fpe.Event_Actual_Date, Data_Source_Type_ID, MEARS_Tag_Id,
MEARS_Tag_Creation_DT, POISE_Consignment_Id, Mail_Piece_Postage_Value,
Mail_Piece_Length, Mail_Piece_Thickness, Mail_Piece_Height, Mail_Piece_Weight,
Mail_Type_Id, Mail_Format, Mail_Class_Type_Id, EIB_Supply_Chain_Id,
Licence_Number, msp.eib_bc_type,
fpe.Postal_Piece_Type_Id, fpe.Mears_Event_Timestamp, fpe.SCVER_Load_Dttm, fpe.SCVER_Upd_Dttm
FROM edw_Scver_coda_dim_views.v_fct_piece_event fpe
LEFT OUTER JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece msp
ON fpe.mears_Tag_ID || fpe.MEARS_Tag_Creation_DT = msp.Tag_Id || msp.Tag_Creation_Date
INNER JOIN edw_Scver_coda_dim_views.v_dim_address da
ON da.address_id = fpe.recipient_address_id
WHERE da.Loc_posttown = 'SWINDON'
AND fpe.Event_Actual_Date BETWEEN date    '2017-01-21' AND date '2017-01-31' 
AND fpe.MEARS_Tag_Creation_DT BETWEEN date '2017-01-21' AND date '2017-01-31' 
AND msp.Tag_Creation_Date BETWEEN date    '2017-01-21' AND date '2017-01-31' 
;

---- RUN 7X TIMES  ----------------------
-- '2017-01-01' AND date '2017-01-10'  --
-- '2017-01-11' AND date '2017-01-20''  --
-- '2017-01-21' AND date '2017-01-31'  --
-- '2017-02-01' AND date '2017-02-10'  --
-- '2017-02-11' AND date '2017-02-20'  --
-- '2017-02-21' AND date '2017-02-31'  -- 
-- '2017-03-01' AND date '2017-03-05'  --                                


sel * from
edw_scver_coda_accs_views.v_cc_batch_queue
order by dq_batch_id desc
;



sel * from 
EDW_SCVER_CODA_ACCS_VIEWS.v_file_load_control
order by job_procsd_date desc
;


sel ppe.event_id, ppe.piece_id, ppe.event_actual_date, ep.party_id * FROM 
EDW_SCVER_CODA_ACCS_VIEWS.v_postal_piece_event ppe
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_event_party ep
ON ep.event_id = ppe.event_id
and ep.data_source_type_id = 5
;

sel top 100 * from 
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where data_source_type_id = 2
and event_actual_date = date '2017-02-28'
;

sel data_source_type_id, event_actual_date , count (*) from
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where event_actual_date > date '2017-02-01'
group by 1,2
;