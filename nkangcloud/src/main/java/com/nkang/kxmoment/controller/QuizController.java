package com.nkang.kxmoment.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nkang.kxmoment.baseobject.Quiz;
import com.nkang.kxmoment.util.MongoDBBasic;


@Controller
public class QuizController {

	@RequestMapping("/getQuizsByType")
	public @ResponseBody List<Quiz> getQuizsByType(@RequestParam(value="type")String type){
		List<Quiz> quizs=MongoDBBasic.getQuizsByType(type);
		return quizs;
	}
}
