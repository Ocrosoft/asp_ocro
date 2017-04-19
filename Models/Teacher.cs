namespace Models
{
    public class Teacher
    {
        public string username { get; set; }
        public string password { get; set; }
        public string sex { get; set; }
        public string age { get; set; }

        public Teacher(string username,string password,string sex,string age)
        {
            this.username = username;
            this.password = password;
            this.sex = sex;
            this.age = age;
        }
    }
}