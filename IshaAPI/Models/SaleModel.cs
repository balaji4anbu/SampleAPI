using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IshaAPI.Models
{

    public class SALEDET
    {
        public string SalId { get; set; }
        public string ItemName { get; set; }
        public string Qty { get; set; }
        public string Rate { get; set; }
        public string Amount { get; set; }
    }

    public class SaleModel
    {
        public string SalId { get; set; }
        public string Billno { get; set; }
        public string BillDt { get; set; }
        public string TotAmt { get; set; }
        public string RndOff { get; set; }
        public string ReturnAmt { get; set; }
        public string NetAmt { get; set; }
        public string ReceivedAmt { get; set; }
        public string PaymentMode { get; set; }
        public object Customer { get; set; }
        public string BankReceiptNo { get; set; }
        public string ApprovedBy { get; set; }
        public object GivenThrough { get; set; }
        public string Remarks { get; set; }
        public string SalmanId { get; set; }
        public List<SALEDET> SALEDET { get; set; }
    }
}