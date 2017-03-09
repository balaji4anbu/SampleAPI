using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Dynamic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using IshaAPI.Models;
using Newtonsoft.Json;

namespace IshaAPI.Controllers
{
    public class IshaController : ApiController
    {
        #region MASTER CONFIGURATION (GET & ADD CONFIG)
        
        #region GET MASTER CONFIGURATION
        public string GetMas()
        {
            var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
            var ds = new DataSet();
            using (var myCon = new SqlConnection(constr))
            {
                myCon.Open();
                var myCmd = new SqlCommand("Api_Qry_Mas", myCon) { CommandType = CommandType.StoredProcedure };
                var myAdapt = new SqlDataAdapter { SelectCommand = myCmd };
                myAdapt.Fill(ds);;
                ds.Tables[0].TableName = "SIM";
                ds.Tables[1].TableName = "TAX";
                ds.Tables[2].TableName = "ITEM";
                ds.Tables[3].TableName = "ACC_ACHD";
                ds.Tables[4].TableName = "ACC_ACHDDET";
                ds.Tables[5].TableName = "ACHD_ADDDET";
                ds.Tables[6].TableName = "BUNDLEHDR";
                ds.Tables[7].TableName = "BUNDLEDET";

                myAdapt.Dispose();
                myCmd.Dispose();
                myCon.Close();
            }
            var str = JsonConvert.SerializeObject(ds);
            return str;
        } 
        #endregion

        //#region ADD MASTER CONFIGURATION
        //public string AddMas(MasObject val)
        //{
        //    try
        //    {

        //        var doc = JsonConvert.DeserializeXmlNode(JsonConvert.SerializeObject(val), "Root");
        //        var detStr = doc.InnerXml;

        //        var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
        //        var myCon = new SqlConnection(constr);
        //        myCon.Open();
        //        var myCmd = new SqlCommand("Api_MasProcessSP", myCon) { CommandType = CommandType.StoredProcedure };

        //        var param = new SqlParameter("@DetStr", SqlDbType.Text) { Value = detStr };
        //        myCmd.Parameters.Add(param);

        //        myCmd.ExecuteNonQuery();
        //        myCmd.Dispose();
        //        myCon.Close();
        //        return "{\"Status\":\"Updated Sucessfully\"}";
        //    }
        //    catch (SqlException ex)
        //    {
        //        return "{\"Status\":\"" + ex.Errors[0].Message + "\"}";
        //    }
        //}
        //#endregion

        #endregion
        
        #region PURCHASE ADD

        public string AddPur(PurObject val)
        {
            if (val == null) return "Status: Nothing Received";
            if (val.PurHdr.Count == 0 && val.PurDet.Count == 0 && val.PurPostDet.Count == 0)
                return "Status : No Data to Upload";
            try
            {

                //if (!val.Any() || val[0] == null) return "Nothing Received";
                var doc = JsonConvert.DeserializeXmlNode(JsonConvert.SerializeObject(val), "Root");
                var detStr = doc.InnerXml;

                var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
                var myCon = new SqlConnection(constr);
                myCon.Open();
                var myCmd = new SqlCommand("Api_PurSP", myCon) {CommandType = CommandType.StoredProcedure};

                var param = new SqlParameter("@DetStr", SqlDbType.Text) {Value = detStr};
                myCmd.Parameters.Add(param);

                myCmd.ExecuteNonQuery();
                myCmd.Dispose();
                myCon.Close();

                return "Status:Updated Sucessfully";
            }
            catch (SqlException ex)
            {
                return "Status:" + ex.Errors[0].Message ;
            }
        }

        #endregion

        #region PURCHASE RETURN ADD

