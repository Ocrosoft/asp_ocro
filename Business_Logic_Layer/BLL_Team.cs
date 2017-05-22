using Data_Access_Layer;
using Models;
using System.Data;

namespace Business_Logic_Layer
{
    public class BLL_Team
    {
        public static  DataSet queryAllTeam()
        {
            return DAL_Team.queryAllTeam();
        }
        public static bool deleteTeamByID(string id)
        {
            return DAL_Team.deleteTeamByID(id);
        }
        public static bool modifyTeam(Team team)
        {
            return DAL_Team.modifyTeam(team);
        }
        public static string queryJoinStatus(string teamID,string stuID,bool returnExists=false)
        {
            string ret = DAL_Team.queryJoinStatus(teamID, stuID);
            if (ret.IndexOf('*') != -1) { if (returnExists) return ret; else return "未加入"; }
            return ret;
        }
        public static bool joinTeam(string teamID, string stuID)
        {
            if (queryJoinStatus(teamID, stuID, true).IndexOf('*') != -1) return DAL_Team.joinTeam(teamID, stuID);
            else return DAL_Team.joinTeam(teamID, stuID, true);
        }
        public static DataSet queryMember(string TeamID)
        {
            return DAL_Team.queryMember(TeamID);
        }
    }
}