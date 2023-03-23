package com.learn.mycart.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.learn.mycart.entities.User;

public class FactoryProvider {
	private static SessionFactory factory;
	public static SessionFactory getFactory() {
		try {
			
			if(factory == null) {
				Configuration con=new Configuration().configure().addAnnotatedClass(User.class);
				factory=con.buildSessionFactory();
			}
			
		}catch(Exception ex) {
			System.out.println(ex);
		}
		
		return factory;
	}
}
