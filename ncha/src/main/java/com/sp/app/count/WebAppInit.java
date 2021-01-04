package com.sp.app.count;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class WebAppInit implements ServletContextListener{
   private String pathname="/WEB-INF/count.properties";
   
   @Override
   public void contextInitialized(ServletContextEvent sce) {
      pathname=sce.getServletContext().getRealPath(pathname);
      loadFile();
   }
   
   @Override
   public void contextDestroyed(ServletContextEvent sce) {
      saveFile();
   }

   private void saveFile() {
      long toDay, yesterDay, total;
      FileOutputStream fos=null;
      Properties p=new Properties();
      
      try {
         toDay=CountManager.getTodayCount();
         yesterDay=CountManager.getYesterDayCount();
         total=CountManager.getTotalCount();
         
         p.setProperty("toDay", Long.toString(toDay));
         p.setProperty("yesterDay", Long.toString(yesterDay));
         p.setProperty("total", Long.toString(total));
         
         fos=new FileOutputStream(pathname);
         p.store(fos, "count");
         
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if(fos!=null) {
            try {
               fos.close();
            } catch (Exception e2) {
            }
         }
      }
   }
   
   private void loadFile() {
      long toDay=0, yesterDay=0, total=0;
      FileInputStream fis=null;
      Properties p=null;
      
      try {
         File f=new File(pathname);
         if(! f.exists()) {
            return;
         }
         
         p=new Properties();
         fis=new FileInputStream(f);
         p.load(fis);
         
         toDay=Long.parseLong(p.getProperty("toDay"));
         yesterDay=Long.parseLong(p.getProperty("yesterDay"));
         total=Long.parseLong(p.getProperty("total"));
         
         CountManager.init(toDay, yesterDay, total);
         
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if(fis!=null) {
            try {
               fis.close();
            } catch (Exception e2) {
            }
         }
      }
   }
}