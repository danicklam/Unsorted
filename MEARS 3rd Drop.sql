sel top 100 * from
edw_scver_coda_accs_views.v_event_party
;


sel  event_actual_dt, data_source_type_id, count (*) from
edw_scver_coda_accs_views.v_event_party
where event_actual_dt between date '2017-03-01' and date '2017-03-04'
group by 1,2;

sel top 100 
party_id, event_actual_dt, data_source_type_id, count (distinct piece_id), count (distinct event_id), count (tag_id) from
edw_scver_coda_accs_views.v_event_party
where event_actual_dt between date '2017-03-01' and date '2017-03-04'
group by 1,2, 3;




sel * from 
edw_scver_coda_accs_views.v_data_source_type
;
