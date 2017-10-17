sel top 100 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_SHIPPER_PIECE

where event_actual_date = date '2017-01-10'
and source_system = 'SPS';



sel event_actual_date, count (*) from
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where data_source_type_id = 10
and event_actual_date between date '2017-01-01' and date '2017-01-10'
group by 1;




sel se.event_actual_date, 'count1' as col, count(*) FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT_DETAIL sed
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT se
on sed.servicepoint_event_id = se.servicepoint_event_id
and sed.Item_status_type_id = 3 
and se.event_actual_date  between date '2017-01-01' and date '2017-01-10'
and sed.event_actual_date between date '2017-01-01' and date '2017-01-10'
group by 1;



sel 'count1' as col, count(*) FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT_DETAIL sed
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT se
on sed.servicepoint_event_id = se.servicepoint_event_id
and sed.Item_status_type_id = 3 
and se.event_actual_date  between date '2017-01-01' and date '2017-01-10'
and sed.event_actual_date between date '2017-01-01' and date '2017-01-10'

union 
sel 'count2' as col, count(distinct se.servicepoint_event_id) FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT_DETAIL sed
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT se
on sed.servicepoint_event_id = se.servicepoint_event_id
and sed.Item_status_type_id = 3 
and se.event_actual_date  between date '2017-01-01' and date '2017-01-10'
and sed.event_actual_date between date '2017-01-01' and date '2017-01-10'
;


sel top 100 * 
FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT_DETAIL sed
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_SERVICEPOINT_EVENT se
on sed.servicepoint_event_id = se.servicepoint_event_id
and sed.Item_status_type_id = 3 
and se.event_actual_date between date '2017-02-01' and date '2017-02-10'
and sed.event_actual_date between date '2017-02-01' and date '2017-02-10';



sel event_actual_date, count (*) from
EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where data_source_type_id = 2
and event_actual_date between date '2017-01-20' and date '2017-01-31'
group by 1;