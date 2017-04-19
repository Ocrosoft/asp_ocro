using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Data_Access_Layer
{
    public class DAL_DataViewer
    {
        public static DataTable QueryAQI()
        {
            string sql = "select recordDate,areaName,value from aqi where recordDate='2013-01-01';";
            DataTable table = DAL_MysqlHelper.ExecuteDataTable(sql);
            return table;
        }
    }
}