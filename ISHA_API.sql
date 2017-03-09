
/*
Author: Balaji.A
Description: Fetch Data from Client(MASTER CONFIGURATION)
*/         
CREATE Proc Api_Qry_Mas        
as                   
select * from sim Where simId>0      
Select * from Tax Where TaxId>0          
select * from item Where ItemId>0        
select * from acc_achd  where AccId>100      
select * from acc_achddet Where AccId>100          
select * from acc_achdadddet Where AccId>100  
select * from BundleHdr where BundleId>0  
select * from BundleDet where BundleId>0
--------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Insert Data from Client to Server (MASTER CONFIGURATION)
*/       
CREATE Proc Api_MasProcessSP(@DetStr NText)                          
as                       
--SET XACT_ABORT ON                                                  
BEGIN  TRANSACTION                            
 DECLARE @IDoc int                 
 --This Transcation Runs only in Main server; do not run local server or any other server.            
 Declare @query varchar(max)           
        
  --------------------------Sim--------------------------------      
  EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr     
 SELECT  * into #SimTmp  FROM   OPENXML(@iDoc, '/Root/SIM', 2)          
 WITH (simId Int, simName varchar(150), RefId tinyint, UpDownNo smallint, UserId smallint,LocId tinyint,CompId tinyint)           
         
  EXEC sp_xml_removedocument @idoc                                       
   IF @@Error > 0                                                      
  GOTO ErrLbl       
           
    
 Insert into Sim            
 Select a.* from #SimTmp a  LEFT JOIN Sim b ON  a.simId = b.simId            
 WHERE   b.simId IS NULL and a.simId>0           
            
           
 Update Sim Set simName=a.simName       
 from #SimTmp a LEFT JOIN Sim b ON  a.simId = b.simId            
 WHERE b.simId IS not NULL and a.simId>0          
 IF @@Error > 0                                                      
  GOTO ErrLbl         
                               
 -----------Sim---------------------------------      
     
        
  --------------------------Tax--------------------------------      
  EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr     
      
 SELECT  * into #TaxTmp  FROM   OPENXML(@iDoc, '/Root/TAX', 2)          
 WITH (TaxId smallInt, TaxName varchar(20), TaxPer num42, Vat bit, UserId tinyint,Compid tinyint,CommCode varchar(15))           
         
       
    EXEC sp_xml_removedocument @idoc                         
    
                                                                               
    
     IF @@Error > 0                                                                          
    
         GOTO ErrLbl         
    
 Insert into Tax            
 Select a.* from #TaxTmp a  LEFT JOIN Tax b ON  a.TaxId = b.TaxId            
 WHERE   b.TaxId IS NULL and a.TaxId>0           
         
           
 Update Tax Set TaxName=a.TaxName,TaxPer=a.TaxPer,Vat=a.Vat      
 from #TaxTmp a LEFT JOIN Tax b ON  a.TaxId = b.TaxId            
 WHERE b.TaxId IS not NULL and a.TaxId>0          
     
                                      
   IF @@Error > 0                                                      
  GOTO ErrLbl    
 -------------Tax---------------------------------      
       
             
 ---------------Item---------------------------------      
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr     
                                       
 SELECT  * into #ItemTmp  FROM   OPENXML(@iDoc, '/Root/ITEM', 2)          
 WITH (ItemId Int, ItemCode varchar(20), ItemName Varchar(80), CateGoryId smallint, ItemGrpId smallint,           
 AccId Int, Rate num122,UserId tinyint,CompId tinyint,LastPurRate num82,LastSaleRate num82,TaxId smallint,          
 TamilName nvarchar(200),BrandId int,            
 UnitId int,ReOrdQty num103,PurRate num82,ShName varchar(10),CatId int)           
         
   EXEC sp_xml_removedocument @idoc                                       
   IF @@Error > 0                                                      
  GOTO ErrLbl         
        
           
 Insert into Item            
 Select a.* from #ItemTmp a  LEFT JOIN Item b ON  a.ItemId = b.ItemId            
 WHERE   b.ItemId IS NULL and a.ItemId>0           
          
           
 Update Item Set ItemCode=a.ItemCode,ItemName=a.ItemName            
 from #ItemTmp a LEFT JOIN Item b ON  a.ItemId = b.ItemId            
 WHERE b.ItemId IS not NULL and a.ItemId>0          
   IF @@Error > 0                                                      
  GOTO ErrLbl    
     
                
  -------------Item---------------------------------       
        
  -------------Acc_Achd---------------------------------           
  EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr     
                                   
 SELECT  * into #AchdTmp  FROM   OPENXML(@iDoc, '/Root/ACC_ACHD', 2)          
 WITH (AccId Int, AcCode varchar(6), AccName nVarchar(200), OtherState bit, AllComp bit,           
 Predefined bit, UserId tinyint,TransportId int)           
         
EXEC sp_xml_removedocument @idoc                                       
   IF @@Error > 0                                                      
  GOTO ErrLbl      
           
    
 Insert into Acc_Achd            
 Select a.* from #AchdTmp a  LEFT JOIN Acc_Achd b ON  a.AccId = b.AccId            
 WHERE   b.AccId IS NULL and a.AccId>100           
       
           
 Update Acc_Achd Set AccName=a.AccName,OtherState=a.OtherState,TransportId=a.TransportId            
 from #AchdTmp a LEFT JOIN Acc_Achd b ON  a.AccId = b.AccId            
 WHERE b.AccId IS not NULL and a.AccId>100          
     
     
                                   
   IF @@Error > 0                                                      
  GOTO ErrLbl                     
  -------------Acc_Achd---------------------------------               
        
    -------------Acc_AchdDet---------------------------------      
    EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr     
                                          
 SELECT  * into #AchdDetTmp  FROM   OPENXML(@iDoc, '/Root/ACC_ACHDDET', 2)          
 WITH (AccId Int, OpBal num142, DrCr char(1), CrLimitDays smallint, CrLimitAmt num142,           
 GrpId int, SubGrpId1 int,SubGrpId2 int,BlockId tinyint,DepnVal num122,BudgetId tinyint,CompId tinyint,Hide bit)           
         
 EXEC sp_xml_removedocument @idoc                                       
   IF @@Error > 0                                                      
  GOTO ErrLbl    
               
 Insert into Acc_AchdDet           
 Select a.* from #AchdDetTmp a  LEFT JOIN Acc_AchdDet b ON  a.AccId = b.AccId            
 WHERE   b.AccId IS NULL and a.AccId>100           
             
           
 Update Acc_AchdDet Set OpBal=a.OpBal,DrCr=a.DrCr,CrLimitDays=a.CrLimitDays,CrLimitAmt=a.CrLimitAmt,GrpId=a.GrpId, SubGrpId1=a.SubGrpId1,SubGrpId2=a.SubGrpId2           
 from #AchdDetTmp a LEFT JOIN Acc_AchdDet b ON  a.AccId = b.AccId            
 WHERE b.AccId IS not NULL and a.AccId>100          
                    
     
                     
   IF @@Error > 0                                                      
  GOTO ErrLbl    
  -------------Acc_AchdDet---------------------------------       
        
      -------------Acc_AchdAddDet---------------------------------     
      EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr     
                                             
 SELECT  * into #AchdAddDetTmp  FROM   OPENXML(@iDoc, '/Root/ACHD_ADDDET', 2)          
 WITH (AccId Int, Add1 nvarchar(200), Add2 nvarchar(200),Add3 nvarchar(200), City nvarchar(200),AreaId int,Pincode varchar(15),Ph1 varchar(20),           
 Ph2 varchar(20), Cell varchar(14),TIN varchar(25),CST varchar(25),Contactperson varchar(50),ContactCell varchar(14),EMail varchar(60),Fax varchar(40),      
 URL varchar(40),BankName varchar(250),AccountName varchar(250),AccountNo varchar(250),BranchName varchar(250),IFSCCode varchar(250))           
         