        public string AddPurRet(PurRetObject val)
        {
            if (val == null) return "Status: Nothing Received";
            if (val.PurRetHdr.Count == 0 && val.PurRetDet.Count == 0 && val.PurRetPostDet.Count == 0)
                return "Status : No Data to Upload";
            try
            {
                var doc = JsonConvert.DeserializeXmlNode(JsonConvert.SerializeObject(val), "Root");
                var detStr = doc.InnerXml;

                var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
                var myCon = new SqlConnection(constr);
                myCon.Open();
                var myCmd = new SqlCommand("Api_PurRetSP", myCon) {CommandType = CommandType.StoredProcedure};

                var param = new SqlParameter("@DetStr", SqlDbType.Text) {Value = detStr};
                myCmd.Parameters.Add(param);

                myCmd.ExecuteNonQuery();
                myCmd.Dispose();
                myCon.Close();

                return "Status:Updated Sucessfully";
            }
            catch (SqlException ex)
            {
                return "Status:" + ex.Errors[0].Message;
            }
        }

        #endregion

        #region SALE ADD

        public string AddSal(SalObject val)
        {
            if (val == null) return "Status: Nothing Received";
            if (val.SalHdr.Count == 0 && val.SalDet.Count == 0 && val.SalPostDet.Count == 0)
                return "Status : No Data to Upload";
            try
            {
                var doc = JsonConvert.DeserializeXmlNode(JsonConvert.SerializeObject(val), "Root");
                var detStr = doc.InnerXml;

                var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
                var myCon = new SqlConnection(constr);
                myCon.Open();
                var myCmd = new SqlCommand("Api_SalSP", myCon) { CommandType = CommandType.StoredProcedure };

                var param = new SqlParameter("@DetStr", SqlDbType.Text) { Value = detStr };
                myCmd.Parameters.Add(param);

                myCmd.ExecuteNonQuery();
                myCmd.Dispose();
                myCon.Close();

                return "Status:Updated Sucessfully";
            }
            catch (SqlException ex)
            {
                return "Status:" + ex.Errors[0].Message;
            }
        }

        #endregion

        #region SALE RETURN ADD
        public string AddSalRet(SalRetObject val)
        {
            if (val == null) return "Status: Nothing Received";
            if (val.SalRetHdr.Count == 0 && val.SalRetDet.Count == 0 && val.SalRetPostDet.Count == 0) return "Status : No Data to Upload";
           
            try
            {
                var doc = JsonConvert.DeserializeXmlNode(JsonConvert.SerializeObject(val), "Root");
                var detStr = doc.InnerXml;

                var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
                var myCon = new SqlConnection(constr);
                myCon.Open();
                var myCmd = new SqlCommand("Api_SalRetSP", myCon) { CommandType = CommandType.StoredProcedure };

                var param = new SqlParameter("@DetStr", SqlDbType.Text) { Value = detStr };
                myCmd.Parameters.Add(param);

                myCmd.ExecuteNonQuery();
                myCmd.Dispose();
                myCon.Close();

                return "Status:Updated Sucessfully";
            }
            catch (SqlException ex)
            {
                return "Status:" + ex.Errors[0].Message;
            }
        }
        #endregion

        #region OUTWARD ADD
        public string AddOut(OutwardObject val)
        {
            if (val == null) return "Status: Nothing Received";
            if (val.OutwardDet.Count == 0 && val.OutwardHdr.Count == 0) return "Status : No Data to Upload";
            try
            {
                var doc = JsonConvert.DeserializeXmlNode(JsonConvert.SerializeObject(val), "Root");
                var detStr = doc.InnerXml;

                var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
                var myCon = new SqlConnection(constr);
                myCon.Open();
                var myCmd = new SqlCommand("Api_OutwardSP", myCon) {CommandType = CommandType.StoredProcedure};

                var param = new SqlParameter("@DetStr", SqlDbType.Text) {Value = detStr};
                myCmd.Parameters.Add(param);

                myCmd.ExecuteNonQuery();
                myCmd.Dispose();
                myCon.Close();

                return "Status:Updated Sucessfully";
            }
            catch (SqlException ex)
            {
                return "Status:" + ex.Errors[0].Message;
            }
            return "Status : No Data to Upload";
        }
        #endregion

