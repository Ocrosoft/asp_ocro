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
                string sql = "select team.*,teacher.TeaName from teacher inner join team on teacher.username=team.TeaID";
                ds = DAL_MysqlHelper.ExecuteDataTable(sql);
            }
            catch (Exception e)
            {

            }
            return ds;
        }

        public static bool deleteTeamByID(string id)
        {
            try
            {
                string sql = "delete from team where TeamID=?1";
                MySqlParameter para = new MySqlParameter("?1", id);
                int ret = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                if (ret >= 1) return true;
                else return false;
            }
            catch
            {
                return false;
            }
        }
    }
}