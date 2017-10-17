 Sel count (*) from
EDW_SCVER_CODA_ACCS_VIEWS.v_servicepoint_event_detail 
Where Item_status_type_id = 3 ;

sel top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_servicepoint_event_detail 
Where Item_status_type_id = 3 ;

SELECT 
    a.*, b.*   --- specify only what you need here!
FROM EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event AS a
LEFT JOIN  EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece AS b
ON a.mears_tag_id = b.tag_id
WHERE a.data_source_type_id = 8
AND a.event_actual_date = '2017-01-01'
And b.tag_creation_date = '2017-01-01'
QUALIFY ROW_NUMBER() OVER (PARTITION BY a.mears_tag_id ORDER BY a.scver_upd_dttm DESC) = 1;


sel top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece;

sel top 10 * from
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where data_source_type_id = 10;



