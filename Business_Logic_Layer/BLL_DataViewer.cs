using Data_Access_Layer;
using System.Data;

namespace Business_Logic_Layer
{
    public class BLL_DataViewer
    {
        public static DataTable QueryAQI()
        {
            return DAL_DataViewer.QueryAQI();
        }
    }
}