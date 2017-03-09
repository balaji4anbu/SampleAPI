using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IshaAPI.Models
{

    #region PURCHASE OBJECT

    public class PurHdr
    {
        public int PurId { get; set; }
        public int PurNo { get; set; }
        public string PurDt { get; set; }
        public string InvNo { get; set; }
        public string InvDt { get; set; }
        public int PtyId { get; set; }
        public bool OtherState { get; set; }
        public bool Cash { get; set; }
        public string Narr { get; set; }
        public double TotAmt { get; set; }
        public double NetAmt { get; set; }
        public double Discper { get; set; }
        public double DiscAmt { get; set; }
        public int TaxId { get; set; }
        public double Taxper { get; set; }
        public double TaxAmt { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public int AcYrId { get; set; }
        public bool DocCancel { get; set; }
        public double OtherAmt { get; set; }
        public int CrDays { get; set; }
        public string EntryTime { get; set; }
        public string GId { get; set; }
    }

    public class PurDet
    {
        public int PurId { get; set; }
        public int ItemId { get; set; }
        public int CategoryId { get; set; }
        public double Qty { get; set; }
        public double Free { get; set; }
        public double PurRate { get; set; }
        public double SaleRate { get; set; }
        public double Amount { get; set; }
        public int TaxId { get; set; }
        public double TaxPer { get; set; }
        public double TaxAmt { get; set; }
        public string Description { get; set; }
        public string GId { get; set; }
    }

    public class PurPostDet
    {
        public int PurId { get; set; }
        public int AccId { get; set; }
        public string AcCode { get; set; }
        public double Amount { get; set; }
        public string DrCr { get; set; }
        public int TaxId { get; set; }
        public string GId { get; set; }
    }

    public class PurObject
    {
        public List<PurHdr> PurHdr { get; set; }
        public List<PurDet> PurDet { get; set; }
        public List<PurPostDet> PurPostDet { get; set; }
    }

    #endregion

    #region PURCHASE RETURN OBJECT
    public class PurRetHdr
    {
        public int PurRetId { get; set; }
        public int PurRetNo { get; set; }
        public string PurRetDt { get; set; }
        public string PurRetInvNo { get; set; }
        public string PurRetInvDt { get; set; }
        public int PtyId { get; set; }
        public bool OtherState { get; set; }
        public bool Cash { get; set; }
        public string Narr { get; set; }
        public double TotAmt { get; set; }
        public double NetAmt { get; set; }
        public double DiscPer { get; set; }
        public double DiscAmt { get; set; }
        public int TaxId { get; set; }
        public double TaxPer { get; set; }
        public double TaxAmt { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public int AcYrId { get; set; }
        public double OtherChargs { get; set; }
        public string EntryTime { get; set; }
        public string GId { get; set; }
    }

    public class PurRetDet
    {
        public int PurRetId { get; set; }
        public int ItemId { get; set; }
        public int CategoryId { get; set; }
        public double Qty { get; set; }
        public double PurRate { get; set; }
        public double SaleRate { get; set; }
        public double Amount { get; set; }
        public double Free { get; set; }
        public string GId { get; set; }
    }

    public class PurRetObject
    {
        public List<PurRetHdr> PurRetHdr { get; set; }
        public List<PurRetDet> PurRetDet { get; set; }
        public List<object> PurRetPostDet { get; set; }
    }
    #endregion

    #region SALE OBJECT
    public class SalHdr
    {
        public int SalId { get; set; }
        public int BillNo { get; set; }
        public string BillDt { get; set; }
        public int BookId { get; set; }
        public string Cash { get; set; }
        public string BillRefNo { get; set; }
        public int PtyId { get; set; }
        public string PtyName { get; set; }
        public string Add1 { get; set; }
        public string City { get; set; }
        public double TotAmt { get; set; }
        public int TaxId { get; set; }
        public double Taxper { get; set; }
        public double TaxAmt { get; set; }
        public double RndOff { get; set; }
        public double NetAmt { get; set; }
        public double DiscAmt { get; set; }
        public double Discper { get; set; }
        public string Remarks { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public int AcYrId { get; set; }
        public bool DocCancel { get; set; }
        public bool OtherState { get; set; }
        public double Charge1 { get; set; }
        public double Charge2 { get; set; }
        public double ReceivedAmt { get; set; }
        public string TIN { get; set; }
        public string Despatch { get; set; }
        public string Destination { get; set; }
        public int BankAccId { get; set; }
        public string ChqType { get; set; }
        public string ChqNo { get; set; }
        public string ChqDt { get; set; }
        public double ChqAmt { get; set; }
        public int SalmanId { get; set; }
        public int Approved { get; set; }
        public string GivenThro { get; set; }
        public int RecNo { get; set; }
        public int RetId { get; set; }
        public double RetAmt { get; set; }
        public string EntryTime { get; set; }
        public string GId { get; set; }
    }

    public class SalDet
    {
        public int SalId { get; set; }
        public int ItemId { get; set; }
        public int CategoryId { get; set; }
        public double Qty { get; set; }
        public double Rate { get; set; }
        public double Amount { get; set; }
        public double SlNo { get; set; }
        public double Free { get; set; }
        public int TaxId { get; set; }
        public double TaxPer { get; set; }
        public double TaxAmt { get; set; }
        public string Descript { get; set; }
        public int RateTypeId { get; set; }
        public string GId { get; set; }
        public int BundleId { get; set; }
    }

    public class SalPostDet
    {
        public int SalId { get; set; }
        public int AccId { get; set; }
        public string AcCode { get; set; }
        public double Amount { get; set; }
        public string DrCr { get; set; }
        public int TaxId { get; set; }
        public string GId { get; set; }
    }

    public class SalObject
    {
        public List<SalHdr> SalHdr { get; set; }
        public List<SalDet> SalDet { get; set; }
        public List<SalPostDet> SalPostDet { get; set; }
    }
    #endregion

    #region SALE RETURN OBJECT

    public class SalRetHdr
    {
        public int SalRetId { get; set; }
        public int SalRetNo { get; set; }
        public string SalRetDt { get; set; }
        public int BookId { get; set; }
        public int AcYrId { get; set; }
        public int PtyId { get; set; }
        public string PtyName { get; set; }
        public string Cash { get; set; }
        public bool OtherState { get; set; }
        public double TotAmt { get; set; }
        public double TaxAmt { get; set; }
        public double RndOff { get; set; }
        public double NetAmt { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public string Narration { get; set; }
        public int TaxId { get; set; }
        public string Add1 { get; set; }
        public string City { get; set; }
        public double TaxPer { get; set; }
        public double DiscAmt { get; set; }
        public double DiscPer { get; set; }
        public string BillRefNo { get; set; }
        public string EntryTime { get; set; }
        public string GId { get; set; }
        public bool DocCancel { get; set; }
    }

    public class SalRetDet
    {
        public int SalRetId { get; set; }
        public int ItemId { get; set; }
        public int CategoryId { get; set; }
        public int Qty { get; set; }
        public double Rate { get; set; }
        public double Amount { get; set; }
        public string GId { get; set; }
        public int BundleId { get; set; }
    }

    public class SalRetPostDet
    {
        public int SalRetId { get; set; }
        public int AccId { get; set; }
        public string AcCode { get; set; }
        public double Amount { get; set; }
        public string DrCr { get; set; }
        public int TaxId { get; set; }
        public string GId { get; set; }
    }

    public class SalRetObject
    {
        public List<SalRetHdr> SalRetHdr { get; set; }
        public List<SalRetDet> SalRetDet { get; set; }
        public List<SalRetPostDet> SalRetPostDet { get; set; }
    }
    #endregion

    #region INWARD OBJECT
    public class InwardHdr
    {
        public int InwId { get; set; }
        public int InwNo { get; set; }
        public string InwDt { get; set; }
        public string Remarks { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public string EntryTime { get; set; }
        public bool IsAuthenticate { get; set; }
        public string GId { get; set; }
    }

    public class InwardDet
    {
        public int InwId { get; set; }
        public int ItemId { get; set; }
        public double Qty { get; set; }
        public double SlNo { get; set; }
        public string GId { get; set; }
    }

    public class InwardObject
    {
        public List<InwardHdr> InwardHdr { get; set; }
        public List<InwardDet> InwardDet { get; set; }
    }
    #endregion

    #region OUTWARD OBJECT
    public class OutwardHdr
    {
        public int DocId { get; set; }
        public int DocNo { get; set; }
        public string DocDt { get; set; }
        public int StallId { get; set; }
        public bool ToEvent { get; set; }
        public string Event { get; set; }
        public int TotQty { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public int inwId { get; set; }
        public string EntryTime { get; set; }
        public string Remark { get; set; }
        public string GId { get; set; }
    }

    public class OutwardDet
    {
        public int DocId { get; set; }
        public int ItemId { get; set; }
        public int CategoryId { get; set; }
        public int Qty { get; set; }
        public string GId { get; set; }
    }

    public class OutwardObject
    {
        public List<OutwardHdr> OutwardHdr { get; set; }
        public List<OutwardDet> OutwardDet { get; set; }
    }
    #endregion
}