package com.nkang.kxmoment.baseobject;

import java.util.List;

public class Quiz {

	public String type;
	public String score;
	public String question;
	public String correctAnswers;
	public String category;
	public String caseStudy;
	public List<String> answers;
	public String checkPoint;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getCorrectAnswers() {
		return correctAnswers;
	}
	public void setCorrectAnswers(String correctAnswers) {
		this.correctAnswers = correctAnswers;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCaseStudy() {
		return caseStudy;
	}
	public void setCaseStudy(String caseStudy) {
		this.caseStudy = caseStudy;
	}
	public List<String> getAnswers() {
		return answers;
	}
	public void setAnswers(List<String> answers) {
		this.answers = answers;
	}
	public String getCheckPoint() {
		return checkPoint;
	}
	public void setCheckPoint(String checkPoint) {
		this.checkPoint = checkPoint;
	}
}
