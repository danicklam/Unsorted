 
sel * from
edw_scver_coda_accs_views.v_data_source_type;




sel * from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date = date '2017-01-05'
and data_source_type_id = 
--1
--2
5
--8
--10
sample 2000
;

sel data_source_type_id, count (*) from edw_scver_coda_dim_views.v_fct_piece_event
where event_actual_date = date '2017-01-05'
group by 1

;


sel *
from edw_scver_coda_accs_views.v_data_source_type


;