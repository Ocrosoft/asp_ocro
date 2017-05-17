namespace Models
{
    public class Team
    {
        public string TeamID { get; set; }
        public string TeaID { get; set; }
        public string AuditMode { get; set; }
        public string ScoreType { get; set; }
        public string ExcelRatio { get; set; }
        public string AnswerStatus { get; set; }
        public string CourceName { get; set; }
        public string CourceTerm { get; set; }
        public string StuClass { get; set; }
        public string InsDateTime { get; set; }
        public string Introduce { get; set; }
        public string Comment { get; set; }

        public Team(string teamID,string teaID,string auditMode,string scoreType,string excelRatio,string answerStatus,string courceName,string courceTerm,string stuClass,string insDateTime,string introduce,string comment)
        {
            TeamID = teamID;
            TeaID = teaID;
            AuditMode = auditMode;
            ScoreType = scoreType;
            ExcelRatio = excelRatio;
            AnswerStatus = answerStatus;
            CourceName = courceName;
            CourceTerm = courceTerm;
            StuClass = stuClass;
            InsDateTime = insDateTime;
            Introduce = introduce;
            Comment = comment;
        }
    }
}