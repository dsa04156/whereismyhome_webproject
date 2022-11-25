package com.ssafy.qna.model;

public class QnaDTO {
	private int qnaNo;
	private String id;
	private String subject;
	private String content;
	private String regTime;
	private boolean state;
	private String answer;
	private String adRegTime;

	public String getAdRegTime() {
		return adRegTime;
	}

	public void setAdRegTime(String adRegTime) {
		this.adRegTime = adRegTime;
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public boolean isState() {
		return state;
	}

	public void setState(boolean state) {
		this.state = state;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

}