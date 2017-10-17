create table 
MgrS_LAM.RMGTTQ4
AS (
SEL top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_cc_batch_queue
)with data;
drop table MgrS_LAM.test2;

drop table MgrS_LAM.DELIVERIES_TODS;
drop table MgrS_LAM.PARTY_EVENT_TODS;


rename table MgrS_LAM.PARTY_ADDRESS_HIERACHY to MgrS_LAM.PARTY_ADDRESS_HIERARCHY ;
--------------------------------------------------------
/*  Creating tables for RMGTT & TODS */
---------DELIVERIES
------RMGTT
SEL 
	vd.event_id event_id,   -------NEED x
	vd.event_actual_dttm event_dttm,  ------- NEED x
	vpet.postal_event_type_desc postal_event_type_desc, ----NEED   x
	vbbtd.barcode barcode --- NEED X

FROM (
	select event_id, event_actual_dttm from EDW_SCVER_CODA_ACCS_VIEWS.v_delivery
	where (event_actual_date BETWEEN '2016-01-01' and '2016-12-13')
	and source_system = 'RMGTT'
	and event_actual_dttm IS NOT NULL) vd
	
	left join 
	(SELECT event_id, postal_event_type_id FROM EDW_SCVER_BO_VIEWS.v_postal_event 
	WHERE (event_actual_date BETWEEN  '2016-01-01' and '2016-12-13')
	AND POSTAL_EVENT_TYPE_ID IN(0,12)
	) vpe 
	on vd.event_id = vpe.event_id
	
	left join (SEL postal_event_type_id, postal_event_type_desc  from EDW_SCVER_BO_VIEWS.v_postal_event_type) vpet 
	on vpe.postal_event_type_id = vpet.postal_event_type_id
	
	left join (SELECT event_id, piece_id FROM EDW_SCVER_BO_VIEWS.v_postal_piece_event 
	WHERE (event_actual_date BETWEEN  '2016-09-01' and '2016-12-13' )) vppe 
	ON vd.event_id = vppe.event_id
	
	LEFT JOIN (SELECT piece_id, barcode FROM EDW_SCVER_BO_VIEWS.v_bo_base_track_data 
	WHERE (scan_date BETWEEN  '2016-09-01' and '2016-12-13' ) AND TRACK_NUMBER = 'TRACK7') vbbtd 
	ON vppe.piece_id = vbbtd.piece_id 
	;
-----------------------------

create table 
MgrS_LAM.POSTAL_P_E
AS (		
	
SEL vpe.event_id, vppe.piece_id, vpet.postal_event_type_desc
FROM
	(SELECT event_id, postal_event_type_id FROM EDW_SCVER_BO_VIEWS.v_postal_event 
	WHERE (event_actual_date BETWEEN  '2016-01-01' and '2016-12-13')
	AND POSTAL_EVENT_TYPE_ID IN(0,12)
	) vpe 
	
	inner join (SELECT event_id, piece_id FROM EDW_SCVER_BO_VIEWS.v_postal_piece_event 
	WHERE (event_actual_date BETWEEN  '2016-09-01' and '2016-12-13' )) vppe 
	ON vpe.event_id = vppe.event_id
	
	inner join 
	(SEL postal_event_type_id, postal_event_type_desc  from EDW_SCVER_BO_VIEWS.v_postal_event_type) vpet 
	on vpe.postal_event_type_id = vpet.postal_event_type_id
)with data;
------------------
		
	
SEL 

vd.event_id event_id,   -------NEED x
vd.event_actual_dttm event_dttm,  ------- NEED x
vpet.postal_event_type_desc postal_event_type_desc, ----NEED   x
vbbtd.barcode barcode, --- NEED X
pah.address_id address_id, ---NEED X
pah.postcode postcode, ---NEED X
pah.delivery_point_suffix_val delivery_point, ---NEED X
pah.delivery_office do_name, ---NEED X
'RMGTT' as Source

FROM

EDW_SCVER_CODA_ACCS_VIEWS.v_delivery vd
LEFT JOIN
EDW_SCVER_BO_VIEWS.v_postal_event vpe
ON vd.event_id = vpe.event_id
LEFT join EDW_SCVER_BO_VIEWS.v_postal_piece_event vppe
ON vpe.event_id = vppe.event_id
LEFT join EDW_SCVER_BO_VIEWS.v_postal_event_type vpet
ON vpe.postal_event_type_id = vpet.postal_event_type_id
LEFT JOIN EDW_SCVER_BO_VIEWS.v_bo_base_track_data vbbtd
ON vppe.piece_id = vbbtd.piece_id 
INNER JOIN
MgrS_LAM.PARTY_EVENT_RMGTT per
ON per.event_id = vd_event_id
INNER JOIN
MgrS_LAM.PARTY_ADDRESS_HIERARCHY pah
ON pah.party_id = per.party_id

AND (vd.event_actual_date   BETWEEN  '2016-09-01' and '2016-12-13')
AND (vpe.event_actual_date  BETWEEN  '2016-09-01' and '2016-12-13')
AND (vppe.event_actual_date BETWEEN  '2016-09-01' and '2016-12-13')
AND (scan_date              BETWEEN  '2016-09-01' and '2016-12-13')
AND vd.source_system = 'RMGTT'
AND vbbtd.TRACK_NUMBER = 'TRACK7'
AND vpe.POSTAL_EVENT_TYPE_ID IN(0,12)
;


