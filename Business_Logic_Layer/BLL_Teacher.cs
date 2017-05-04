using Models;
using Data_Access_Layer;

namespace Business_Logic_Layer
{
    public class BLL_Teacher
    {
        public static bool register(Teacher teacher)
        {
            return DAL_Teacher.insertTeacher(teacher);
        }

        public static bool login(string username,string password)
        {
            return DAL_Teacher.teacherExits(username, password);
        }

        public static bool modify(Teacher teacher)
        {
            return DAL_Teacher.modifyTeacher(teacher);
        }

        public static Teacher query(string username)
        {
            return DAL_Teacher.queryTeacher(username);
        }

        public static Teacher queryAll()
        {

        }
    }
}