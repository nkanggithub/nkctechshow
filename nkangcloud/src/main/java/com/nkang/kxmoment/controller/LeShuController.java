package com.nkang.kxmoment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/LeShu")
public class LeShuController {
	

	@RequestMapping("/listenNumber")
	public String listenNumber(HttpServletRequest request, HttpServletResponse response){
		return "ListenNumber";
	}
	@RequestMapping("/showNumber")
	public String showNumber(HttpServletRequest request, HttpServletResponse response){
		return "ShowNumber";
	}
}
