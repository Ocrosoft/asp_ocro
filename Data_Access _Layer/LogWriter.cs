using System;
using System.IO;

namespace Data_Access_Layer
{
    public class LogWriter
    {
        // 文件路径(绝对路径)
        public string filePath { get; set; }
        // 要写入的内容
        public string content { get; set; }
        LogWriter() { filePath = ""; content = ""; }
        LogWriter(string filePath) { this.filePath = filePath; content = ""; }
        LogWriter(string filePath, string content) { this.filePath = filePath; this.content = content; }
        /// <summary>
        /// 将content追加写入到filePath指向的文件中。适用于需要分次写入的大量内容。
        /// </summary>
        /// <returns></returns>
        public bool writeLine()
        {
            try
            {
                File.AppendAllText(filePath, content);
            }
            catch (Exception e)
            {
                return false;
            }
            return true;
        }
        /// <summary>
        /// 将content追加写入到filePath指向的文件中。适用于需要分次写入的少量内容。
        /// </summary>
        /// <param name="content"></param>
        /// <returns></returns>
        public bool writeLine(string content)
        {
            try
            {
                File.AppendAllText(filePath, content);
            }
            catch (Exception e)
            {
                return false;
            }
            return true;
        }
        /// <summary>
        /// 打开一个文件，将指定内容追加到该文件。如果该文件不存在，则先创建这个文件。
        /// </summary>
        /// <param name="filePath">文件路径</param>
        /// <param name="content">文件内容</param>
        /// <returns></returns>
        public static bool writeLine(string filePath, string content)
        {
            try
            {
                File.AppendAllText(filePath, content);
            }
            catch (Exception e)
            {
                return false;
            }
            return true;
        }
    }
}