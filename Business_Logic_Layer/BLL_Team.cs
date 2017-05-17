using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Data_Access_Layer;

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
    }
}