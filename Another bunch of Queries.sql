



CREATE MULTISET VOLATILE TABLE SN5_Parties
AS (
SEL distinct (vpa.party_id)
--- SEL vpa.party_id
FROM
EDW_SCVER_CODA_DIM_VIEWS.v_dim_address vda
INNER JOIN
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address vpa
ON vpa.address_id = vda.address_id  
 where vda.Postcode = 'SN5 5PL'
)
WITH DATA
PRIMARY INDEX (party_id)
ON COMMIT PRESERVE ROWS;



CREATE MULTISET VOLATILE TABLE SN5_Address
AS (
SEL vpa.party_id, vpa.address_id
FROM
EDW_SCVER_CODA_ACCS_VIEWS.v_party_address vpa
inner join
SN5_Parties SN5P
ON SN5P.party_id = vpa.party_id
)
WITH DATA
PRIMARY INDEX (address_id)
ON COMMIT PRESERVE ROWS;

 





sel * from
 EDW_SCVER_CODA_DIM_VIEWS.v_fct_piece_event
--where recipient_party_id = 833652993 
where mears_tag_id in ( '2010100795201')
;

sel top 10 * from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where tag_id = '2010100795201'
and Tag_Creation_Date = date '2016-11-01'
;


sel * from
EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece
where event_id = 2011684109121
and Tag_Creation_Date =date '2016-11-01'
;


SELECT TOP 9999999 fpe.Piece_Id, EVENT_ID, Recipient_Party_Id, Sender_Party_Id,
        Recipient_Address_Id, Sender_Address_Id, Postal_Event_Type_Id,
        Product_Id, Event_Actual_Date, Data_Source_Type_ID, MEARS_Tag_Id,
        MEARS_Tag_Creation_DT, POISE_Consignment_Id, Mail_Piece_Postage_Value,
        Mail_Piece_Length, Mail_Piece_Thickness, Mail_Piece_Height, Mail_Piece_Weight,
        Mail_Type_Id, Mail_Format, Mail_Class_Type_Id, EIB_Supply_Chain_Id,
        Licence_Number, msp.eib_bc_type,
        fpe.Postal_Piece_Type_Id, fpe.Mears_Event_Timestamp, MAX(fpe.SCVER_Load_Dttm), MAX(fpe.SCVER_Upd_Dttm)
FROM edw_Scver_coda_dim_views.v_fct_piece_event fpe
LEFT OUTER JOIN EDW_SCVER_CODA_ACCS_VIEWS.v_mears_shipper_piece msp
    ON fpe.mears_Tag_ID || MEARS_Tag_Creation_DT = msp.Tag_Id || msp.Tag_Creation_Date
WHERE recipient_address_id  = 312081263
AND Event_Actual_Date BETWEEN '2016-10-01' AND '2016-10-31'
and recipient_address_id = 312081263

GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 ,24, 25, 26
;


sel * from
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address
where address_id = 301989349
;

sel count (*), count(address_id)
from
EDW_SCVER_CODA_ACCS_VIEWS.v_dim_address;

