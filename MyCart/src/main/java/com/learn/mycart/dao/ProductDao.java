package com.learn.mycart.dao;

import java.util.List;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.learn.mycart.entities.Product;

public class ProductDao {
	private SessionFactory factory;
	
	public ProductDao(SessionFactory factory) {
		this.factory=factory;
	}
	
	public int saveProduct(Product product) {
		Session session=factory.openSession();
		Transaction tx=session.beginTransaction();
		
		int productId=(Integer) session.save(product);
		
		tx.commit();
		session.close();
		
		return productId;
	}
	
	public List<Product> getAllProducts(){
		Session session=this.factory.openSession();
		System.out.println("In get all product");
		Query query=session.createQuery("from Product");
		List<Product> products=query.list();
		
		return products;
		
	}
	
	public List<Product> getProductsByCatId(int catId){
		Session session=this.factory.openSession();
		System.out.println("In get all product by category id");
		Query query=session.createQuery("from Product as p where p.category.categoryId =: id");
		query.setParameter("id", catId);
		List<Product> products=query.list();
		
		return products;
	}
}
