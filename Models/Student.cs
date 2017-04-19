using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Models
{
    public class Student
    {
#region 变量
        // 用户名
        public string username { get; set; }
        // 密码
        public string password { get; set; }
        // 性别
        public string sex { set; get; }
        // 年级
        public string grade { set; get; }
        // 年龄
        public string age { set; get; }
        // 专业
        public string major { set; get; }
        // 注册IP地址
        public string IP { set; get; }
        // 注册时间
        public string regtime { set; get; }
        // 修改用ID
        public string id { set; get; }
#endregion

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="username">用户名</param>
        /// <param name="password">密码</param>
        /// <param name="sex">性别</param>
        /// <param name="grade">年级</param>
        /// <param name="age">年龄</param>
        /// <param name="major">专业</param>
        /// <param name="IP">注册IP地址</param>
        /// <param name="regtime">注册时间</param>
        public Student(string username,string password, string sex, string grade,string age,string major,string IP,string regtime)
        {
            this.username = username;
            this.password = password;
            this.sex = sex;
            this.grade = grade;
            this.age = age;
            this.major = major;
            this.IP = IP;
            this.regtime = regtime;
            this.id = "";
        }
    }
}