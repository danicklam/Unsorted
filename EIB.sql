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
		
		
select IT.Item_cat_2, count(distinct Tag_id) from
edw_scver_coda_accs_views.v_mears_shipper_piece MSP
inner join edw_scver_coda_accs_views.v_eib_manifest_items EMI
on MSP.EIB_BC_Item_Id = EMI.EIB_Item_Id
and MSP.EIB_BC_Supply_Chain_Id = EMI.Supply_Chain_Id
inner join edw_scver_coda_accs_views.v_eib_item IT
on EMI.Product_Cd = IT.Item_Cd
and msp.tag_creation_date = date '2017-06-08'
--and it.item_cat_2 = 'Advertising Mail'
group by 1 ;



