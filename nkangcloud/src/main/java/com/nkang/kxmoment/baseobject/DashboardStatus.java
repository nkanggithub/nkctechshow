package com.nkang.kxmoment.baseobject;

import com.google.gson.Gson;

/**
 * MDM DashBoard Status
 * @author DXK
 *
 */
public class DashboardStatus {
public static Gson gson = new Gson();
	
	private String type;
	private Object status;
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Object getStatus() {
		return status;
	}
	public void setStatus(Object status) {
		this.status = status;
	}
	

	@Override
	public String toString() {
		return gson.toJson(this);
	}
}