EXEC sp_xml_removedocument @idoc                                       
   IF @@Error > 0                                                      
  GOTO ErrLbl       
           
     
 Insert into Acc_AchdAddDet           
 Select a.* from #AchdAddDetTmp a  LEFT JOIN Acc_AchdAddDet b ON  a.AccId = b.AccId            
 WHERE   b.AccId IS NULL and a.AccId>100           
         
           
 Update Acc_AchdAddDet Set Add1=a.Add1,Add2=a.Add2,Add3=a.Add3,City=a.City,AreaId=a.AreaId, Pincode=a.Pincode,Ph1=a.Ph1,Ph2=a.Ph2,Cell=a.Cell,TIN=a.TIN,      
 CST=a.CST,Contactperson=a.Contactperson,ContactCell=a.ContactCell,EMail=a.EMail,Fax=a.Fax,URL=a.URL,BankName=a.BankName,AccountName=a.AccountName,      
 AccountNo=a.AccountNo,BranchName=a.BranchName,IFSCCode=a.IFSCCode       
 from #AchdAddDetTmp a LEFT JOIN Acc_AchdAddDet b ON  a.AccId = b.AccId            
 WHERE b.AccId IS not NULL and a.AccId>100          
    
     
                                
   IF @@Error > 0                                                      
  GOTO ErrLbl                   
  -------------Acc_AchdAddDet---------------------------------                 
                                                       
COMMIT TRANSACTION          
--SET XACT_ABORT OFF          
RETURN          
Errlbl:          
BEGIN          
 ROLLBACK          
 RETURN            
END 
--------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Fetch Data from Client (PURCHASE DATA)
*/   
CREATE Proc Qry_GetPurchaseData(@Dt datetime,@CompId tinyint)                    
as                    
Select PurId,PurNo,PurDt,InvNo,InvDt,PtyId,OtherState,Cash,Narr,TotAmt,NetAmt,Discper,    
DiscAmt,TaxId,Taxper,TaxAmt,UserId,CompId,AcYrId,              
DocCancel,OtherAmt,CrDays,EntryTime,GId             
from PurHdr Where PurDt=@Dt and CompId = @CompId    
    
Select d.PurId, d.ItemId, d.CategoryId, d.Qty, d.Free, d.PurRate, d.SaleRate, d.Amount,     
d.TaxId, d.TaxPer, d.TaxAmt, d.Description,d.GId              
from PurDet d,PurHdr h where h.PurId=d.PurId and h.CompId = @CompId and h.PurDt=@Dt     
         
Select d.PurId, d.AccId, d.AcCode, d.Amount, d.DrCr, d.TaxId ,d.GId              
from PurPostDet d,PurHdr h Where h.PurId=d.PurId and h.CompId = @CompId and h.PurDt=@Dt         
              
-------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Insert Data from Client to Server (PURCHASE DATA)
*/    
CREATE Proc Api_PurSP(@DetStr Text)                        
as                     
                                             
