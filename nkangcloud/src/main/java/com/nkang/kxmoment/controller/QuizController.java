package com.nkang.kxmoment.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.StringUtils;
import com.nkang.kxmoment.baseobject.AbacusQuizPool;
import com.nkang.kxmoment.baseobject.Quiz;
import com.nkang.kxmoment.baseobject.WeChatMDLUser;
import com.nkang.kxmoment.util.MongoDBBasic;


@Controller
@RequestMapping("/AbacusQuiz")
public class QuizController {

	@RequestMapping("/getQuizsByType")
	public @ResponseBody List<Quiz> getQuizsByType(@RequestParam(value="type")String type){
		List<Quiz> quizs=MongoDBBasic.getQuizsByType(type);
		return quizs;
	}
	
	
	@RequestMapping("/setAbacusQuizPool")
	public @ResponseBody List<String> AbacusQuizPool(@RequestParam(value="type")String type){
		AbacusQuizPool aq = new AbacusQuizPool();
		List<String> tag = new ArrayList();
		List<String> questions = new ArrayList();
		questions.add("22");
		questions.add("14");
		questions.add("9");
		questions.add("36");
		questions.add("54");
		tag.add("wefd");
		tag.add("sdfwe");
			aq.setAnswer(123);
			aq.setCategory("测试categories");
			aq.setCheckpoint("aa和bb");
			aq.setGrade("高级");
			aq.setId("a003");
			aq.setQuestion(questions);
			aq.setTag(tag);
		boolean quizs=MongoDBBasic.createAbacusQuizPool(aq);
		return tag;
	}
	
	@RequestMapping("/addAbacusQuizPool")
	@ResponseBody
	public ModelAndView addAbacusQuizPool(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		ModelAndView model = new ModelAndView("AddQuestions");
		request.setCharacterEncoding("UTF-8"); 
		String id = request.getParameter("id");
		String category = request.getParameter("category");
		String checkpoint = request.getParameter("checkpoint");
		String questions = request.getParameter("question");
		//int answer = Integer.parseInt(request.getParameter("answer"));
		String grade = request.getParameter("grade");
		String tag = request.getParameter("tag");
		AbacusQuizPool aq = new AbacusQuizPool();
		String[] tags = tags=tag.split("|");
		List<String> tg = new ArrayList();
		for(String str : tags){
			tg.add(str);
		}
		
		String[] question = questions.split("|");
		List<String> que = new ArrayList();
		for(String str : question){
			que.add(str);
		}		
		//aq.setAnswer(answer);
		aq.setCategory(category);
		aq.setCheckpoint(checkpoint);
		aq.setId(id);
		aq.setQuestion(que);
		aq.setGrade(grade);
		aq.setTag(tg);

		if(MongoDBBasic.createAbacusQuizPool(aq)){
			
		}
		return model;
	}
	
	@RequestMapping("/getAllAbacusQuizPool")
	public @ResponseBody List<AbacusQuizPool> getAllAbacusQuizPool(){
		List<AbacusQuizPool> quizs=MongoDBBasic.findAllAbacusQuizPool();
		return quizs;
	}
	
	@RequestMapping("/getAbacusQuizPoolBycategory")
	public @ResponseBody List<AbacusQuizPool> getAbacusQuizPoolBycategory(@RequestParam(value="category")String category){
		List<AbacusQuizPool> quizs=MongoDBBasic.findAbacusQuizPoolBycategory(category);
		return quizs;
	}
}
