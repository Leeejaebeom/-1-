package com.jmt.demo.model;

import lombok.Data;

@Data
public class Page {

	private int startPage;
	private int endPage;
	private int currentPage;
	private int firstPage;
	private int lastPage;
	private int amount;
	private int firstPost;
	private int lastPost;
	private boolean prev;
	private boolean next;
	
	public Page(int currentPage ,int total) {
		this.currentPage = currentPage;
		this.amount = 10;
		this.firstPage = 1;
		this.lastPage = (int) Math.ceil((double)total/amount);
		this.endPage = (total/amount) +(int) Math.ceil((double)total%amount);
		this.startPage =(int)(Math.ceil((double)(((currentPage-1)/amount))*amount)+1);
		this.lastPost = currentPage*amount-1;
		this.firstPost = lastPost-(amount-1);
		
		if(this.endPage > startPage+9) {
			this.endPage = startPage+9;
		}
		
		if(endPage>lastPage) {
			this.endPage = this.lastPage;
		}
		
		this.prev = this.currentPage > 1;
		this.next = this.currentPage < lastPage;
	}
	
}