BEGIN  TRANSACTION               
DECLARE @IDoc int                   
    
                 
 -- save the purchase transaction in temp table     
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr                    
 SELECT  PurId,PurNo,PurDt,InvNo,InvDt,PtyId,OtherState,Cash,Narr,TotAmt,NetAmt,Discper,DiscAmt,TaxId,Taxper,TaxAmt,UserId,CompId,AcYrId,DocCancel,    
 OtherAmt,CrDays,EntryTime,GId into #purhdrTmp        
 FROM OPENXML(@iDoc, '/Root/PurHdr', 2)        
 WITH (PurId int,PurNo int, PurDt datetime, InvNo varchar(25), InvDt datetime, PtyId int,       
 OtherState bit, Cash bit, Narr varchar(100), TotAmt num122, NetAmt num122, Discper num42,       
 DiscAmt num82, TaxId smallint, Taxper num42, TaxAmt num82, UserId tinyint, CompId tinyint,       
 AcYrId smallint, DocCancel bit, OtherAmt num82, CrDays int, EntryTime datetime, GId uniqueidentifier)       
       
   
       
    EXEC sp_xml_removedocument @idoc                                                                    
 IF @@Error > 0  GOTO ErrLbl     
     
     
 --   Select a.* --ROW_NUMBER() over(order by a.PurId)+(select ISNULL(max(p.PurId),0) from PurHdr p)  as PurId,       
 ----a.PurNo, a.PurDt, a.InvNo, a.InvDt, a.PtyId, a.OtherState, a.Cash, a.Narr,       
 ----a.TotAmt, a.NetAmt, a.Discper, a.DiscAmt, a.TaxId, a.Taxper, a.TaxAmt, a.UserId, a.CompId, a.AcYrId,       
 ----a.DocCancel, a.OtherAmt, a.CrDays, a.EntryTime, a.GId       
 --from #purhdrTmp a --    
 --Left Outer Join purhdr b ON  a.GId = b.GId          
 ----WHERE  b.PurId IS NULL          
     
  -- insert and update purchase header table using temp table      
 Insert into purhdr          
 Select ROW_NUMBER() over(order by a.PurId)+(select ISNULL(max(p.PurId),0) from PurHdr p)  as PurId,       
 a.PurNo, a.PurDt, a.InvNo, a.InvDt, a.PtyId, a.OtherState, a.Cash, a.Narr,       
 a.TotAmt, a.NetAmt, a.Discper, a.DiscAmt, a.TaxId, a.Taxper, a.TaxAmt, a.UserId, a.CompId, a.AcYrId,       
 a.DocCancel, a.OtherAmt, a.CrDays, a.EntryTime, a.GId       
 from #purhdrTmp a  LEFT JOIN purhdr b ON  a.GId = b.GId          
 WHERE  b.PurId IS NULL          
         
    print 'A'  
 Update purhdr Set  purhdr.PurDt=a.PurDt, purhdr.InvNo=a.InvNo, purhdr.InvDt=a.InvDt,       
 purhdr.PtyId=a.PtyId, purhdr.OtherState=a.OtherState, purhdr.Cash=a.Cash,purhdr.Narr=a.Narr, purhdr.TotAmt=a.TotAmt,       
 purhdr.NetAmt=a.NetAmt, purhdr.Discper=a.Discper, purhdr.DiscAmt=a.DiscAmt, purhdr.TaxId=a.TaxId, purhdr.Taxper=a.Taxper,       
 purhdr.TaxAmt=a.TaxAmt, purhdr.UserId=a.UserId, purhdr.CompId=a.CompId, purhdr.AcYrId=a.AcYrId, purhdr.DocCancel=a.DocCancel,       
 purhdr.OtherAmt=a.OtherAmt, purhdr.CrDays=a.CrDays    
 from #purhdrTmp a LEFT JOIN purhdr  ON a.PurId=purhdr.PurId and a.GId = purhdr.GId          
 WHERE purhdr.PurId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl      
   print 'B'  
     
  EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr     
 SELECT  * into #purdetTmp        
 FROM OPENXML(@iDoc, '/Root/PurDet', 2)        
 WITH (PurId int, ItemId int, CategoryId smallint, Qty num103, Free num103, PurRate num82, SaleRate num82,       
 Amount num122, TaxId smallint, TaxPer num42, TaxAmt num82, Description varchar(100), GId uniqueidentifier)      
     
  EXEC sp_xml_removedocument @idoc                                                                    
 IF @@Error > 0  GOTO ErrLbl      
   print 'N'  
  -- update purchase detail and post temp table using purchase header table      
 Update #purdetTmp set PurId=a.PurId       
 from  purhdr a JOIN #purhdrTmp b ON  a.GId = b.GId       
 IF @@Error > 0  GOTO ErrLbl        
   print 'N'  
  -- insert and update purchase detail table using temp table      
 Insert into purdet       
 Select a.PurId, a.ItemId, a.CategoryId, a.Qty, a.Free, a.PurRate, a.SaleRate, a.Amount,       
 a.TaxId, a.TaxPer, a.TaxAmt, a.Description, a.GId      
 from #purdetTmp a  LEFT JOIN purdet b ON  a.GId = b.GId          
 WHERE  b.PurId IS NULL          
 IF @@Error > 0  GOTO ErrLbl          
    print 'M'  
 Update purdet Set purdet.ItemId=a.ItemId, PurDet.CategoryId=a.CategoryId, PurDet.Qty=a.Qty, PurDet.Free=a.Free, PurDet.PurRate=a.PurRate,       
 PurDet.SaleRate=a.SaleRate,PurDet.Amount=a.Amount, PurDet.TaxId=a.TaxId, PurDet.TaxPer=a.TaxPer, PurDet.TaxAmt=a.TaxAmt, PurDet.Description=a.Description   
 from #purdetTmp a LEFT JOIN purdet  ON a.PurId=PurDet.PurId and a.GId = PurDet.GId          
 WHERE PurDet.PurId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl     
    
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr         
 SELECT  * into #purpostdetTmp        
 FROM OPENXML(@iDoc, '/Root/PurPostDet', 2)        
 WITH (PurId int, AccId int, AcCode varchar(6), Amount num122, DrCr char(1), TaxId smallint, GId uniqueidentifier)      
  EXEC sp_xml_removedocument @idoc                                                                    
 IF @@Error > 0  GOTO ErrLbl         
          print 'D'  
 Update #purpostdetTmp set PurId=a.PurId       
 from  purhdr a JOIN #purpostdetTmp b ON  a.GId = b.GId       
 IF @@Error > 0  GOTO ErrLbl        
        print 'F'  
              
          
 -- insert and update purchase post table using temp table      
 Insert into PurPostDet          
 Select a.PurId, a.AccId, a.AcCode, a.Amount, a.DrCr, a.TaxId, a.GId      
 from #purpostdetTmp a  LEFT JOIN PurPostDet b ON  a.GId = b.GId          
 WHERE  b.PurId IS NULL          
 IF @@Error > 0  GOTO ErrLbl          
    print 'C'  
 Update PurPostDet Set PurPostDet.AccId=a.AccId, PurPostDet.AcCode=a.AcCode, PurPostDet.Amount=a.Amount,       
 PurPostDet.DrCr=a.DrCr, PurPostDet.TaxId=a.TaxId, PurPostDet.GId=a.GId      
 from #purpostdetTmp a LEFT JOIN PurPostDet  ON a.PurId=PurPostDet.PurId and a.GId = PurPostDet.GId          
 WHERE PurPostDet.PurId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl                                                 
COMMIT TRANSACTION        
--SET XACT_ABORT OFF        
RETURN        
Errlbl:        
BEGIN        
 ROLLBACK        
 RETURN          
END            
-------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Fetch Data from Client (PURCHASE RETURN DATA)
*/ 
CREATE Proc Qry_GetPurRetData(@Dt datetime,@CompId tinyint)                
as                
Select PurRetId, PurRetNo, PurRetDt, PurRetInvNo, PurRetInvDt, PtyId, OtherState, Cash, Narr,     
TotAmt, NetAmt, DiscPer, DiscAmt, TaxId, TaxPer, TaxAmt, UserId, CompId, AcYrId, OtherChargs, EntryTime,GId            
from PurRetHdr Where CompId=@CompId and PurRetDt=@Dt     
              
Select d.PurRetId, ItemId, CategoryId, Qty, PurRate, SaleRate, Amount, Free,d.GId    
from PurRetDet d,PurRetHdr h         
Where CompId=@CompId and  h.PurRetId=d.PurRetId and PurRetDt=@Dt        
         
