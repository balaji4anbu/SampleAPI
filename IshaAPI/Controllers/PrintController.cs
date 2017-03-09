using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Http;
using System.Xml;
using System.Xml.Linq;
using IshaAPI.Models;
using Newtonsoft.Json;

namespace IshaAPI.Controllers
{
    public class PrintController : ApiController
    {
        public string GetPrint(string cid,string sid)
        {
            try
            {
                var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
                var ds = new DataSet();
                var jsonText="";
                using (var myCon = new SqlConnection(constr))
                {
                    myCon.Open();
                    var myCmd = new SqlCommand("Api_SalePrint", myCon) {CommandType = CommandType.StoredProcedure};

                    var myParameter = new SqlParameter("@salId", SqlDbType.Int) {Value = sid};
                    myCmd.Parameters.Add(myParameter);
                    myParameter = new SqlParameter("@salDt", SqlDbType.DateTime)
                    {
                        Value = DateTime.Now.ToString("dd-MMM-yyyy")
                    };
                    myCmd.Parameters.Add(myParameter);
                    myParameter = new SqlParameter("@compid", SqlDbType.TinyInt) {Value = cid};
                    myCmd.Parameters.Add(myParameter);

                    var myAdapt = new SqlDataAdapter {SelectCommand = myCmd};
                    myAdapt.Fill(ds);

                    myAdapt.Dispose();
                    myCmd.Dispose();
                    myCon.Close();
                    if (ds.Tables[0].Rows.Count == 1)
                    {
                        ds.Tables[0].TableName = "SaleHeader";
                        ds.Tables[1].TableName = "SALEDET";
                        ds.DataSetName = "Sale";
                        var dt = ds.Tables[1];
                        var sale = ds.Relations.Add("sale", ds.Tables[0].Columns["SalId"], ds.Tables[1].Columns["SalId"]);
                        sale.Nested = true;
                        var jsonS = new SaleModel()
                        {
                            SalId = ds.Tables[0].Rows[0]["SalId"].ToString(),
                            Billno = ds.Tables[0].Rows[0]["Billno"].ToString(),
                            BillDt = ds.Tables[0].Rows[0]["BillDt"].ToString(),
                            TotAmt = ds.Tables[0].Rows[0]["TotAmt"].ToString(),
                            RndOff = ds.Tables[0].Rows[0]["RndOff"].ToString(),
                            ReturnAmt = ds.Tables[0].Rows[0]["ReturnAmt"].ToString(),
                            NetAmt = ds.Tables[0].Rows[0]["NetAmt"].ToString(),
                            ReceivedAmt = ds.Tables[0].Rows[0]["ReceivedAmt"].ToString(),
                            PaymentMode = ds.Tables[0].Rows[0]["PaymentMode"].ToString(),
                            Customer = ds.Tables[0].Rows[0]["Customer"].ToString(),
                            BankReceiptNo = ds.Tables[0].Rows[0]["BankReceiptNo"].ToString(),
                            ApprovedBy = ds.Tables[0].Rows[0]["ApprovedBy"].ToString(),
                            GivenThrough = ds.Tables[0].Rows[0]["GivenThrough"].ToString(),
                            Remarks = ds.Tables[0].Rows[0]["Remarks"].ToString(),
                            SalmanId = ds.Tables[0].Rows[0]["SalmanId"].ToString(),
                            SALEDET = (from DataRow dr in dt.Rows
                                select new SALEDET()
                                {
                                    SalId = dr["SalId"].ToString(),
                                    ItemName = dr["ItemName"].ToString(),
                                    Qty = dr["Qty"].ToString(),
                                    Rate = dr["Rate"].ToString(),
                                    Amount = dr["Amount"].ToString()
                                }).ToList()
                        };
                        jsonText = JsonConvert.SerializeObject(jsonS);
                        //List<SaleModel> CustomObjectList = ds.Tables[0].AsEnumerable();

                    //    var xml = ds.GetXml();
                    //    var xmlDoc = new XmlDocument();
                    //    xmlDoc.LoadXml(xml);
                    //    //XmlNodeList xmlNode = xmlDoc.GetElementsByTagName("Sale");
                    //    //var xmlStr = "";
                    //    //if (xmlNode.Count < 0)
                    //    //{
                    //    //    jsonText = "Status: No Data";  
                    //    //}
                    //    //else
                    //    //{
                    //    //    xmlStr = xmlNode[0].InnerXml;
                    //    //}
                    //    //var xmlDoc1 = new XmlDocument();
                    //    //xmlDoc1.LoadXml(xmlStr);
                    //    jsonText = JsonConvert.SerializeXmlNode(xmlDoc);
                    //    jsonText= jsonText.Replace("{\"Sale\":{\"SaleHeader\":", "");
                    //    jsonText = jsonText.Substring(0, jsonText.Length - 2);
                    //    if (jsonText.Contains("\"SALEDET\":{"))
                    //    {
                    //        jsonText = jsonText.Replace("\"SALEDET\":{", "\"SALEDET\":[{");
                    //        jsonText = jsonText.Substring(0, jsonText.Length - 1);
                    //        jsonText = jsonText + "]}";
                    //    }
                    }
                    else
                    {
                        jsonText = "Status: No Data";
                    }
                }
                // var str = JsonConvert.SerializeObject(ds);
                return jsonText;
            }
            catch (SqlException ex)
            {
                return "Status:" + ex.Errors[0].Message;
            }
        }
    }
}