        #region INWARD ADD
        public string AddInw(InwardObject val)
        {
            if (val == null) return "Status: Nothing Received";
            if (val.InwardHdr.Count == 0 && val.InwardDet.Count == 0) return "Status : No Data to Upload";
           
            try
            {
                var doc = JsonConvert.DeserializeXmlNode(JsonConvert.SerializeObject(val), "Root");
                var detStr = doc.InnerXml;

                var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
                var myCon = new SqlConnection(constr);
                myCon.Open();
                var myCmd = new SqlCommand("Api_InwardSP", myCon) { CommandType = CommandType.StoredProcedure };

                var param = new SqlParameter("@DetStr", SqlDbType.Text) { Value = detStr };
                myCmd.Parameters.Add(param);

                myCmd.ExecuteNonQuery();
                myCmd.Dispose();
                myCon.Close();

                return "Status:Updated Sucessfully";
            }
            catch (SqlException ex)
            {
                return "Status:" + ex.Errors[0].Message;
            }
        }
        #endregion

        //#region GET TRANSACTION DETAIL (UnWanted)
        ////qry_getpurchasedata,qry_getpurretdata,qry_getsalesdata,qry_getsalretdata,qry_getinwardData,qry_getoutwardData------> compId , date

        //#region GET PURCHASE
        //public string GetPur(int compid)
        //{
        //    var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
        //    var ds = new DataSet();
        //    using (var myCon = new SqlConnection(constr))
        //    {
        //        myCon.Open();
        //        var myCmd = new SqlCommand("qry_getpurchasedata", myCon) { CommandType = CommandType.StoredProcedure };
        //        var param = new SqlParameter("@Dt", SqlDbType.DateTime) { Value = DateTime.Now.ToString("dd-MMM-yyyy") };
        //        myCmd.Parameters.Add(param);
        //        param = new SqlParameter("@CompId", SqlDbType.TinyInt) { Value = compid };
        //        myCmd.Parameters.Add(param);

        //        var myAdapt = new SqlDataAdapter { SelectCommand = myCmd };
        //        myAdapt.Fill(ds);
        //        ds.Tables[0].TableName = "PurHdr";
        //        ds.Tables[1].TableName = "PurDet";
        //        ds.Tables[2].TableName = "PurPostDet";

        //        myAdapt.Dispose();
        //        myCmd.Dispose();
        //        myCon.Close();
        //    }
        //    var str = JsonConvert.SerializeObject(ds);
        //    return str;
        //}
        //#endregion

        //#region GET PURCHASE RETURN
        //public string GetPurRet(int compid)
        //{
        //    var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
        //    var ds = new DataSet();
        //    using (var myCon = new SqlConnection(constr))
        //    {
        //        myCon.Open();
        //        var myCmd = new SqlCommand("qry_getpurretdata", myCon) { CommandType = CommandType.StoredProcedure };
        //        var param = new SqlParameter("@Dt", SqlDbType.DateTime) { Value = DateTime.Now.ToString("dd-MMM-yyyy") };
        //        myCmd.Parameters.Add(param);
        //        param = new SqlParameter("@CompId", SqlDbType.TinyInt) { Value = compid };
        //        myCmd.Parameters.Add(param);

        //        var myAdapt = new SqlDataAdapter { SelectCommand = myCmd };
        //        myAdapt.Fill(ds);
        //        ds.Tables[0].TableName = "PurHdr";
        //        ds.Tables[1].TableName = "PurDet";
        //        ds.Tables[2].TableName = "PurPostDet";

        //        myAdapt.Dispose();
        //        myCmd.Dispose();
        //        myCon.Close();
        //    }
        //    var str = JsonConvert.SerializeObject(ds);
        //    return str;
        //}
        //#endregion

        //#region GET SALE
        //public string GetSal(int compid)
        //{
        //    var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
        //    var ds = new DataSet();
        //    using (var myCon = new SqlConnection(constr))
        //    {
        //        myCon.Open();
        //        var myCmd = new SqlCommand("qry_getsalesdata", myCon) { CommandType = CommandType.StoredProcedure };
        //        var param = new SqlParameter("@Dt", SqlDbType.DateTime) { Value = DateTime.Now.ToString("dd-MMM-yyyy") };
        //        myCmd.Parameters.Add(param);
        //        param = new SqlParameter("@CompId", SqlDbType.TinyInt) { Value = compid };
        //        myCmd.Parameters.Add(param);

