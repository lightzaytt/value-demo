<%@ WebHandler Language="C#" Class="counter" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
using System.Web.Configuration;
using System.Data;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Globalization;

public class counter : IHttpHandler {
  CultureInfo cultureInfo = new CultureInfo("zh-TW");
  HttpContext ct;
  string wMsg = "0";
  string wFno = "";

  public void ProcessRequest (HttpContext context) {
    ct = context;
    // 防止頁面緩存
    ct.Response.ClearContent();
    ct.Response.Cache.SetNoStore();
    ct.Response.CacheControl = "no-cache";
    ct.Response.ContentType = "text/plain";

    if (ct.Request["F"] != null)
    {
      wFno = ct.Request["F"].ToString().ToUpper();
      if (wFno.Length==1 && "12345678".IndexOf(wFno)!=-1)
      {
        try
        {
          string fname = ""; // 檔名
          string str1 = "";
          int wCounter = 0;
          // 取出 原有 值
          fname = ct.Server.MapPath(string.Format("~/upload/f{0}.txt", wFno));
          if (File.Exists(fname))
          {
            using (StreamReader sr1 = new StreamReader(fname))
            {
              if (!sr1.EndOfStream)
              {
                str1 = sr1.ReadLine();
                Int32.TryParse(str1, out wCounter);
              }
            }
          }
          // 加 1
          wCounter++;
          // 寫入
          using (StreamWriter sw1 = new StreamWriter(fname))
          {
            sw1.WriteLine(wCounter.ToString());
          }
          wMsg = wCounter.ToString();
        }
        catch (Exception err)
        {

        }
      }
    }
    ct.Response.Write(wMsg);
    ct.Response.Flush();
    ct.Response.End();
  }

  public bool IsReusable {
    get {
      return false;
    }
  }

}