Select d.PurRetId, AccId, AcCode, Amount, DrCr, d.TaxId,d.GId    
from PurRetPostDet d,PurRetHdr h         
Where CompId=@CompId and  h.PurRetId=d.PurRetId and PurRetDt=@Dt        
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Insert Data from Client to Server (PURCHASE RETURN DATA)
*/           
CREATE Proc Api_PurRetSP(@DetStr NText)                        
as                     
--SET XACT_ABORT ON                                                
BEGIN  TRANSACTION                          
 DECLARE @IDoc int               
 declare @MaxPurRetId int      
 set @MaxPurRetId=(select MAX(PurRetid) from PurRetHdr)       
 --This Transcation Runs only in Main server; do not run local server or any other server.          
 Declare @query varchar(max)         
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr          
               
 -- save the purchase transaction in temp table                    
 SELECT  * into #PurRethdrTmp        
 FROM OPENXML(@iDoc, '/Root/PurRetHdr', 2)        
 WITH (PurRetId int, PurRetNo int, PurRetDt datetime,PurRetInvNo varchar(25),PurRetInvDt datetime,  PtyId int,       
 OtherState bit,Cash bit,Narr varchar(100),TotAmt num122,NetAmt num122,DiscPer num42,DiscAmt num82,TaxId smallint,TaxPer num42,    
 TaxAmt num82,UserId tinyint,CompId tinyint,AcYrId smallint,OtherChargs num122, EntryTime datetime,GId uniqueidentifier     
 )       
                      
 SELECT  * into #PurRetdetTmp        
 FROM OPENXML(@iDoc, '/Root/PurRetDet', 2)        
 WITH (PurRetId int, ItemId int, CategoryId smallint, Qty num103, PurRate num82,SaleRate num82,    
 Amount num122,Free num103, GId uniqueidentifier)       
         
 SELECT  * into #PurRetpostdetTmp        
 FROM OPENXML(@iDoc, '/Root/PurRetPostDet', 2)        
 WITH (PurRetId int, AccId int, AcCode varchar(6), Amount num122, DrCr char(1), TaxId smallint, GId uniqueidentifier)      
       
          
 EXEC sp_xml_removedocument @idoc                                                                    
 IF @@Error > 0  GOTO ErrLbl          
      
 -- insert and update purchase header table using temp table      
 Insert into PurRetHdr          
 Select ROW_NUMBER() over(order by a.PurRetId)+(select ISNULL(max(p.PurRetId),0) from PurRetHdr p),       
 a.PurRetNo, a.PurRetDt,a.PurRetInvNo,a.PurRetInvDt,a.PtyId ,a.OtherState,a.Cash,a.Narr,a.TotAmt,a.NetAmt,a.DiscPer,  
 a.DiscAmt,a.TaxId,a.TaxPer,a.TaxAmt,    
 a.UserId,a.CompId,a.AcYrId,a.OtherChargs,a.EntryTime,a.GId    
 from #PurRethdrTmp a  LEFT JOIN PurRetHdr b ON  a.GId = b.GId          
 WHERE  b.PurRetId IS NULL          
 IF @@Error > 0  GOTO ErrLbl          
             
 Update b Set b.PurRetNo=a.PurRetNo, b.PurRetDt=a.PurRetDt,b.PurRetInvNo=a.PurRetInvNo,b.PurRetInvDt=a.PurRetInvDt,b.PtyId=a.PtyId,    
 b.OtherState=a.OtherState,b.Cash=a.Cash,b.Narr=a.Narr,b.TotAmt=a.TotAmt,b.NetAmt=a.NetAmt,b.DiscPer=a.DiscPer,b.DiscAmt=a.DiscAmt,b.TaxId=a.TaxId,    
 b.TaxPer=a.TaxPer,b.TaxAmt=a.TaxAmt,b.UserId=a.UserId,b.CompId=a.CompId,b.AcYrId=a.AcYrId,b.OtherChargs=a.OtherChargs    
 from #PurRethdrTmp a LEFT JOIN PurRethdr b ON a.PurRetId=b.PurRetId and a.GId = b.GId          
 WHERE b.PurRetId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl  
   
 -- update purchase detail and post temp table using purchase header table      
 Update b set b.PurRetId=a.PurRetId       
 from PurRethdr a JOIN #PurRethdrTmp b ON  a.GId = b.GId       
 IF @@Error > 0  GOTO ErrLbl         
         
 Update b set b.PurRetId=a.PurRetId       
 from  PurRethdr a JOIN #PurRetpostdetTmp b ON  a.GId = b.GId       
 IF @@Error > 0  GOTO ErrLbl      
   
 -- insert and update purchase detail table using temp table      
 Insert into PurRetdet       
 Select a.PurRetId, a.ItemId, a.CategoryId, a.Qty, a.PurRate, a.SaleRate, a.Amount,a.Free,a.GId    
 from #PurRetdetTmp a  LEFT JOIN PurRetdet b ON  a.GId = b.GId          
 WHERE  b.PurRetId IS NULL          
 IF @@Error > 0  GOTO ErrLbl    
                
 Update b Set b.ItemId=a.ItemId, b.CategoryId=a.CategoryId, b.Qty=a.Qty, b.PurRate=a.PurRate, b.SaleRate=a.SaleRate,b.Amount=a.Amount,b.Free=a.Free    
 from #PurRetdetTmp a LEFT JOIN PurRetdet b ON a.PurRetId=b.PurRetId and a.GId = b.GId          
 WHERE b.PurRetId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl               
          
 -- insert and update purchase post table using temp table      
 Insert into PurRetPostDet          
 Select a.PurRetId, a.AccId, a.AcCode, a.Amount, a.DrCr, a.TaxId, a.GId      
 from #PurRetpostdetTmp a  LEFT JOIN PurRethdr b ON  a.GId = b.GId          
 WHERE  b.PurRetId IS NULL          
 IF @@Error > 0  GOTO ErrLbl          
      
 Update b Set b.AccId=a.AccId, b.AcCode=a.AcCode, b.Amount=a.Amount,       
 b.DrCr=a.DrCr, b.TaxId=a.TaxId, b.GId=a.GId      
 from #PurRetpostdetTmp a LEFT JOIN PurRetPostDet b ON a.PurRetId=b.PurRetId and a.GId = b.GId          
 WHERE b.PurRetId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl                                                 
COMMIT TRANSACTION        
--SET XACT_ABORT OFF        
RETURN        
Errlbl:        
BEGIN        
 ROLLBACK        
 RETURN          
END       
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Fetch Data from Client(SALES DATA)
*/    
CREATE Proc Qry_GetSalesData(@Dt datetime,@CompId tinyint)                        
as                        
Select SalId, BillNo, BillDt, BookId, Cash, BillRefNo, PtyId, PtyName, Add1, City, TotAmt, TaxId,       
  Taxper, TaxAmt, RndOff, NetAmt, DiscAmt, Discper, Remarks, UserId, CompId, AcYrId, DocCancel,       
  OtherState, Charge1, Charge2, ReceivedAmt, TIN, Despatch, Destination, BankAccId, ChqType,       
  ChqNo, ChqDt, ChqAmt, SalmanId, Approved, GivenThro, RecNo, RetId, RetAmt, EntryTime,GId                              
from SalHdr Where CompId=@CompId and BillDt=@Dt  
  
Select d.SalId, d.ItemId, d.CategoryId, d.Qty, d.Rate, d.Amount, d.SlNo, d.Free, d.TaxId,       
    d.TaxPer, d.TaxAmt, d.Descript, d.RateTypeId,d.GId ,d.BundleId     
from SalDet d,SalHdr h Where CompId=@CompId and h.SalId=d.SalId and h.BillDt=@Dt  
  
