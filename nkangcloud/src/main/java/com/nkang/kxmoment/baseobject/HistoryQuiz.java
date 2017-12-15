package com.nkang.kxmoment.baseobject;

public class HistoryQuiz {
	public String openID;
	public String category;
	public String batchId;
	public String questionSequence;
	public String wrongIndex;
	public String getWrongIndex() {
		return wrongIndex;
	}
	public void setWrongIndex(String wrongIndex) {
		this.wrongIndex = wrongIndex;
	}
	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	public String getQuestionSequence() {
		return questionSequence;
	}
	public void setQuestionSequence(String questionSequence) {
		this.questionSequence = questionSequence;
	}
	public String answers;
	public String getAnswers() {
		return answers;
	}
	public void setAnswers(String answers) {
		this.answers = answers;
	}
	public String getOpenID() {
		return openID;
	}
	public void setOpenID(String openID) {
		this.openID = openID;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	
}
