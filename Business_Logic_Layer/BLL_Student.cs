using Data_Access_Layer;
using Models;
using System.Collections.Generic;

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
        public static bool deleteByID(string ID)
        {
            return DAL_Student.deleteStudentByID(ID);
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
        /// <returns>一个学生实体的List表。</returns>
        public static List<Student> queryAllStudent()
        {
            return DAL_Student.queryAllStudent();
        }
    }
}