Select d.SalId, d.AccId, d.AcCode, d.Amount, d.DrCr, d.TaxId,d.GId                    
from SalPostDet d,SalHdr h Where CompId=@CompId and h.SalId=d.SalId and h.BillDt=@Dt 
   
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Insert Data from Client to Server (SALES DATA)
*/              
CREATE Proc Api_SalSP(@DetStr NText)                          
as                       
--SET XACT_ABORT ON                                                  
BEGIN  TRANSACTION                            
 DECLARE @IDoc int                 
 declare @MaxSalId int        
 set @MaxSalId=(select MAX(Salid) from SalHdr)         
 --This Transcation Runs only in Main server; do not run local server or any other server.            
 Declare @query varchar(max)           
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr            
                   
 -- save the purchase transaction in temp table                      
 SELECT  * into #SalhdrTmp          
 FROM OPENXML(@iDoc, '/Root/SalHdr', 2)          
 WITH (SalId int, BillNo int, BillDt datetime,BookId smallint,Cash char(2),BillRefNo varchar(15),  PtyId int,         
 PtyName nvarchar(200),Add1 nvarchar(200),City nvarchar(200),TotAmt num122,TaxId smallint,Taxper num42,TaxAmt num82,RndOff num42,NetAmt num122,DiscAmt num82,Discper num42,      
 Remarks varchar(150),UserId tinyint,CompId tinyint,AcYrId smallint,DocCancel bit, OtherState bit,Charge1 num122,Charge2 num122,ReceivedAmt num122,TIN varchar(25),      
 Despatch varchar(25), Destination Varchar(25), BankAccId int, ChqType Char(1),ChqNo varchar(15), ChqDt datetime,ChqAmt num122,SalmanId int ,Approved int,      
 GivenThro varchar(50),RecNo int,RetId int,RetAmt num122,EntryTime datetime,GId uniqueidentifier,DayClose bit      
 )         
         
 SELECT  * into #SaldetTmp          
 FROM OPENXML(@iDoc, '/Root/SalDet', 2)          
 WITH (SalId int, ItemId int, CategoryId smallint, Qty num103, Rate num82,       
 Amount num122,SlNo num82,Free num103, TaxId smallint, TaxPer num42, TaxAmt num82, Descript varchar(150),RateTypeId int,   
 GId uniqueidentifier,BundleId int)         
           
 SELECT  * into #SalpostdetTmp          
 FROM OPENXML(@iDoc, '/Root/SalPostDet', 2)          
 WITH (SalId int, AccId int, AcCode varchar(6), Amount num122, DrCr char(1), TaxId smallint, GId uniqueidentifier)        
           
 EXEC sp_xml_removedocument @idoc                                                                      
 IF @@Error > 0  GOTO ErrLbl            
   print 'A'     
   select * from #SalhdrTmp       
 -- insert and update purchase header table using temp table        
 Insert into SalHdr            
 Select ROW_NUMBER() over(order by a.SalId)+(select ISNULL(max(p.SalId),0) from SalHdr p),         
 a.BillNo, a.BillDt,a.BookId,a.Cash,a.BillRefNo , a.PtyId,a.PtyName,a.Add1,a.City,a.TotAmt,a.TaxId,a.Taxper,a.TaxAmt,a.RndOff,a.NetAmt,a.DiscAmt,      
 a.Discper,a.Remarks,a.UserId,a.CompId,a.AcYrId,a.DocCancel,a.OtherState, a.Charge1, a.Charge2,a.ReceivedAmt,a.TIN, a.Despatch, a.Destination,       
 a.BankAccId,a.ChqType,a.ChqNo,a.ChqDt,a.ChqAmt,a.SalmanId,a.Approved,a.GivenThro,a.RecNo,a.RetId,a.RetAmt,a.EntryTime,a.GId,a.DayClose      
 from #SalhdrTmp a  LEFT JOIN SalHdr b ON  a.GId = b.GId            
 WHERE  b.SalId IS NULL            
 IF @@Error > 0  GOTO ErrLbl       
     
       
        
 Update Salhdr Set Salhdr.BillNo=a.BillNo, Salhdr.BillDt=a.BillDt,Salhdr.BookId=a.BookId,Salhdr.Cash=a.Cash,Salhdr.BillRefNo=a.BillRefNo,      
 Salhdr.PtyId=a.PtyId,Salhdr.PtyName=a.PtyName,Salhdr.Add1=a.Add1,Salhdr.City=a.City,Salhdr.TaxId=a.TaxId,Salhdr.Taxper=a.Taxper,Salhdr.TaxAmt=a.TaxAmt,Salhdr.RndOff=a.RndOff,Salhdr.NetAmt=a.NetAmt,      
 Salhdr.DiscAmt=a.DiscAmt,Salhdr.Discper=a.Discper,Salhdr.Remarks=a.Remarks,Salhdr.UserId=a.UserId,Salhdr.CompId=a.CompId,Salhdr.AcYrId=a.AcYrId,Salhdr.DocCancel=a.DocCancel,Salhdr.OtherState=a.OtherState,      
 Salhdr.Charge1=a.Charge1, Salhdr.Charge2=a.Charge2, Salhdr.ReceivedAmt=a.ReceivedAmt,Salhdr.TIN=a.TIN,Salhdr.Despatch=a.Despatch,Salhdr.Destination=a.Destination,Salhdr.BankAccId=a.BankAccId,      
 Salhdr.ChqType=a.ChqType, Salhdr.ChqNo=a.ChqNo, Salhdr.ChqDt=a.ChqDt, Salhdr.ChqAmt=a.ChqAmt, Salhdr.SalmanId=a.SalmanId,         
 Salhdr.Approved=a.Approved, Salhdr.GivenThro=a.GivenThro, Salhdr.RecNo=a.RecNo, Salhdr.RetId=a.RetId, Salhdr.RetAmt=a.RetAmt            
 from #SalhdrTmp a LEFT JOIN Salhdr  ON a.SalId=Salhdr.SalId and a.GId = Salhdr.GId            
 WHERE Salhdr.SalId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl        
         
 -- update purchase detail and post temp table using purchase header table        
 Update #SaldetTmp set SalId=a.SalId         
 from  Salhdr a JOIN #SalhdrTmp b ON  a.GId = b.GId         
 IF @@Error > 0  GOTO ErrLbl           
         
 Update #SalpostdetTmp set SalId=a.SalId         
 from Salhdr a JOIN #SalpostdetTmp b ON  a.GId = b.GId         
 IF @@Error > 0  GOTO ErrLbl          
            
 -- insert and update purchase detail table using temp table        
 Insert into Saldet         
 Select a.SalId, a.ItemId, a.CategoryId, a.Qty, a.Rate, a.Amount, a.SlNo, a.Free,         
 a.TaxId, a.TaxPer, a.TaxAmt, a.Descript, a.RateTypeId,a.GId,a.BundleId       
 from #SaldetTmp a  LEFT JOIN Saldet b ON  a.GId = b.GId            
 WHERE  b.SalId IS NULL            
 IF @@Error > 0  GOTO ErrLbl            
        
 Update Saldet Set Saldet.ItemId=a.ItemId, Saldet.CategoryId=a.CategoryId, Saldet.Qty=a.Qty, Saldet.Rate=a.Rate, Saldet.Amount=a.Amount,         
 Saldet.SlNo=a.SlNo,Saldet.Free=a.Free, Saldet.TaxId=a.TaxId, Saldet.TaxPer=a.TaxPer, Saldet.TaxAmt=a.TaxAmt, Saldet.Descript=a.Descript, Saldet.RateTypeId=a.RateTypeId      
 ,Saldet.BundleId=a.BundleId  
 from #SaldetTmp a LEFT JOIN Saldet  ON a.SalId=Saldet.SalId and a.GId = Saldet.GId            
 WHERE Saldet.SalId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl                 
            
 -- insert and update purchase post table using temp table        
 Insert into SalPostDet            
 Select a.SalId, a.AccId, a.AcCode, a.Amount, a.DrCr, a.TaxId, a.GId        
 from #SalpostdetTmp a  LEFT JOIN Salhdr b ON  a.GId = b.GId            
 WHERE  b.SalId IS NULL            
 IF @@Error > 0  GOTO ErrLbl            
        
 Update SalPostDet Set SalPostDet.AccId=a.AccId, SalPostDet.AcCode=a.AcCode, SalPostDet.Amount=a.Amount,         
 SalPostDet.DrCr=a.DrCr, SalPostDet.TaxId=a.TaxId, SalPostDet.GId=a.GId        
 from #SalpostdetTmp a LEFT JOIN SalPostDet  ON a.SalId=SalPostDet.SalId and a.GId = SalPostDet.GId            
 WHERE SalPostDet.SalId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl                                                   
