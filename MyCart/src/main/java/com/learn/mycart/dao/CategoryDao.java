package com.learn.mycart.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.learn.mycart.entities.Category;

public class CategoryDao {
	SessionFactory factory;
	public CategoryDao(SessionFactory factory) {
		this.factory=factory;
	}
	
	public int saveCategory(Category cat) {
		Session session=factory.openSession();
		Transaction tx=session.beginTransaction();
		int catId=(Integer) session.save(cat);
		tx.commit();
		session.close();
		
		return catId;
	}
	
	public List<Category> getCategories(){
		Session session=this.factory.openSession();
		Query query=session.createQuery("from Category");
		List<Category> list=query.list();
		
		return list;
	}
	
	public Category getCategoryById(int catId) {
		Category category=null;
		try {
			Session session=factory.openSession();
			category=session.get(Category.class, catId);
			session.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return category;
	}
	
	public List<Category> getAllCategories(){
		Session session=this.factory.openSession();
		
		Query query=session.createQuery("from Category");
		List<Category> categories=query.list();
		
		return categories;
	}
	
}
