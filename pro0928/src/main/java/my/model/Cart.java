package my.model;

public class Cart {
	private String customer;
	private int movieId;
	private int amount;
	
	public Cart(String customer, int movieId, int amount) {
		super();
		this.customer = customer;
		this.movieId = movieId;
		this.amount = amount;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
	
	
	
}