COMMIT TRANSACTION          
--SET XACT_ABORT OFF          
RETURN          
Errlbl:          
BEGIN          
 ROLLBACK          
 RETURN            
END 
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Fetch Data from Client(SALES RETURN DATA)
*/    
                
CREATE Proc Qry_GetSalRetData(@Dt datetime,@CompId tinyint)                      
as                      
Select SalRetId, SalRetNo, SalRetDt, BookId, AcYrId, PtyId, PtyName, Cash, OtherState,         
TotAmt, TaxAmt, RndOff, NetAmt, UserId, CompId, Narration, TaxId, Add1, City, TaxPer,         
DiscAmt, DiscPer, BillRefNo, EntryTime,GId,DocCancel               
from SalRetHdr Where CompId=@CompId and SalRetDt=@Dt         
                    
Select d.SalRetId, ItemId, CategoryId, Qty, Rate, Amount,d.GId,d.BundleId             
from SalRetDet d,SalRetHdr h              
Where CompId=@CompId and h.SalRetId=d.SalRetId and SalRetDt=@Dt         
                  
Select d.SalRetId, AccId, AcCode, Amount, DrCr, d.TaxId,d.GId               
from SalRetPostDet d,SalRetHdr h              
Where CompId=@CompId and h.SalRetId=d.SalRetId and SalRetDt=@Dt              
 
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Insert Data from Client to Server (SALES RETURN DATA)
*/          
CREATE Proc Api_SalRetSP(@DetStr NText)                          
as                       
--SET XACT_ABORT ON                                                  
BEGIN  TRANSACTION                            
 DECLARE @IDoc int                 
          
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr            
                   
 -- save the purchase transaction in temp table                      
 SELECT  * into #SalRethdrTmp          
 FROM OPENXML(@iDoc, '/Root/SalRetHdr', 2)          
 WITH (SalRetId int, SalRetNo int, SalRetDt datetime,BookId smallint,AcYrId smallint,  PtyId int,         
 PtyName varchar(75),Cash char(2),OtherState bit,TotAmt num122,TaxAmt num82,RndOff num42,NetAmt num122,UserId tinyint,      
 CompId tinyint,Narration varchar(50),TaxId smallint,Add1 varchar(75),City varchar(75), TaxPer num42,DiscAmt num82,DiscPer num42,BillRefNo varchar(15),      
 EntryTime datetime, GId uniqueidentifier, DocCancel bit       
 )         
     print 'A'    
 SELECT  * into #SalRetdetTmp          
 FROM OPENXML(@iDoc, '/Root/SalRetDet', 2)          
 WITH (SalRetId int, ItemId int, CategoryId smallint, Qty int, Rate num82,       
 Amount num122, GId uniqueidentifier,BundleId int)         
           
 SELECT  * into #SalRetpostdetTmp          
 FROM OPENXML(@iDoc, '/Root/SalRetPostDet', 2)          
 WITH (SalRetId int, AccId int, AcCode varchar(6), Amount num122, DrCr char(1), TaxId smallint, GId uniqueidentifier)        
           
 EXEC sp_xml_removedocument @idoc                                                                      
 IF @@Error > 0  GOTO ErrLbl            
        
 -- insert and update purchase header table using temp table    
 print 'B'        
     
 select * from #SalRethdrTmp    
 Insert into SalRetHdr            
 Select ROW_NUMBER() over(order by a.SalRetId)+(select ISNULL(max(p.SalRetId),0) from SalRetHdr p ) as SalRetId,         
 a.SalRetNo, a.SalRetDt,a.BookId,a.AcYrId,a.PtyId ,a.PtyName,a.Cash,a.OtherState,a.TotAmt,a.TaxAmt,a.RndOff,a.NetAmt,a.UserId,a.CompId,      
 a.Narration,a.TaxId,a.Add1,a.City,a.TaxPer,a.DiscAmt,a.DiscPer, a.BillRefNo, a.EntryTime,a.GId,a.DocCancel      
 from #SalRethdrTmp a  LEFT JOIN SalRetHdr b ON  a.GId = b.GId            
 WHERE  b.SalRetId IS NULL            
 IF @@Error > 0  GOTO ErrLbl            
  print 'C'      
 Update SalRethdr Set SalRetHdr.SalRetNo=a.SalRetNo, SalRetHdr.SalRetDt=a.SalRetDt,SalRetHdr.BookId=a.BookId,SalRetHdr.AcYrId=a.AcYrId,SalRetHdr.PtyId=a.PtyId,      
 SalRetHdr.PtyName=a.PtyName,SalRetHdr.Cash=a.Cash,SalRetHdr.OtherState=a.OtherState,SalRetHdr.TotAmt=a.TotAmt,SalRetHdr.TaxAmt=a.TaxAmt,SalRetHdr.RndOff=a.RndOff,SalRetHdr.NetAmt=a.NetAmt,SalRetHdr.UserId=a.UserId,      
 SalRetHdr.CompId=a.CompId,SalRetHdr.Narration=a.Narration,SalRetHdr.TaxId=a.TaxId,SalRetHdr.Add1=a.Add1,SalRetHdr.City=a.City,SalRetHdr.TaxPer=a.TaxPer,SalRetHdr.DiscAmt=a.DiscAmt,SalRetHdr.DiscPer=a.DiscPer,      
 SalRetHdr.BillRefNo=a.BillRefNo, SalRetHdr.DocCancel=a.DocCancel       
 from #SalRethdrTmp a LEFT JOIN SalRethdr  ON a.SalRetId=SalRetHdr.SalRetId and a.GId = SalRetHdr.GId            
 WHERE SalRetHdr.SalRetId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl        
         
 -- update purchase detail and post temp table using purchase header table        
 Update #SalRetdetTmp set SalRetId=a.SalRetId         
 from  SalRethdr a JOIN #SalRethdrTmp b ON  a.GId = b.GId         
 IF @@Error > 0  GOTO ErrLbl           
         
 Update #SalRetpostdetTmp set SalRetId=a.SalRetId         
 from  SalRethdr a JOIN #SalRetpostdetTmp b ON  a.GId = b.GId         
 IF @@Error > 0  GOTO ErrLbl          
            
 -- insert and update purchase detail table using temp table        
 Insert into SalRetdet         
 Select a.SalRetId, a.ItemId, a.CategoryId, a.Qty, a.Rate, a.Amount, a.GId,a.BundleId      
 from #SalRetdetTmp a  LEFT JOIN SalRetdet b ON  a.GId = b.GId            
 WHERE  b.SalRetId IS NULL            
 IF @@Error > 0  GOTO ErrLbl            
        
 Update SalRetdet Set SalRetDet.ItemId=a.ItemId, SalRetDet.CategoryId=a.CategoryId, SalRetDet.Qty=a.Qty,   
 SalRetDet.Rate=a.Rate, SalRetDet.Amount=a.Amount ,SalRetDet.BundleId=a.BundleId      
 from #SalRetdetTmp a LEFT JOIN SalRetdet  ON a.SalRetId=SalRetDet.SalRetId and a.GId = SalRetDet.GId            
 WHERE SalRetDet.SalRetId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl                 
            
 -- insert and update purchase post table using temp table     Insert into SalRetPostDet            
 Select a.SalRetId, a.AccId, a.AcCode, a.Amount, a.DrCr, a.TaxId, a.GId        
 from #SalRetpostdetTmp a  LEFT JOIN SalRethdr b ON  a.GId = b.GId            
 WHERE  b.SalRetId IS NULL            
 IF @@Error > 0  GOTO ErrLbl            
        
 Update SalRetPostDet Set SalRetPostDet.AccId=a.AccId, SalRetPostDet.AcCode=a.AcCode, SalRetPostDet.Amount=a.Amount,         
 SalRetPostDet.DrCr=a.DrCr, SalRetPostDet.TaxId=a.TaxId, SalRetPostDet.GId=a.GId        
 from #SalRetpostdetTmp a LEFT JOIN SalRetPostDet  ON a.SalRetId=SalRetPostDet.SalRetId and a.GId = SalRetPostDet.GId            
 WHERE SalRetPostDet.SalRetId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl                                                   
