package com.nkang.kxmoment.baseobject.classhourrecord;
/*
 * - 学员基本信息
 * - 总课时:75
- 已经消费课时:30
- 剩余购买课时:22
- 剩余赠与课时:3
- 课时缴费记录
- 课时消费记录
 */
public class Classrecord {
	public StudentBasicInformation studentBasicInformation;
	public Classpayrecord classpayrecord;
	public Classexpenserecord classexpenserecord;
	public int totalClass;
	public int expenseClass;
	public int leftPayClass;
	public int leftSendClass;
	public String studentOpenID;
	
	public StudentBasicInformation getStudentBasicInformation() {
		return studentBasicInformation;
	}
	public void setStudentBasicInformation(
			StudentBasicInformation studentBasicInformation) {
		this.studentBasicInformation = studentBasicInformation;
	}
	public Classpayrecord getClasspayrecord() {
		return classpayrecord;
	}
	public void setClasspayrecord(Classpayrecord classpayrecord) {
		this.classpayrecord = classpayrecord;
	}
	public Classexpenserecord getClassexpenserecord() {
		return classexpenserecord;
	}
	public void setClassexpenserecord(Classexpenserecord classexpenserecord) {
		this.classexpenserecord = classexpenserecord;
	}
	public int getTotalClass() {
		return totalClass;
	}
	public void setTotalClass(int totalClass) {
		this.totalClass = totalClass;
	}
	public int getExpenseClass() {
		return expenseClass;
	}
	public void setExpenseClass(int expenseClass) {
		this.expenseClass = expenseClass;
	}
	public int getLeftPayClass() {
		return leftPayClass;
	}
	public void setLeftPayClass(int leftPayClass) {
		this.leftPayClass = leftPayClass;
	}
	public int getLeftSendClass() {
		return leftSendClass;
	}
	public void setLeftSendClass(int leftSendClass) {
		this.leftSendClass = leftSendClass;
	}
	public String getStudentOpenID() {
		return studentOpenID;
	}
	public void setStudentOpenID(String studentOpenID) {
		this.studentOpenID = studentOpenID;
	}
	
	
}
