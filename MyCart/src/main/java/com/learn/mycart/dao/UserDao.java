package com.learn.mycart.dao;

import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;

public class UserDao {
	private SessionFactory sessionFactory = FactoryProvider.getFactory();
	
	public UserDao(SessionFactory sessionFactory) {
		this.sessionFactory=sessionFactory;
	}
	
	public User getUserByEmailAndPassword(String email, String password) {
		User user=null;
		 try {
			 String query="from User where userEmail=:e and userPassword=:p";
			 Session session=this.sessionFactory.openSession();
			 
//			 NativeQuery<?> q=session.createNativeQuery(query);
			 Query q=session.createQuery(query);
			 q.setParameter("e", email);
			 q.setParameter("p", password);
			 user=(User)q.uniqueResult();
			 
			 session.close();
		 }
		 catch(Exception e) {
			 System.out.println("Exception...");
			 e.printStackTrace();
		 }
		
		
		return user;
	}
}