COMMIT TRANSACTION          
--SET XACT_ABORT OFF          
RETURN          
Errlbl:          
BEGIN          
 ROLLBACK          
 RETURN            
END 
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Fetch Data from Client(INWARD DATA)
*/    
CREATE Proc Qry_GetInwardData(@Dt datetime,@CompId tinyint)                  
as  
                
Select InwId, InwNo, InwDt, Remarks, UserId, CompId, EntryTime, IsAuthenticate,GId               
from InwHdr Where CompId=@CompId and InwDt=@Dt    
                 
Select d.InwId, ItemId, Qty, SlNo,d.GId             
from InwDet d,InwHdr h          
Where CompId=@CompId and h.InwId=d.InwId and InwDt=@Dt               
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Insert Data from Client to Server (INWARD DATA)
*/   
          
CREATE Proc Api_InwardSP(@DetStr NText)                        
as                     
--SET XACT_ABORT ON                                                
BEGIN  TRANSACTION                          
 DECLARE @IDoc int               
  
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr          
                 
 -- save the purchase transaction in temp table                    
 SELECT  * into #InwhdrTmp        
 FROM OPENXML(@iDoc, '/Root/InwHdr', 2)        
 WITH (InwId int, InwNo int, InwDt datetime,Remarks varchar(50),UserId tinyint,  CompId tinyint,EntryTime datetime,IsAuthenticate bit,       
 GId uniqueidentifier,RefNo varchar(20)     
 )       
       
 SELECT  * into #InwdetTmp        
 FROM OPENXML(@iDoc, '/Root/InwDet', 2)        
 WITH (InwId int, ItemId int, Qty num103, SlNo num103, GId uniqueidentifier)       
             
 EXEC sp_xml_removedocument @idoc                                                                    
 IF @@Error > 0  GOTO ErrLbl          
      
 -- insert and update purchase header table using temp table      
 Insert into InwHdr          
 Select ROW_NUMBER() over(order by a.InwId)+(select ISNULL(max(p.InwId),0) from InwHdr p),       
 a.InwNo, a.InwDt,a.Remarks,a.UserId,a.CompId , a.EntryTime,a.IsAuthenticate,a.GId,a.RefNo     
 from #InwhdrTmp a  LEFT JOIN InwHdr b ON  a.GId = b.GId          
 WHERE  b.InwId IS NULL          
 IF @@Error > 0  GOTO ErrLbl          
      
 Update Inwhdr Set InwHdr.InwNo=a.InwNo, InwHdr.InwDt=a.InwDt,InwHdr.Remarks=a.Remarks,InwHdr.UserId=a.UserId,InwHdr.CompId=a.CompId,    
 InwHdr.RefNo=a.RefNo     
 from #InwhdrTmp a LEFT JOIN Inwhdr  ON a.InwId=InwHdr.InwId and a.GId = InwHdr.GId          
 WHERE InwHdr.InwId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl      
       
 -- update purchase detail and post temp table using purchase header table      
 Update #InwdetTmp set InwId=a.InwId       
 from Inwhdr a JOIN #InwhdrTmp b ON  a.GId = b.GId       
 IF @@Error > 0  GOTO ErrLbl         
       
  -- insert and update purchase detail table using temp table      
 Insert into Inwdet       
 Select a.InwId, a.ItemId, a.Qty, a.SlNo, a.GId    
 from #InwdetTmp a  LEFT JOIN Inwdet b ON  a.GId = b.GId          
 WHERE  b.InwId IS NULL          
 IF @@Error > 0  GOTO ErrLbl          
      
 Update Inwdet Set InwDet.ItemId=a.ItemId, InwDet.Qty=a.Qty, InwDet.SlNo=a.SlNo    
 from #InwdetTmp a LEFT JOIN Inwdet  ON a.InwId=InwDet.InwId and a.GId = InwDet.GId          
 WHERE InwDet.InwId IS not NULL       
 IF @@Error > 0  GOTO ErrLbl               
          
                                              
COMMIT TRANSACTION        
--SET XACT_ABORT OFF        
RETURN        
Errlbl:        
BEGIN        
 ROLLBACK        
 RETURN          
END 
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Fetch Data from Client(OUTWARD DATA)
*/ 
CREATE Proc Qry_GetOutwardData(@Dt datetime,@CompId tinyint)                  
as                  
Select DocId, DocNo, DocDt, StallId, ToEvent, Event, TotQty, UserId, CompId, inwId, EntryTime, Remark ,Gid    
from OutwardHdr Where CompId=@CompId and DocDt=@Dt         
            
