SELECT * FROM   PR01A_Planner_upload_Sub 
WHERE   Output_to_MID_TABLE_Flag=0
--alter table  PR01A_Planner_upload_Sub  add   ID0 INT   identity(25000,1)
BEGIN  TRAN

--DELETE  FROM  PR01A_Planner_upload_Sub  where   QTY<0

/*
SELECT * FROM PR40_PR_Operation_Node 
---DELETE  PR40_PR_Operation_Node 
WHERE   1=1
--AND  created_on='2022-01-24 18:01:44.137'
AND   Operation_type_id=25
ORDER BY  node_id desc


INSERT  INTO PR01A_Planner_upload_Sub (ID,PR_ID,QTY)
SELECT  Document_id,PR_ID,QTY FROM   PR40_PR_Operation_Node  AA
WHERE   Operation_type_id=25
--AND  NOT EXISTS (SELECT 1 FROM   PR01A_Planner_upload_Sub WHERE PR_ID=AA.PR_ID AND id=AA.Document_id   ) 
AND  QTY<0
*/






INSERT  INTO PR01A_Planner_upload_Sub (ID,PR_ID,QTY)
SELECT  PR_SUB_ID,PR_ID,PlanQuantity FROM   PR14_MID_PR_TO_DPE_List  AA
WHERE  1=1
AND  created_by IN ('PR Process','PR Process_LOCAL BUY')
and  [Abnormal_flag]=0
and  [FR PR]=160652
--and   created_on>'2022-01-23 21:53:14.820'
--AND NOT EXISTS (SELECT 1 FROM   PR01A_Planner_upload_Sub WHERE PR_ID=AA.PR_ID AND id=AA.PR_SUB_ID   )
order by    PR_SUB_ID  desc

---------------------------------

BEGIN  TRAN
UPDATE   PR01A_Planner_upload_Sub
SET 
---SELECT *,
Vendorcode=Final_vendor_code,
Vendorname=Final_vendor_name,
PN=Final_Demand_PN,
PRICE=Final_Demand_PN_Price

FROM PR01A_Planner_upload_Sub AA  INNER  JOIN  PR01_Planner_upload  BB
ON AA.PR_ID=BB.ID
WHERE   Output_to_MID_TABLE_Flag=0

COMMIT

INSERT  INTO PR01A_Planner_upload_Sub (PR_ID,QTY,Source_id)
select  PR_ID,Qty_Revised*-1 AS QTY,ID FROM PR20_PR_Order_Change
WHERE  Status=104
and   PR#  NOT LIKE 'RB%'
AND Final_Approved_Date<'2022-01-24'
AND  PR_Rollback_to_WSS_Flag=1

--------------------------
INSERT INTO PR01A_Planner_upload_Sub (PR_ID,QTY,TO_DPE_Time_line)
SELECT  id,Final_Approve_qty,[PS_KBM_PO_DATE] FROM PR01_Planner_upload
WHERE   [PS_KBM_PO_DATE]>'2022-01-24'
AND status=13
ORDER BY STATUS



update    PR01A_Planner_upload_Sub
set   PR#=PR.PR#  
from  PR01A_Planner_upload_Sub  sub left  join [dbo].[PR01_Planner_upload]  PR
ON SUB.PR_ID=PR.ID

update    PR01A_Planner_upload_Sub
set  
--SELECT  
PN=TO_DPE.HostPartID,
  Vendorcode=SUBSTRING( TO_DPE.HostVendorLocID,6,LEN(TO_DPE.HostVendorLocID)-6),
  --QTY=TO_DPE.[PlanQuantity],
  PRICE=TO_DPE.[RB_Price],
  output_to_dpe_date=TO_DPE.output_to_dpe_date,
  DPE_PR_ID=TO_DPE.[FR PR],
  DPE_PR_ID_Created_on=[DPE_PR_CREATED_ON],
  output_to_dpe_flag=1,
  Output_to_MID_TABLE_Flag=1,
  Output_to_MID_TABLE_DATE=TO_DPE.[created_on]

from  PR01A_Planner_upload_Sub  sub inner  join PR14_MID_PR_TO_DPE_List  TO_DPE
ON sub.id=TO_DPE.PR_SUB_ID
--WHERE   IS_canceled=0


UPDATE   PR01A_Planner_upload_Sub
SET  Output_to_MID_TABLE_Flag=1
WHERE  QTY<0
-------------------------------------------------------------------------------




COMMIT


SELECT  AA.ORDER_TYPE,[PS_KBM_PO_DATE], aa.ID,AA.status, AA.Final_Approve_qty,aa.TTL_Supply_solution_qty,AA.Hardclose_qty,AA.PRE_Hardclose_qty,AA.QTY_ECC_GR,AA.qty_po_canceled, bb.qty ,isnull(aa.TTL_Supply_solution_qty,0)-isnull(bb.qty,0) as gap from  
  VW_PR03_PR_LIST aa
LEFT JOIN (SELECT PR_ID,SUM(qty) as qty from [dbo].[PR01A_Planner_upload_Sub] group by PR_ID) bb
on aa.id=bb.PR_ID
LEFT JOIN  PR01_Planner_upload  CC   ON AA.ID=CC.ID
WHERE  isnull(aa.TTL_Supply_solution_qty,0)<isnull(bb.qty,0)
ORDER BY AA.STATUS,isnull(aa.TTL_Supply_solution_qty,0)-isnull(bb.qty,0), ID

UPDATE    PR01A_Planner_upload_Sub
SET  ID=ID0
----SELECT * FROM PR01A_Planner_upload_Sub
WHERE   ID IS NULL


EXEC  [dbo].[PR_Purchase_Package_sub_01_PR_Verify_Approval]


select  SUM(Qty_Revised) from   PR20_PR_Order_Change 
where   PR_ID=422554  and  Status=104


select  PR_ID,Qty_Revised*-1 AS QTY,* FROM PR20_PR_Order_Change
WHERE   PR_ID=339156  and  Status=104


BEGIN  TRAN
UPDATE  PR20_PR_Order_Change
SET   Status=200
WHERE  ID=13610
COMMIT

select  * from PR14_MID_PR_TO_DPE_List  WHERE PR_ID=297868

UPDATE  PR14_MID_PR_TO_DPE_List
SET  Abnormal_flag=1
WHERE  [FR PR]=159659

SELECT * FROM  PR01A_Planner_upload_Sub 
---DELETE   PR01A_Planner_upload_Sub 
 WHERE PR_ID=339156




SELECT  * FROM PR01_Planner_upload  WHERE  id=477965


SELECT  * FROM   PR40_PR_Operation_Node  WHERE  PR_ID=438556  AND Operation_type_id=25


EXEC  [dbo].[PR_Purchase_Package_sub_70_PO_Change_Rollback_to_WSS]


exec  [dbo].[PR_Purchase_Package_sub_81_E2E_Deatail_to_table] 