 sel top 100 * from
 EDW_SCVER_BO_VIEWS.v_route
 ;
 
 
 sel count(*) from
 EDW_SCVER_BO_VIEWS.v_route
 ;
 
  sel * from
  EDW_SCVER_BO_VIEWS.v_location
  where location_id = 1177
 ;
 
  sel count(*) from
 EDW_SCVER_BO_VIEWS.v_location
 ;
 
 SELECT TOP 999999
l.LOCATION_NAME_RLN do_name,
r.route_num route_number,
r.route_type_desc route_type_desc,
r.walk_type_desc walk_type_desc,
r.walking_route_ind walking_route_ind,
r.Route_name route_name,
r.route_status route_status,
r.delivery_tran_type delivery_tran_type,
r.record_status record_status,
r.change_status change_status,
NULL paired_route_number,
NULL paired_order,
NULL manual_route_type

FROM EDW_SCVER_BO_VIEWS.v_route r
INNER JOIN "EDW_SCVER_BO_VIEWS"."v_location" l
    ON r.ROUTE_OWNER_LOCATION_ID = l.LOCATION_ID
WHERE r.RECORD_STATUS LIKE '%A%'
    --and l.location_name_rln = 'Cardiff North DO' 
	--and l.location_name_rln = 'Slough DO'
	--and l.location_name_rln = 'Burton on Trent DO'
	and l.location_name_rln = 'Cambridge DO'
;