Select d.DocId, ItemId, CategoryId, Qty,d.GId       
from OutwardDet d,OutwardHdr h          
Where CompId=@CompId and h.DocId=d.DocId and DocDt=@Dt  
-----------------------------------------------------------------------------------------------------------------
GO
/*
Author: Balaji.A
Description: Insert Data from Client to Server (OUTWARD DATA)
*/          
CREATE Proc Api_OutwardSP(@DetStr NText)                          
as                       
--SET XACT_ABORT ON                                                  
BEGIN  TRANSACTION                            
 DECLARE @IDoc int                 
           
 EXEC sp_xml_preparedocument @idoc OUTPUT, @DetStr            
                   
 -- save the purchase transaction in temp table                      
 SELECT  * into #OutwardhdrTmp          
 FROM OPENXML(@iDoc, '/Root/OutwardHdr', 2)          
 WITH (DocId int, DocNo int, DocDt datetime,StallId int,ToEvent bit,  Event varchar(200),TotQty int,UserId tinyint,CompId tinyint,inwId int,EntryTime datetime,        
 Remark varchar(150),GId uniqueidentifier, RefNo varchar(20)      
 )         
         
 SELECT  * into #OutwarddetTmp          
 FROM OPENXML(@iDoc, '/Root/OutwardDet', 2)          
 WITH (DocId int, ItemId int,CategoryId int, Qty int, GId uniqueidentifier)         
               
 EXEC sp_xml_removedocument @idoc                                                                      
 IF @@Error > 0  GOTO ErrLbl            
        
 -- insert and update purchase header table using temp table        
 Insert into OutwardHdr            
 Select ROW_NUMBER() over(order by a.DocId)+(select ISNULL(max(p.DocId),0) from OutwardHdr p),         
 a.DocNo, a.DocDt,a.StallId,a.ToEvent,a.Event , a.TotQty,a.UserId,a.CompId,a.inwId,a.EntryTime,a.Remark,a.GId,a.RefNo       
 from #OutwardhdrTmp a  LEFT JOIN OutwardHdr b ON  a.GId = b.GId            
 WHERE  b.DocId IS NULL            
 IF @@Error > 0  GOTO ErrLbl            
        
 Update Outwardhdr Set OutwardHdr.DocNo=a.DocNo, OutwardHdr.DocDt=a.DocDt,OutwardHdr.StallId=a.StallId,  
 OutwardHdr.ToEvent=a.ToEvent,OutwardHdr.Event=a.Event,      
 OutwardHdr.TotQty=a.TotQty,OutwardHdr.UserId=a.UserId,OutwardHdr.CompId=a.CompId,OutwardHdr.inwId=a.inwId,  
 OutwardHdr.Remark=a.Remark,OutwardHdr.RefNo=a.RefNo      
 from #OutwardhdrTmp a LEFT JOIN Outwardhdr  ON a.DocId=OutwardHdr.DocId and a.GId = OutwardHdr.GId            
 WHERE OutwardHdr.DocId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl        
         
 -- update purchase detail and post temp table using purchase header table        
 Update #OutwarddetTmp set DocId=a.DocId         
 from Outwardhdr a JOIN #OutwardhdrTmp b ON  a.GId = b.GId         
 IF @@Error > 0  GOTO ErrLbl           
         
  -- insert and update purchase detail table using temp table        
 Insert into Outwarddet         
 Select a.DocId, a.ItemId, a.CategoryId,a.Qty, a.GId      
 from #OutwarddetTmp a  LEFT JOIN Outwarddet b ON  a.GId = b.GId            
 WHERE  b.DocId IS NULL            
 IF @@Error > 0  GOTO ErrLbl            
        
 Update Outwarddet Set Outwarddet.ItemId=a.ItemId, Outwarddet.CategoryId=a.CategoryId, Outwarddet.Qty=a.Qty      
 from #OutwarddetTmp a LEFT JOIN Outwarddet ON a.DocId=Outwarddet.DocId and a.GId = Outwarddet.GId            
 WHERE Outwarddet.DocId IS not NULL         
 IF @@Error > 0  GOTO ErrLbl                 
            
                                                
COMMIT TRANSACTION          
--SET XACT_ABORT OFF          
RETURN          
Errlbl:          
BEGIN          
 ROLLBACK          
 RETURN            
END 
-----------------------------------------------------------------------------------------------------------------
GO

ALTER function Fn_SalDet(@CompId tinyint)                          
returns table as return                          
Select D.SalId,ItemId,CategoryId,Qty,Free,RateTypeId,Rate,amount,d.TaxId,d.TaxPer,d.TaxAmt,Descript,SlNo,Isnull(BundleId,0)BundleId,BillDt
From SalDet D ,Fn_SalHdr(@compId) H                   
where h.SalId=D.SalID and CompId=@compId 
GO
---------------------------------------------------------------------------------------------------
alter function SalDetFn(@CompId tinyint)                                    
returns table as return                  
  
SELECT SalId,d.ItemId,ItemCode,ItemName,   
TamilName,i.CatId as CategoryId,Category,                                  
d.Qty,Free,d.Rate,d.Amount,d.TaxId,d.TaxPer,d.TaxAmt,TaxName ,Descript,SlNo,i.UnitId,Unit,i.BrandId,Brand,ShName,PurRate,d.BundleId,billdt                                    
From vw_Category C,vw_Brand b,                                    
Fn_Item(@CompId) I  ,Fn_tax(@CompId) t,vw_Unit u,Fn_SalDet(@CompId) D    
Where                                     
c.Categoryid=i.CatId  and b.BrandId=i.BrandId                      
and D.ItemId=I.ItemId and t.TaxId=d.TaxId and u.UnitId=i.UnitId        
and d.BundleId =0  
union all                     
       
Select SalId,D.ItemId,  
'BN'+Cast(BundleNo as varchar(20))  as ItemCode,  
'BN '+BundleName as ItemName,    
TamilName,i.CatId as CategoryId,Category,                                  
d.Qty,Free,d.Rate,d.Amount,d.TaxId,d.TaxPer,d.TaxAmt,TaxName ,Descript,SlNo,i.UnitId,Unit,i.BrandId,Brand,ShName,PurRate,d.BundleId,billdt                                     
From vw_Category C,vw_Brand b,                                    
Fn_Item(@CompId) I  ,Fn_tax(@CompId) t,vw_Unit u,Fn_SalDet(@CompId) D  ,Fn_BundleHdr(@CompId) bu   
Where c.Categoryid=i.CatId  and b.BrandId=i.BrandId                      
and D.ItemId=I.ItemId and t.TaxId=d.TaxId and u.UnitId=i.UnitId        
and bu.BundleId=d.BundleId and d.BundleId>0 and d.itemid=0   
------------------------------------------------------------------------                     
go
/*
Author: Balaji.A
Description: Fetch Data from Client(SALEPRINT)
*/ 
ALTER proc Api_SalePrint(@salId as int=0 ,@salDt as datetime, @compid as tinyint)
as                                 
Select SalId,Billno,BillDt,TotAmt,RndOff,RetAmt ReturnAmt,NetAmt,ReceivedAmt,
(case Cash when 'CA' then 'Cash' when 'CR' then 'Credit' 
           when 'BS' then 'Bank' when 'CM' then 'Compliment' end) PaymentMode,                                          
Customer,RecNo BankReceiptNo,Approved ApprovedBy,GivenThro GivenThrough,Remarks,SalmanId
from SalHdrFn(@compid) where  BillDt=@salDt and 
SalId=(case when @salId=0 then SalId else @salId end)

--If @salId>0
	Select SalId,Itemcode,ItemId,ItemName,TamilName,Descript,CategoryId,Category,  
	Qty,UnitId,Unit,Free,Rate,Amount,TaxId,TaxPer,TaxAmt,SlNo,BundleId    
	From SalDetfn(@compid)     
	where BillDt=@salDt and  
	SalId=(case when @salId=0 then SalId else @salId end)
	order by SlNo
------------------------------------------------------------------------------------------------------------
GO
