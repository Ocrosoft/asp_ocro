using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace Data_Access_Layer
{
    public class DAL_Team
    {
        public static DataSet queryAllTeam()
        {
            DataSet ds = null;
            try
            {
                string sql = "select * from team;";
                ds = DAL_MysqlHelper.ExecuteDataTable(sql);
            }
            catch
            {

            }
            return ds;
        }
    }
}