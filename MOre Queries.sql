-- Step 1: This produces dates up to a few days ago, as expected.
SEL count(*) FROM
(select cast(event_actual_dttm as date), count(*) from EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
	where cast(event_actual_dttm as date) between '2016-11-01' and '2016-11-30'
	and source_system = 'TODS'
	group by 1) vd;
	
-- Step 2: This also works fine.

SEL count(*) FROM
(select cast(event_actual_dttm as date), count(*) from EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
	where cast(event_actual_dttm as date) between '2016-11-01' and '2016-11-30'
	and source_system = 'TODS') vd
	
	inner join (
		SELECT latitude, longitude, full_barcode, a.location_id, rm_event_code, event_id FROM EDW_SCVER_BO_VIEWS.v_bo_base_track_data_dtl a
		INNER JOIN (SELECT location_id FROM EDW_SCVER_BO_VIEWS.v_location WHERE Location_Name_Rln IN ('Cardiff North DO', 'Slough DO', 'Burton on Trent DO', 'Cambridge DO', 'Wallingford DO',
		'Oxford East DO', 'Swindon DO', 'Swindon West DO', 'Reading DO', 'Bracknell DO', 'Banbury DO', 'Abingdon DO', 'Streatham DO', 'Manchester Central DO', 'Islington DO', 'Maidenhead DO')) l ON a.LOCATION_ID = l.LOCATION_ID
		WHERE RM_Event_Code LIKE 'EVK%'
		AND RM_Event_Code <>  'EVKLC'
		AND RM_Event_Code <> 'EVKLS') vbo
	on vbo.event_id = vd.event_id
	
	group by 1;
	
-- Step 3: This only gives dates to the 12th.

select cast(event_actual_dttm as date), count(*) from

(SEL * from EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
	where cast(event_actual_dttm as date) between '2016-11-01' and '2016-11-30'
	and source_system = 'TODS') vd
	
	inner join (
		SELECT latitude, longitude, full_barcode, a.location_id, rm_event_code, event_id FROM EDW_SCVER_BO_VIEWS.v_bo_base_track_data_dtl a
		INNER JOIN (SELECT location_id FROM EDW_SCVER_BO_VIEWS.v_location WHERE Location_Name_Rln IN ('Cardiff North DO', 'Slough DO', 'Burton on Trent DO', 'Cambridge DO', 'Wallingford DO',
		'Oxford East DO', 'Swindon DO', 'Swindon West DO', 'Reading DO', 'Bracknell DO', 'Banbury DO', 'Abingdon DO', 'Streatham DO', 'Manchester Central DO', 'Islington DO', 'Maidenhead DO')) l ON a.LOCATION_ID = l.LOCATION_ID
		WHERE RM_Event_Code LIKE 'EVK%'
		AND RM_Event_Code <>  'EVKLC'
		AND RM_Event_Code <> 'EVKLS') vbo
	on vbo.event_id = vd.event_id
		
	inner join (select * from EDW_SCVER_CODA_ACCS_VIEWS.v_event_party
					where event_actual_dt between '2016-11-01' and '2016-11-30'
					and Event_Party_Role_Id = 1) vep
	on vep.event_id = vd.event_id
	
	group by 1;
	
	
	
	select event_actual_dt, count (*) 
	from EDW_SCVER_CODA_ACCS_VIEWS.v_event_party
	group by event_actual_dt
	order by event_actual_dt DESC;
	
	
	select event_actual_date, count (*)
	from EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
	group by event_actual_date
	order by event_actual_date DESC;
	
	
	SEL * from EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
	where event_actual_date > date'2016-11-11' 
	and event_actual_date <date'2016-11-15'
	and source_system = 'TODS';
	
	SEL * from EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
	where event_actual_date <= date'2016-11-11' 
	and source_system = 'TODS';
	
	
	SEL * from EDW_SCVER_CODA_ACCS_VIEWS.v_event_party
	where event_actual_dt > date'2016-11-11' 
	and event_actual_dt <date'2016-11-15'
	and data_source_type_id = 2;
	
	SEL event_actual_dt , count(*) from EDW_SCVER_CODA_ACCS_VIEWS.v_event_party
	where event_actual_dt > date'2016-11-01'
	and data_source_type_id = 2
	group by 1;
	
	
	
SEL * FROM 	EDW_SCVER_CODA_ACCS_VIEWS.v_individual
where party_id IN (
'2404778641',
'2365189817',
'2355920104',
'2408915856',
'2352647242',
'2365189881',
'2409080758');

SEL * FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_organization
where party_id IN (
'2404778641',
'2365189817',
'2355920104',
'2408915856',
'2352647242',
'2365189881',
'2409080758');

SEL * FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_party
where party_id IN (
'2404778641',
'2365189817',
'2355920104',
'2408915856',
'2352647242',
'2365189881',
'2409080758');

/* EDW_SCVER_CODA_ACCS_VIEWS.v_party_type */


SEL * FROM 	EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where recipient_party_id IN (
'2404778641',
'2365189817',
'2355920104',
'2408915856',
'2352647242',
'2365189881',
'2409080758');

SEL TOP 1000 * FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_party_source_dtl
where data_source_cd = 'TODS'
ORDER BY SCVER_LOAD_DTTM DESC
;




SEL top 10 * FROM 	EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
where data_source_type_id IN ('5')
and event_actual_date = date '2017-01-11'
;

	