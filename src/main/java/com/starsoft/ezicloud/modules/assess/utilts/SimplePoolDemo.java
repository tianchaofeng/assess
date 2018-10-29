package com.starsoft.ezicloud.modules.assess.utilts;

import java.util.LinkedList;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SimplePoolDemo {
	private  static String driver;
	private  static String url;
	private  static String user;
	private  static String password;
	private  static String initialSize;
	
    //创建一个连接池
    private static LinkedList<Connection> pool = new LinkedList<Connection>(); 
    
    //初始化10个连接
    
    
    public SimplePoolDemo() {
    	
    	
    	Properties pro = new Properties();
    	
    	InputStream inputStream = SimplePoolDemo.class.getClassLoader().getResourceAsStream("ezicloud.properties");
    	
    	try {
    		if (pool.size()==0) {
    			pro.load(inputStream);
    			driver = pro.getProperty("jdbc.driver");
    			url = pro.getProperty("jdbc.url");
    			user = pro.getProperty("jdbc.username");
    			password = pro.getProperty("jdbc.password");
    			initialSize = pro.getProperty("initialSize");
    			
    			Class.forName(driver);
    			
    			for (int i = 0; i < Integer.valueOf(initialSize); i++) {
    				Connection conn = DriverManager.getConnection(url, user, password);
    				pool.add(conn);
    			}
			}
    		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    
    //从池中获取一个连接
    public Connection getConnectionFromPool(){
    	if (pool.size()>0) {
    		Connection connection = pool.getFirst();
    		pool.removeFirst();//移除一个连接对象
    		System.out.println("SimplePoolDemo连接池取走一个连接,还剩下"+pool.size());
    		return connection;
		}else {
			throw new RuntimeException("SimplePoolDemo连接池连接达到上限，请等待！");
		}
        
    }
    //释放资源
    public static void release(Connection conn){
        pool.addLast(conn);
        System.out.println("释放连接！！现在SimplePoolDemo连接池中有"+pool.size()+"个连接！");
    }


}
