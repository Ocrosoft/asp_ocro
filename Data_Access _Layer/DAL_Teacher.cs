using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Models;
using MySql.Data.MySqlClient;
using System.Data;

namespace Data_Access_Layer
{
    public class DAL_Teacher
    {
        /// <summary>
        /// 添加一个教师用户。
        /// </summary>
        /// <param name="teacher">教师实体信息</param>
        /// <returns></returns>
        public static bool insertTeacher(Teacher teacher)
        {
            try
            {
                string sql = "insert into teacher(username, password, sex, age) values(?0,?1,?2,?3);";
                MySqlParameter[] para = new MySqlParameter[4];
                para[0] = new MySqlParameter("?0", teacher.username);
                para[1] = new MySqlParameter("?1", teacher.password);
                para[2] = new MySqlParameter("?2", teacher.sex);
                para[3] = new MySqlParameter("?3", teacher.age);
                int res = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                if (res > 0) return true;
                else return false;
            }
            catch (Exception e)
            {
                LogWriter.writeLine(@"C:\WEB_ASP\logs\DAL.log", "insertTeacher:" + e.Message);
                return false;
            }
        }
        /// <summary>
        /// 根据ID删除一个教师。
        /// </summary>
        /// <param name="ID">要删除的教师ID</param>
        /// <returns></returns>
        public static bool deleteTeacherByID(string ID)
        {
            return false;
        }
        /// <summary>
        /// 根据用户名(工号)删除一个教室。
        /// </summary>
        /// <param name="number">用户名</param>
        /// <returns></returns>
        public static bool deleteTeacherByNumber(string number)
        {
            return false;
        }
        /// <summary>
        /// 修改教师信息。
        /// </summary>
        /// <param name="teacher">修改后的教师实体信息</param>
        /// <returns></returns>
        public static bool modifyTeacher(Teacher teacher)
        {
            string username = teacher.username;
            string password = teacher.password;
            if (password.Length != 0) password = DAL_Safety.getMD5(password);
            string age = teacher.age;
            string sex = teacher.sex;

            try
            {
                string sql = "";
                int res = 0;
                if (password.Length != 0)
                {
                    sql = "update teacher set password=?1, age=?2, sex=?3 where username=?4;";
                    MySqlParameter[] para = new MySqlParameter[4];
                    para[0] = new MySqlParameter("?1", password);
                    para[1] = new MySqlParameter("?2", age);
                    para[2] = new MySqlParameter("?3", username);
                    para[3] = new MySqlParameter("?4", username);
                    res = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                }
                else
                {
                    sql = "update teacher set  age=?1, sex=?2 where username=?3;";
                    MySqlParameter[] para = new MySqlParameter[3];
                    para[0] = new MySqlParameter("?1", age);
                    para[1] = new MySqlParameter("?2", sex);
                    para[2] = new MySqlParameter("?3", username);
                    res = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                }
                if (res > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception e)
            {
                LogWriter.writeLine("DAL.log", "modifyTeacher:" + e.Message);
                return false;
            }
        }
        /// <summary>
        /// 根据用户名查询教师。
        /// </summary>
        /// <param name="number">用户名</param>
        /// <returns></returns>
        public static Teacher queryTeacher(string number)
        {
            try
            {
                string sql = "select username,sex,age from teacher where username=?1;";
                MySqlParameter[] para = new MySqlParameter[1];
                para[0] = new MySqlParameter("?1", number);
                DataTable dataTable = DAL_MysqlHelper.ExecuteDataTable(sql, para).Tables[0];
                Teacher teacher = new Teacher("", "", "", "");
                if (dataTable != null)
                {
                    teacher.username = dataTable.Rows[0]["username"].ToString();
                    teacher.sex = dataTable.Rows[0]["sex"].ToString();
                    teacher.age = dataTable.Rows[0]["age"].ToString();
                }
                return teacher;
            }
            catch (Exception e)
            {
                LogWriter.writeLine(@"C:\WEB_ASP\logs\DAL.log", "queryTeacher:" + e.Message);
                return null;
            }
        }
        /// <summary>
        /// 判断教师用户是否存在。
        /// </summary>
        /// <param name="number">用户名</param>
        /// <param name="password">密码</param>
        /// <returns></returns>
        public static bool teacherExits(string number,string password)
        {
            password = DAL_Safety.getMD5(password);
            object obj = null;
            try
            {
                string sql = "select username from teacher where username=?1 and password=?2;";
                MySqlParameter[] para = new MySqlParameter[2];
                para[0] = new MySqlParameter("?1", number);
                para[1] = new MySqlParameter("?2", password);
                obj = DAL_MysqlHelper.ExecuteScalar(sql, para);
            }
            catch (Exception e)
            {
                LogWriter.writeLine(@"C:\WEB_ASP\logs\DAL.log", "studentExits:" + e.Message);
                return false;
            }
            if (Equals(obj, null)) return false;
            else return true;
        }
    }
}