        //        var myAdapt = new SqlDataAdapter { SelectCommand = myCmd };
        //        myAdapt.Fill(ds);
        //        ds.Tables[0].TableName = "SalHdr";
        //        ds.Tables[1].TableName = "SalDet";
        //        ds.Tables[2].TableName = "SalPostDet";

        //        myAdapt.Dispose();
        //        myCmd.Dispose();
        //        myCon.Close();
        //    }
        //    var str = JsonConvert.SerializeObject(ds);
        //    return str;
        //}
        //#endregion

        //#region GET SALE RETURN
        //public string GetSalRet(int compid)
        //{
        //    var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
        //    var ds = new DataSet();
        //    using (var myCon = new SqlConnection(constr))
        //    {
        //        myCon.Open();
        //        var myCmd = new SqlCommand("qry_getsalretdata", myCon) { CommandType = CommandType.StoredProcedure };
        //        var param = new SqlParameter("@Dt", SqlDbType.DateTime) { Value = DateTime.Now.ToString("dd-MMM-yyyy") };
        //        myCmd.Parameters.Add(param);
        //        param = new SqlParameter("@CompId", SqlDbType.TinyInt) { Value = compid };
        //        myCmd.Parameters.Add(param);

        //        var myAdapt = new SqlDataAdapter { SelectCommand = myCmd };
        //        myAdapt.Fill(ds);
        //        ds.Tables[0].TableName = "SalRetHdr";
        //        ds.Tables[1].TableName = "SalRetDet";
        //        ds.Tables[2].TableName = "SalRetPostDet";

        //        myAdapt.Dispose();
        //        myCmd.Dispose();
        //        myCon.Close();
        //    }
        //    var str = JsonConvert.SerializeObject(ds);
        //    return str;
        //}
        //#endregion

        //#region GET OUTWARD
        //public string GetOut(int compid)
        //{
        //    var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
        //    var ds = new DataSet();
        //    using (var myCon = new SqlConnection(constr))
        //    {
        //        myCon.Open();
        //        var myCmd = new SqlCommand("qry_getoutwardData", myCon) { CommandType = CommandType.StoredProcedure };
        //        var param = new SqlParameter("@Dt", SqlDbType.DateTime) { Value = DateTime.Now.ToString("dd-MMM-yyyy") };
        //        myCmd.Parameters.Add(param);
        //        param = new SqlParameter("@CompId", SqlDbType.TinyInt) { Value = compid };
        //        myCmd.Parameters.Add(param);

        //        var myAdapt = new SqlDataAdapter { SelectCommand = myCmd };
        //        myAdapt.Fill(ds);
        //        ds.Tables[0].TableName = "OutwardHdr";
        //        ds.Tables[1].TableName = "OutwardDet";

        //        myAdapt.Dispose();
        //        myCmd.Dispose();
        //        myCon.Close();
        //    }
        //    var str = JsonConvert.SerializeObject(ds);
        //    return str;
        //}
        //#endregion

        //#region GET INWARD

        //public string GetInw(int compid)
        //{
        //    var constr = ConfigurationManager.ConnectionStrings["SQLConnection"].ToString();
        //    var ds = new DataSet();
        //    using (var myCon = new SqlConnection(constr))
        //    {
        //        myCon.Open();
        //        var myCmd = new SqlCommand("qry_getinwardData", myCon) { CommandType = CommandType.StoredProcedure };
        //        var param = new SqlParameter("@Dt", SqlDbType.DateTime) { Value = DateTime.Now.ToString("dd-MMM-yyyy") };
        //        myCmd.Parameters.Add(param);
        //        param = new SqlParameter("@CompId", SqlDbType.TinyInt) { Value = compid };
        //        myCmd.Parameters.Add(param);

        //        var myAdapt = new SqlDataAdapter { SelectCommand = myCmd };
        //        myAdapt.Fill(ds);
        //        ds.Tables[0].TableName = "OutwardHdr";
        //        ds.Tables[1].TableName = "OutwardDet";

        //        myAdapt.Dispose();
        //        myCmd.Dispose();
        //        myCon.Close();
        //    }
        //    var str = JsonConvert.SerializeObject(ds);
        //    return str;
        //}
        //#endregion

        //#endregion
    }
}
