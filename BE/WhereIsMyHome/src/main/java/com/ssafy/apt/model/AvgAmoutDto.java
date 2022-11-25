package com.ssafy.apt.model;

public class AvgAmoutDto {
	private String dealYear;
	private String dealMonth;
	private String avgAmount;

	public String getDealMonth() {
		return dealMonth;
	}

	public void setDealMonth(String dealMonth) {
		this.dealMonth = dealMonth;
	}

	public void setAvgAmount(String avgAmount) {
		this.avgAmount = avgAmount;
	}

	public String getDealYear() {
		return dealYear;
	}

	public void setDealYear(String dealYear) {
		this.dealYear = dealYear;
	}

	public String getAvgAmount() {
		return avgAmount;
	}

	public void setAvgAmout(String avgAmount) {
		this.avgAmount = avgAmount;
	}

}
