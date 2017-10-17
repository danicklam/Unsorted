 sel top 100* from
	edw_scver_coda_accs_views.v_PCL_ANA_REP;
sel top 100* from
edw_scver_coda_accs_views.v_PCL_EVENT_TYPE REF;
sel top 100* from
	edw_scver_coda_accs_views.v_BASE_PRE_ADV_ITEM_DETAIL;
sel top 100* from
	edw_scver_coda_accs_views.v_BASE_PRE_ADVICE ;
sel top 100* from
	edw_scver_coda_accs_views.v_BASE_MPE;

	
	sel * from 
		edw_scver_coda_accs_views.v_file_load_control
		where job_name like '%CREDO%'
		order by job_procsd_date desc
		;
		
sel * from 
EDW_SCVER_CODA_STG_VIEWS.v_stg_credo_redagree
where date_appl_recorded = '18.01.2017'
		;
		
	sel cast(substr(file_header_date,2,8) as date format 'YYYYMMDD') as file_date, job_procsd_date, exec_status,
	
	(case when file_date = job_procsd_date and exec_status = 'SUCCESSFUL' then 'GOOD'
	ELSE 'BEHIND' END) as UPTODATE
	
	from edw_scver_coda_accs_views.v_file_load_control
		where job_name like '%CREDO%' and data_file_name = 'MASTER'
		order by job_procsd_date desc
	   ;
		
		
		sel top 10 * from edw_scver_coda_Accs_views.v_mears_shipper_piece;

		
		sel top 10 * from edw_scver_coda_Accs_views.v_event_party
				where event_actual_dt = '2017-06-05'
		and data_source_type_id = 8;
		
				sel top 10 * from edw_scver_coda_Accs_views.v_mears_adf_stg;
				
		sel expected_delivery_dt, count(*) from edw_scver_coda_accs_views.v_eib_manifest_items 
		group by 1;
		
		
		sel * from edw_Scver_coda_Accs_views.v_data_source_type;
		sel top 10 * from edw_Scver_coda_Accs_views.v_eib_manifest_items;
		
		sel * from EDW_SCVER_CODA_ACCS_VIEWS.v_eib_item;
		
		
		sel evp.party_id, count (msp.tag_id) from
		edw_scver_coda_Accs_views.v_event_party evp
		inner join edw_scver_coda_Accs_views.v_mears_shipper_piece msp
		on evp.tag_id = msp.tag_id
		and evp.event_Actual_dt = date '2017-06-01'
		and evp.data_source_type_id = 8
		inner join edw_scver_coda_accs_views.v_eib_manifest_items EMI
		on msp.EIB_BC_Item_Id = EMI.EIB_Item_Id
        and msp.EIB_BC_Supply_Chain_Id = EMI.Supply_Chain_Id
        inner join edw_scver_coda_accs_views.v_eib_item eit
        on EMI.Product_Cd = eit.Item_Cd
        and eit.item_cat_2 = 'Advertising Mail'
        group by 1
		;
		
		