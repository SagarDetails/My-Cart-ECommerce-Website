package com.learn.mycart.helper;

import org.hibernate.query.Query;

import java.util.HashMap;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class Helper {
	public static String get10Words(String description) {
		String []str=description.split(" ");
		String tempString="";
		if(str.length>10) {
			for(int i=0;i<10;i++) {
				tempString=tempString+str[i]+" ";
			}
			return (tempString+"...");
		}else {
			return description;
		}
	}
	
	public static Map<String, Long> getCounts(SessionFactory factory) {
		Session session=factory.openSession();
		
		String q1="select count(*) from User";
		String q2="select count(*) from Product";
		
		Query query1=session.createQuery(q1);
		Query query2=session.createQuery(q2);
		
		Long userCount=(Long)query1.list().get(0);
		Long productCount=(Long)query2.list().get(0);
		
		Map<String, Long> map=new HashMap();
		map.put("userCount", userCount);
		map.put("productCount", productCount);
		
		session.close();
		return map;
	}
}
