using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IshaAPI.Models
{
    public class SIM
    {
        public int simId { get; set; }
        public string simName { get; set; }
        public int RefId { get; set; }
        public int UpDownNo { get; set; }
        public int UserId { get; set; }
        public int LocId { get; set; }
        public int CompId { get; set; }
    }

    public class TAX
    {
        public int TaxId { get; set; }
        public string TaxName { get; set; }
        public double TaxPer { get; set; }
        public bool Vat { get; set; }
        public int UserId { get; set; }
        public int Compid { get; set; }
        public string CommCode { get; set; }
    }

    public class ITEM
    {
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public int CateGoryId { get; set; }
        public int ItemGrpId { get; set; }
        public int AccId { get; set; }
        public double Rate { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public double LastPurRate { get; set; }
        public double LastSaleRate { get; set; }
        public int TaxId { get; set; }
        public string TamilName { get; set; }
        public int BrandId { get; set; }
        public int UnitId { get; set; }
        public double ReOrdQty { get; set; }
        public double PurRate { get; set; }
        public string ShName { get; set; }
        public int CatId { get; set; }
    }

    public class ACCACHD
    {
        public int AccId { get; set; }
        public string AcCode { get; set; }
        public string AccName { get; set; }
        public bool OtherState { get; set; }
        public bool AllComp { get; set; }
        public bool Predefined { get; set; }
        public int UserId { get; set; }
        public int TransportId { get; set; }
    }

    public class ACCACHDDET
    {
        public int AccId { get; set; }
        public double OpBal { get; set; }
        public string DrCr { get; set; }
        public int CrLimitDays { get; set; }
        public double CrLimitAmt { get; set; }
        public int GrpId { get; set; }
        public int SubGrpId1 { get; set; }
        public int SubGrpId2 { get; set; }
        public int BlockId { get; set; }
        public double DepnVal { get; set; }
        public int BudgetId { get; set; }
        public int CompId { get; set; }
        public bool Hide { get; set; }
    }

    public class ACHDADDDET
    {
        public int AccId { get; set; }
        public string Add1 { get; set; }
        public string Add2 { get; set; }
        public string Add3 { get; set; }
        public string City { get; set; }
        public int AreaId { get; set; }
        public string Pincode { get; set; }
        public string Ph1 { get; set; }
        public string Ph2 { get; set; }
        public string Cell { get; set; }
        public string TIN { get; set; }
        public string CST { get; set; }
        public string Contactperson { get; set; }
        public string ContactCell { get; set; }
        public string EMail { get; set; }
        public string Fax { get; set; }
        public string URL { get; set; }
        public string BankName { get; set; }
        public string AccountName { get; set; }
        public string AccountNo { get; set; }
        public string BranchName { get; set; }
        public string IFSCCode { get; set; }
    }

    public class BUNDLEHDR
    {
        public int BundleId { get; set; }
        public int BundleNo { get; set; }
        public string BundleName { get; set; }
        public string CreatedOn { get; set; }
        public string ModifiedOn { get; set; }
        public string Remarks { get; set; }
        public double BundleRate { get; set; }
        public int UserId { get; set; }
        public int CompId { get; set; }
        public int AccYrId { get; set; }
    }

    public class BUNDLEDET
    {
        public int BundleId { get; set; }
        public int ItemId { get; set; }
        public double ItemRate { get; set; }
        public double BundleRate { get; set; }
        public int Qty { get; set; }
    }

    public class MasObject
    {
        public List<SIM> SIM { get; set; }
        public List<TAX> TAX { get; set; }
        public List<ITEM> ITEM { get; set; }
        public List<ACCACHD> ACC_ACHD { get; set; }
        public List<ACCACHDDET> ACC_ACHDDET { get; set; }
        public List<ACHDADDDET> ACHD_ADDDET { get; set; }
        public List<BUNDLEHDR> BUNDLEHDR { get; set; }
        public List<BUNDLEDET> BUNDLEDET { get; set; }
    }
}