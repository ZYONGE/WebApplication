package my.model;

import java.util.Date;

public class Book {
	private int bookId; 
	private String bookName;
	private String author;
	private int price;
	private Date publishDate;
	private String bookImage;
	
	public Book() {}
	
	public Book(int bookId, String bookName, String author, int price, Date publishDate, String bookImage) {
		super();
		this.bookId = bookId;
		this.bookName = bookName;
		this.author = author;
		this.price = price;
		this.publishDate = publishDate;
		this.bookImage = bookImage;
	}



	public String getBookImage() {
		return bookImage;
	}
	public void setBookImage(String bookImage) {
		this.bookImage = bookImage;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	} 
	
	

}
