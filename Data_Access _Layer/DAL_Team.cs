using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using Models;

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
        public static bool modifyTeam(Team team)
        {
            try
            {
                string sql = "update team set AuditMode=?0,ScoreType=?1,AnswerStatus=?3,CourceName=?4,CourceTerm=?5,StuClass=?6,ScoreType=?7,Introduce=?8 where TeamID=?9";
                MySqlParameter[] para = new MySqlParameter[9];
                para[0] = new MySqlParameter("?0", team.AuditMode);
                para[1] = new MySqlParameter("?1", team.ScoreType);
                para[2] = new MySqlParameter("?3", team.AnswerStatus);
                para[3] = new MySqlParameter("?4", team.CourceName);
                para[4] = new MySqlParameter("?5", team.CourceTerm);
                para[5] = new MySqlParameter("?6", team.StuClass);
                para[6] = new MySqlParameter("?7", team.ScoreType);
                para[7] = new MySqlParameter("?8", team.Introduce);
                para[8] = new MySqlParameter("?9", team.TeamID);
                int ret = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                if (ret >= 1) return true;
                else return false;
            }
            catch (Exception e)
            {
                return false;
            }
        }
        public static string queryJoinStatus(string teamID, string stuID)
        {
            try
            {
                string sql = "select AuditStatus from team_member where TeamID=?0 and StuID=?1";
                MySqlParameter[] para = { new MySqlParameter("?0", teamID), new MySqlParameter("?1", stuID) };
                DataSet ds = DAL_MysqlHelper.ExecuteDataTable(sql, para);
                if (ds.Tables[0].Rows.Count == 0) return "未加入*";
                else return ds.Tables[0].Rows[0].ItemArray[0].ToString();
            }
            catch (Exception e)
            {
                return "ERROR";
            }
        }
        public static bool joinTeam(string teamID, string stuID, bool update = false)
        {
            string sql = "";
            MySqlParameter[] para = new MySqlParameter[2];
            try
            {
                if (!update)
                {
                    sql = "insert into team_member values(?0,?1,'已加入')";
                }
                else
                {
                    sql = "update team_member set(AuditStatus,'已加入') where TeamID=?0 and StuID=?1";
                }
                para[0] = new MySqlParameter("?0", teamID);
                para[1] = new MySqlParameter("?1", stuID);
                int ret = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                if (ret >= 1) return true;
                else return false;
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }
}