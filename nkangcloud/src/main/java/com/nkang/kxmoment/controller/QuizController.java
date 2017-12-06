package com.nkang.kxmoment.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	
	//test
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
	public String addAbacusQuizPool(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		ModelAndView model = new ModelAndView("AddQuestions");
		request.setCharacterEncoding("UTF-8"); 
		String id = request.getParameter("id");
		String category = request.getParameter("category");
		String checkpoint = request.getParameter("checkpoint");
		String questions = request.getParameter("question");
		String title = request.getParameter("title");
		String grade = request.getParameter("grade");
		String tag = request.getParameter("tag");
		//序号
		String questionSequence = request.getParameter("qSequence");
		//题号
		String batchId = request.getParameter("batchId");
		AbacusQuizPool aq = new AbacusQuizPool();
		String[] tags = tags=tag.split(",");
		List<String> tg = new ArrayList();
		for(String str : tags){
			tg.add(str);
		}
		
		String[] question = questions.split(",");
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
		aq.setTitle(title);
		
		aq.setQuestionSequence(questionSequence);
		aq.setBatchId(batchId);
		
		if(MongoDBBasic.createAbacusQuizPool(aq)){
			//request.getSession().setAttribute("test", "123");
			//session.setAttribute("test", "123");
			return que.toString();
		}
		
		
		return tg.toString();
		
	}
	
	@RequestMapping("/getAllAbacusQuizPool")
	@ResponseBody
	public List<AbacusQuizPool> getAllAbacusQuizPool(){
		
		List<AbacusQuizPool> quizs=MongoDBBasic.findAllAbacusQuizPool();
		//mav.addObject("aq",quizs.get(0).question.toString() );
		return quizs;
		
		
	}
	
	@RequestMapping("/getAbacusQuizPoolBycategory")
	public @ResponseBody List<AbacusQuizPool> getAbacusQuizPoolBycategory(@RequestParam(value="category")String category){
		List<AbacusQuizPool> quizs=MongoDBBasic.findAbacusQuizPoolBycategory(category);
		return quizs;
	}
	@RequestMapping("/getAbacusQuizPoolById")
	public @ResponseBody List<AbacusQuizPool> getAbacusQuizPoolById(@RequestParam(value="id")String id){
		List<AbacusQuizPool> quizs=MongoDBBasic.findAbacusQuizPoolById(id);
		return quizs;
	}
	
	
	
	@RequestMapping("/getAbacusQuizPoolBycategory1")
	public ModelAndView getAbacusQuizPoolBycategory1(@RequestParam(value="category")String category,HttpSession session){
		List<AbacusQuizPool> quizs=MongoDBBasic.findAbacusQuizPoolBycategory(category);
		ModelAndView mav = new ModelAndView("QuestionsManagement");
		mav.addObject("time", new Date());
		if(null!=quizs){
			mav.getModel().put("aq",quizs.get(0));

			session.setAttribute("list",quizs);
		}
		
		
		return mav;
	}
	

	@RequestMapping("/deleteByID")
	public ModelAndView deleteByID(@RequestParam(value="id")String id,HttpSession session){
		List<AbacusQuizPool> quizs=MongoDBBasic.findAbacusQuizPoolById(id);
		
		ModelAndView mav;
		
		if(MongoDBBasic.deleteAbacusQuizPoolById(id)==true){
			
			mav = new ModelAndView("QuestionsManagement");
			mav.addObject("time", new Date());
			if(null!=quizs){
				mav.getModel().put("aq",quizs.get(0));

				session.setAttribute("list",quizs);
			}
		
		}else{
			mav = new ModelAndView("AddQuestions");
		}
		return mav;
		
		
	}
}
