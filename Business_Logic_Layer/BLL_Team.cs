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
    }
}