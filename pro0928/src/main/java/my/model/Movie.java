package my.model;

import java.util.Date;

public class Movie {
	private int movieId;
	private String title;
	private String maker;
	private int price;
	private Date openDate;
	private String poster;
	private int freq;
	
	public Movie() {} //기본생성자

	public Movie(String title, String maker, int price, Date openDate, String poster, int freq) {
		super();
		this.title = title;
		this.maker = maker;
		this.price = price;
		this.openDate = openDate;
		this.poster = poster;
		this.freq = freq;
	}
	
	public int getFreq() {
		return freq;
	}

	public void setFreq(int freq) {
		this.freq = freq;
	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Date getOpenDate() {
		return openDate;
	}

	public void setOpenDate(Date openDate) {
		this.openDate = openDate;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}
	
	

}
