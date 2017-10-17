/* MEARS */

SEL top 1000 * FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_creation_date = date '2017-02-08'
and MEARS_MAIL_DATA_MARK IS NOT NULL
;

SEL  
Piece_Id,	Mears_Event_Id,	Mears_Event_Timestamp,	MEARS_MAIL_DATA_MARK,	
EIB_BC_OCR_Addr_Result,	EIB_BC_CBC_Addr_Result,	EIB_BC_Addr_Result

FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_creation_date = date '2017-03-02'
and EIB_BC_Info_Type_ID=11
and MEARS_MAIL_DATA_MARK IS NOT NULL
;


sel esc.sc_mo_org_name , count (distinct TAG_ID) as tagcount
FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece msp
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_eib_supply_chain esc
ON esc.supply_chain_id = msp.eib_bc_supply_chain_id
and msp.tag_creation_date = date '2017-03-02'
and msp.MEARS_MAIL_DATA_MARK is not null
Group by 1
order by tagcount desc
;



