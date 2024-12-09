package com.DAO;

import java.util.List;

import com.entity.AddBook;
import com.entity.Order;

public interface AdminDAO {
	boolean addBook(AddBook addBook);
	
	public List<AddBook>getAllBook();

	

	public List<Order>getAllOrder();
}
