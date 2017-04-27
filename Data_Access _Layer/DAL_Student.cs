using Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;

namespace Data_Access_Layer
{
    public class DAL_Student
    {
        /// <summary>
        /// 添加一个学生用户。
        /// </summary>
        /// <param name="student">学生实体信息</param>
        /// <returns></returns>
        public static bool insertStudent(Student student)
        {
            try
            {
                string sql = "insert into users(username, password, sex, grade, age, major, IP, regtime) values(?0,?1,?2,?3,?4,?5,?6,?7);";
                MySqlParameter[] para = new MySqlParameter[8];
                para[0] = new MySqlParameter("?0", student.username);
                para[1] = new MySqlParameter("?1", student.password);
                para[2] = new MySqlParameter("?2", student.sex);
                para[3] = new MySqlParameter("?3", student.grade);
                para[4] = new MySqlParameter("?4", student.age);
                para[5] = new MySqlParameter("?5", student.major);
                para[6] = new MySqlParameter("?6", student.IP);
                para[7] = new MySqlParameter("?7", student.regtime);
                int res = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                if (res > 0) return true;
                else return false;
            }
            catch (Exception e)
            {
                LogWriter.writeLine(@"C:\WEB_ASP\logs\DAL.log", "insertStudent:" + e.Message);
                return false;
            }
        }
        /// <summary>
        /// 根据ID删除一个学生。
        /// </summary>
        /// <param name="ID">要删除的学生ID</param>
        /// <returns></returns>
        public static bool deleteStudentByID(string ID)
        {
            string sql = "delete from users where id=?1";
            MySqlParameter[] para = new MySqlParameter[1];
            para[0] = new MySqlParameter("?1", ID);
            int res = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
            if (res > 0) return true;
            else return false;
        }
        /// <summary>
        /// 根据学号删除一个学生。
        /// </summary>
        /// <param name="number">要删除的学生学号</param>
        /// <returns></returns>
        public static bool deleteStudentByNumber(string number)
        {
            return false;
        }
        /// <summary>
        /// 修改一个学生信息（包括密码、年龄、年纪、性别、专业）。
        /// </summary>
        /// <param name="student">修改后的学生信息</param>
        /// <returns></returns>
        public static bool modifyStudent(Student student)
        {
            string username = student.username;
            string password = student.password;
            if (password.Length != 0) password = DAL_Safety.getMD5(password);
            string age = student.age;
            string grade = student.grade;
            string sex = student.sex;
            string major = student.major;

            try
            {
                string sql = "";
                int res = 0;
                if (password.Length != 0)
                {
                    sql = "update users set password=?1, grade=?2, age=?3, sex=?4, major=?5 where username=?6;";
                    MySqlParameter[] para = new MySqlParameter[6];
                    para[0] = new MySqlParameter("?1", password);
                    para[1] = new MySqlParameter("?2", grade);
                    para[2] = new MySqlParameter("?3", age);
                    para[3] = new MySqlParameter("?4", sex);
                    para[4] = new MySqlParameter("?5", major);
                    para[5] = new MySqlParameter("?6", username);
                    res = DAL_MysqlHelper.ExecuteNonQuery(sql, para);
                }
                else
                {
                    sql = "update users set grade=?1, age=?2, sex=?3, major=?4 where username=?5;";
                    MySqlParameter[] para = new MySqlParameter[5];
                    para[0] = new MySqlParameter("?1", grade);
                    para[1] = new MySqlParameter("?2", age);
                    para[2] = new MySqlParameter("?3", sex);
                    para[3] = new MySqlParameter("?4", major);
                    para[4] = new MySqlParameter("?5", username);
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
                LogWriter.writeLine("DAL.log", "modifyStudent:" + e.Message);
                return false;
            }
        }
        /// <summary>
        /// 根据学号查询学生。
        /// </summary>
        /// <param name="number">要查询的学生学号</param>
        /// <returns>除密码、IP、注册时间外的所有学生信息</returns>
        public static Student queryStudent(string number)
        {
            try
            {
                string sql = "select username,sex,grade,age,major from users where username=?1;";
                MySqlParameter[] para = new MySqlParameter[1];
                para[0] = new MySqlParameter("?1", number);
                DataTable dataTable = DAL_MysqlHelper.ExecuteDataTable(sql, para).Tables[0];
                Student student = new Student("", "", "", "", "", "", "", "");
                if (dataTable != null)
                {
                    student.username = dataTable.Rows[0]["username"].ToString();
                    student.sex = dataTable.Rows[0]["sex"].ToString();
                    student.age = dataTable.Rows[0]["age"].ToString();
                    student.grade = dataTable.Rows[0]["grade"].ToString();
                    student.major = dataTable.Rows[0]["major"].ToString();
                }
                return student;
            }
            catch (Exception e)
            {
                LogWriter.writeLine(@"C:\WEB_ASP\logs\DAL.log", "queryStudent:" + e.Message);
                return null;
            }

        }
        /// <summary>
        /// 判断学生是否存在。
        /// </summary>
        /// <param name="number">用户名</param>
        /// <param name="password">密码</param>
        /// <returns></returns>
        public static bool studentExits(string number, string password)
        {
            password = DAL_Safety.getMD5(password);
            object obj = null;
            try
            {
                string sql = "select username from users where username=?1 and password=?2;";
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
        /// <summary>
        /// 查询所有学生信息。
        /// </summary>
        /// <returns>一个学生实体的List表。</returns>
        public static List<Student> queryAllStudent()
        {
            string sql = "select username,sex,grade,age,major,IP,regtime,id from users;";
            DataTable table = DAL_MysqlHelper.ExecuteDataTable(sql).Tables[0];
            List<Student> list = new List<Student>();
            foreach (DataRow dr in table.Rows)
            {
                Student student = new Student("", "", "", "", "", "", "", "");
                student.username = dr[0].ToString();
                student.sex = dr[1].ToString();
                student.grade = dr[2].ToString();
                student.age = dr[3].ToString();
                student.major = dr[4].ToString();
                student.IP = dr[5].ToString();
                student.regtime = dr[6].ToString();
                student.id = dr[7].ToString();
                list.Add(student);
            }
            return list;
        }

        public static DataSet queryAllStudent_DataSet()
        {
            string sql = "select username,sex,grade,age,major,IP,regtime,id from users;";
            DataSet ds = DAL_MysqlHelper.ExecuteDataTable(sql);
            return ds;
        }
    }
}