SEL 
vd.event_id event_id,   -------NEED x
vd.event_actual_dttm event_dttm,  ------- NEED x
vpet.postal_event_type_desc postal_event_type_desc, ----NEED   x
vbbtd.barcode barcode, --- NEED X
pah.address_id address_id, ---NEED X
pah.postcode postcode, ---NEED X
pah.delivery_point delivery_point, ---NEED X
pah.do_name do_name, ---NEED X
'RMGTT' as Source

FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_delivery vd
LEFT JOIN
EDW_SCVER_BO_VIEWS.v_postal_event vpe
ON vd.event_id = vpe.event_id
AND (vpe.event_actual_date  BETWEEN  '2016-10-01' and '2016-10-31')
AND vpe.POSTAL_EVENT_TYPE_ID IN(0,12)
LEFT join EDW_SCVER_BO_VIEWS.v_postal_piece_event vppe
ON vpe.event_id = vppe.event_id
AND (vppe.event_actual_date BETWEEN  '2016-10-01' and '2016-10-31')
LEFT join EDW_SCVER_BO_VIEWS.v_postal_event_type vpet
ON vpe.postal_event_type_id = vpet.postal_event_type_id
LEFT JOIN EDW_SCVER_BO_VIEWS.v_bo_base_track_data vbbtd
ON vppe.piece_id = vbbtd.piece_id
AND (vbbdt.scan_date              BETWEEN  '2016-10-01' and '2016-10-31')
AND vbbtd.TRACK_NUMBER = 'TRACK7'
INNER JOIN
MgrS_LAM.PARTY_EVENT_RMGTT per
ON per.event_id = vd.event_id
INNER JOIN
MgrS_LAM.PARTY_ADDRESS_HIERARCHY pah
ON pah.party_id = per.party_id

where (vd.event_actual_date   BETWEEN  '2016-10-01' and '2016-10-31')
AND vd.source_system = 'RMGTT'
;