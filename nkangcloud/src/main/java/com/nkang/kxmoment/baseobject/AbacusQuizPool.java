package com.nkang.kxmoment.baseobject;

import java.util.List;

public class AbacusQuizPool {
	public String id;
	public String category;
	public List<String> tag;
	public String checkpoint;
	public List<String> question;
	public int answer;
	public String grade;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}

	public List<String> getTag() {
		return tag;
	}
	public void setTag(List<String> tag) {
		this.tag = tag;
	}
	public String getCheckpoint() {
		return checkpoint;
	}
	public void setCheckpoint(String checkpoint) {
		this.checkpoint = checkpoint;
	}
	
	public List<String> getQuestion() {
		return question;
	}
	public void setQuestion(List<String> question) {
		this.question = question;
	}
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
}
