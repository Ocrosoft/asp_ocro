using Data_Access_Layer;
using Models;
using System.Collections.Generic;
using System.Data;

namespace Business_Logic_Layer
{
    public class BLL_Student
    {
        /// <summary>
        /// 学生注册
        /// </summary>
        /// <param name="student">要注册的学生信息</param>
        /// <returns></returns>
        public static bool register(Student student)
        {
            return DAL_Student.insertStudent(student);
        }
        public static bool deleteByID(int ID)
        {
            return DAL_Student.deleteStudentByID(ID.ToString());
        }
        /// <summary>
        /// 学生登录
        /// </summary>
        /// <param name="username">用户名</param>
        /// <param name="password">密码</param>
        /// <returns></returns>
        public static bool login(string username, string password)
        {
            return DAL_Student.studentExits(username, password);
        }
        /// <summary>
        /// 修改学生信息，密码为空则不修改密码，不允许修改注册时间和注册IP
        /// </summary>
        /// <param name="student">修改后的学生信息</param>
        /// <returns></returns>
        public static bool modify(Student student)
        {
            return DAL_Student.modifyStudent(student);
        }
        public static bool modify(string username, string sex, string grade, string age, string major, int ID)
        {
            Student student = new Student(username, "", sex, grade, age, major, "", "");
            return DAL_Student.modifyStudent(student);
        }
        /// <summary>
        /// 查询学生信息
        /// </summary>
        /// <param name="username">学生学号</param>
        /// <returns>除密码、IP、注册时间外的所有学生信息</returns>
        public static Student query(string username)
        {
            return DAL_Student.queryStudent(username);
        }
        /// <summary>
        /// 查询所有学生信息。
        /// </summary>
        /// <returns>DataSet</returns>
        public static DataSet qeruyAllStudent()
        {
            return DAL_Student.queryAllStudent();
        }
    }
}