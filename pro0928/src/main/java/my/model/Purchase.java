package my.model;

import java.util.Date;

public class Purchase {
	private int pid;
	private String customer;
	private int movieId;
	private int amount;
	private int total;
	private Date pdate;
	
	public Purchase() {}
	
	public Purchase(String customer, int movieId, int amount, int total, Date pdate) {
		super();
		this.customer = customer;
		this.movieId = movieId;
		this.amount = amount;
		this.total = total;
		this.pdate = pdate;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public int getmovieId() {
		return movieId;
	}

	public void setmovieId(int movieId) {
		this.movieId = movieId;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Date getPdate() {
		return pdate;
	}

	public void setPdate(Date pdate) {
		this.pdate = pdate;
	} 
	
	
	

}