-------------------------------------------
/*   
WE NEED TO CREATE TEMPORARY TABLES 
IN TERADATA LABS FIRST
*/
-------------------------------------------
/* Address Information and DO   */

create table 
MgrS_LAM.PARTY_ADDRESS_HIERACHY
AS (	
	
SEL 
vpa.address_id address_id, 
vpa.party_id,
vda.postcode postcode,
vda.delivery_point_suffix_val delivery_point, 
vdaoh.delivery_office do_name
FROM 
	(select address_id, party_id from EDW_SCVER_CODA_ACCS_VIEWS.v_party_address where address_type_id = 1) vpa --Postal Address

	inner join 
	(select postcode, address_id, delivery_point_suffix_val from EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address 
	where address_type = 'MA' and Postcode is not null) vda --MAIN ADDRESS
	on vda.address_id = vpa.address_id
	
	inner join 
	(select address_id, delivery_office  from EDW_SCVER_CODA_DIM_VIEWS.v_dim_address_ops_hierarchy 
	where delivery_office IN (
			'Abingdon DO',
			'Alloa DO',
			'Andover DO',
			'Ashtead DO',
			'Ballymena DO',
			'Banbury DO',
			'Barnsley DO',
			'Bearsden DO',
			'Belfast BT15 DO',
			'Berkhamsted DO',
			'Bilston DO',
			'Blackpool DO',
			'Bracknell DO',
			'Bridgwater DO',
			'Bristol South DO',
			'Bude DO',
			'Burton On Trent DO',
			'Bury St Edmunds DO',
			'Cambridge DO',
			'Cardiff North DO',
			'Chelmsford DO',
			'Chester DO',
			'Clacton On Sea DO',
			'Colchester DO',
			'Coventry North DO',
			'Crewkerne DO',
			'Dalkeith DO',
			'Deptford DO',
			'Dover DO',
			'Dundee Central DO',
			'East Grinstead DO',
			'Edinburgh East DO',
			'Enniskillen DO',
			'Fareham DO',
			'Fordingbridge DO',
			'Gainsborough DO',
			'Glasgow G13 and G14 DO',
			'Glenrothes DO',
			'Great Missenden DO',
			'Halstead DO',
			'Harrow North and South DO',
			'Hayes DO',
			'Helston DO',
			'High Wycombe North DO',
			'Holyhead DO',
			'Hucknall DO',
			'Ilkeston DO',
			'Islington DO',
			'Iver DO',
			'Keswick DO',
			'Kingsbridge DO',
			'Kittybrewster DO',
			'Largs DO',
			'Leicester South DO',
			'Leyburn DO',
			'Liverpool 8 DO',
			'Llantwit Major DO',
			'Loughborough DO',
			'Maidenhead DO',
			'Manchester Central DO',
			'Marlow DO',
			'Mildenhall DO',
			'Montrose DO',
			'Mount Pleasant EC1 DO',
			'Nailsea DO',
			'Newark DO',
			'Newton Aycliffe DO',
			'Northampton NN3A DO',
			'Nottingham North DO',
			'Orpington DO',
			'Oxford East DO',
			'Patchway DO',
			'Petersfield DO',
			'Pontefract DO',
			'Portsmouth DO',
			'Pulborough DO',
			'Reading DO',
			'Ringwood DO',
			'Royston DO',
			'Sandhurst DO',
			'Seaton DO',
			'Sheffield West DO',
			'Skelmersdale DO',
			'Slough DO',
			'Southend On Sea DO',
			'St Albans DO',
			'Steyning DO',
			'Streatham DO',
			'Sutton DO',
			'Swindon DO',
			'Swindon West DO',
			'Tewkesbury DO',
			'Tong Road DO',
			'Turriff DO',
			'Wallingford DO',
			'Wembley Lows DO',
			'Westhill DO',
			'Wimbledon DO',
			'Worcester DO',
			'Ystalyfera DO'
	)) vdaoh
	ON vdaoh.address_id = vpa.address_id
	
	)with data;
	;
	
----------------------------------------------
/* CREATE EVENT_PARTY TABLES BY SOURCE */	
	

create table 
MgrS_LAM.PARTY_EVENT_RMGTT
AS (
SEL event_id, party_id
FROM EDW_SCVER_coda_accs_VIEWS.v_event_party
where data_source_type_id = 1
and (event_actual_dt between '2016-01-01' and '2016-12-14')
)with data;

create table 
MgrS_LAM.PARTY_EVENT_TODS
AS (
SEL event_id, party_id
FROM EDW_SCVER_coda_accs_VIEWS.v_event_party
where data_source_type_id = 2
and (event_actual_dt between '2016-01-01' and '2016-12-14')
)with data;
	

/*  COLLECT STATS  */

COLLECT STATISTICS COLUMN(address_id, party_id) ON 
MgrS_LAM.PARTY_ADDRESS_HIERARCHY;

COLLECT STATISTICS COLUMN(event_id, party_id) ON 
MgrS_LAM.PARTY_EVENT_RMGTT;

COLLECT STATISTICS COLUMN(event_id, party_id) ON 
MgrS_LAM.PARTY_EVENT_TODS;



