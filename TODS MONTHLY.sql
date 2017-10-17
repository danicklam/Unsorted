/*
between :parameter1 and :parameter2
between '2016-01-01' and '2016-01-31' 
between '2016-02-01' and '2016-02-28' 
between '2016-03-01' and '2016-03-31' 
between '2016-04-01' and '2016-04-30' 
between '2016-05-01' and '2016-05-31' 
between '2016-06-01' and '2016-06-30' 
between '2016-07-01' and '2016-07-31' 
between '2016-08-01' and '2016-08-31' 
between '2016-09-01' and '2016-09-30' 
between '2016-10-01' and '2016-10-31' 
between '2016-11-01' and '2016-11-30' 
between '2016-12-01' and '2016-12-14' 
*/

select top 9999999
vd.event_id event_id, --- NEED X
vd.event_actual_dttm event_dttm,  ---NEED X
vbo.rm_event_code event_cd, ---NEED X
vbbdt.full_barcode barcode, ---NEED X
vda.address_id address_id, ---NEED X
vda.postcode postcode,---NEED X
vda.delivery_point_suffix_val delivery_point, ---NEED X
vdaoh.delivery_office do_name, ---NEED X
'TODS' as Source

from 
EDW_SCVER_CODA_ACCS_VIEWS.v_delivery vd
where (event_actual_date between :parameter1 and :parameter2 )
and source_system = 'TODS'

inner join 
EDW_SCVER_BO_VIEWS.v_bo_base_track_data_dtl vbbtdd
on vd.event_id = vbbtdd.event_id
AND (event_actual_date between :parameter1 and :parameter2 )
AND RM_Event_Code LIKE 'EVK%'
AND RM_Event_Code <>  'EVKLC'
AND RM_Event_Code <> 'EVKLS'

INNER JOIN 
EDW_SCVER_BO_VIEWS.v_location l
ON vbbtdd.LOCATION_ID = l.LOCATION_ID
AND Location_Name_Rln  IN (
			'Abingdon DO','Alloa DO','Andover DO','Ashtead DO','Ballymena DO','Banbury DO','Barnsley DO',
			'Bearsden DO','Belfast BT15 DO','Berkhamsted DO','Bilston DO','Blackpool DO','Bracknell DO',
			'Bridgwater DO','Bristol South DO','Bude DO','Burton On Trent DO','Bury St Edmunds DO','Cambridge DO',
			'Cardiff North DO','Chelmsford DO','Chester DO','Clacton On Sea DO','Colchester DO','Coventry North DO',
			'Crewkerne DO','Dalkeith DO','Deptford DO','Dover DO','Dundee Central DO','East Grinstead DO',
			'Edinburgh East DO','Enniskillen DO','Fareham DO','Fordingbridge DO','Gainsborough DO','Glasgow G13 and G14 DO',
			'Glenrothes DO','Great Missenden DO','Halstead DO','Harrow North and South DO','Hayes DO','Helston DO',
			'High Wycombe North DO','Holyhead DO','Hucknall DO','Ilkeston DO','Islington DO','Iver DO','Keswick DO',
			'Kingsbridge DO','Kittybrewster DO','Largs DO','Leicester South DO','Leyburn DO','Liverpool 8 DO','Llantwit Major DO',
			'Loughborough DO','Maidenhead DO','Manchester Central DO','Marlow DO','Mildenhall DO','Montrose DO',
			'Mount Pleasant EC1 DO','Nailsea DO','Newark DO','Newton Aycliffe DO','Northampton NN3A DO',
			'Nottingham North DO','Orpington DO','Oxford East DO','Patchway DO','Petersfield DO','Pontefract DO',
			'Portsmouth DO','Pulborough DO','Reading DO','Ringwood DO','Royston DO','Sandhurst DO','Seaton DO',
			'Sheffield West DO','Skelmersdale DO','Slough DO','Southend On Sea DO','St Albans DO','Steyning DO',
			'Streatham DO','Sutton DO','Swindon DO','Swindon West DO','Tewkesbury DO','Tong Road DO',
			'Turriff DO','Wallingford DO','Wembley Lows DO','Westhill DO','Wimbledon DO','Worcester DO',
			'Ystalyfera DO')
		
inner join
EDW_SCVER_CODA_ACCS_VIEWS.v_event_party vep
on vep.event_id = vd.event_id
and (event_actual_dt between :parameter1 and :parameter2)
and Event_Party_Role_Id = 1 
and data_source_type_id =2  --RECIPIENT
	 --Note: this isn't 1 to 1. events can have multiple parties, hence the group by.
	
	
inner join 
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address vpa
on vpa.party_id = vep.party_id
and address_type_id = 1 vpa --Postal Address

	
inner join 
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address vda
on vda.address_id = vpa.address_id					
AND address_type = 'MA') vda --MAIN ADDRESS
	
	
inner join 
EDW_SCVER_CODA_DIM_VIEWS.v_dim_address_ops_hierarchy vdoah
on vdaoh.address_id = vpa.address_id
AND delivery_office IN (
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
);

/*TEMPORARY TABLES TO BE CREATED

INNER JOIN
MgrS_LAM.PARTY_EVENT_TODS pet
ON pet.event_id = vd.event_id
INNER JOIN
MgrS_LAM.PARTY_ADDRESS_HIERARCHY pah
ON pah.party_id = pet.party_id

*/