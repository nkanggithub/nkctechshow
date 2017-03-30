package com.nkang.kxmoment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nkang.kxmoment.baseobject.RoleOfAreaMap;
import com.nkang.kxmoment.util.RestUtils;

@Controller
@RequestMapping("/userProfile")
public class RoleOfAreaMapController {
	@RequestMapping(value = "/setRoleOfAreaMap", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public boolean setRoleOfAreaMap(HttpServletRequest request,
			HttpServletResponse response) {
		RoleOfAreaMap role=new RoleOfAreaMap();
		role.setId("Role001");
		role.setFlag("Role");
		role.setName("应用负责人 (App Lead)");
		
		role=new RoleOfAreaMap();
		role.setId("Role002");
		role.setFlag("Role");
		role.setName("开发协调大师 (SM)");
		
		role=new RoleOfAreaMap();
		role.setId("Role003");
		role.setFlag("Role");
		role.setName("产品负责人 (PO/BA)");
		
		role=new RoleOfAreaMap();
		role.setId("Role004");
		role.setFlag("Role");
		role.setName("技术专家 (Tech Lead)");
		
		role=new RoleOfAreaMap();
		role.setId("Role005");
		role.setFlag("Role");
		role.setName("软件开发工程师");
		
		role=new RoleOfAreaMap();
		role.setId("Role006");
		role.setFlag("Role");
		role.setName("软件测试工程师");
		
		role=new RoleOfAreaMap();
		role.setId("Role007");
		role.setFlag("Role");
		role.setName("产品运维工程师");
		
		role=new RoleOfAreaMap();
		role.setId("Role008");
		role.setFlag("Role");
		role.setName("系统架构师");
		
		role=new RoleOfAreaMap();
		role.setId("Role009");
		role.setFlag("Role");
		role.setName("质量控制工程师");
		
		//---------------------------------------------------
		
		RoleOfAreaMap area=new RoleOfAreaMap();
		area.setId("Area001");
		area.setFlag("Area");
		area.setName("Linux 系统操作实践");

		area=new RoleOfAreaMap();
		area.setId("Area002");
		area.setFlag("Area");
		area.setName("业务系统分析与设计");
		
		area=new RoleOfAreaMap();
		area.setId("Area003");
		area.setFlag("Area");
		area.setName("业务问题追踪");
		
		area=new RoleOfAreaMap();
		area.setId("Area004");
		area.setFlag("Area");
		area.setName("产品环境重大问题追踪");
		
		area=new RoleOfAreaMap();
		area.setId("Area005");
		area.setFlag("Area");
		area.setName("Office 办公软件实践");
		
		area=new RoleOfAreaMap();
		area.setId("Area006");
		area.setFlag("Area");
		area.setName("结对编程");
		
		area=new RoleOfAreaMap();
		area.setId("Area007");
		area.setFlag("Area");
		area.setName("代码回顾");
		
		area=new RoleOfAreaMap();
		area.setId("Area008");
		area.setFlag("Area");
		area.setName("架构设计");
		
		area=new RoleOfAreaMap();
		area.setId("Area009");
		area.setFlag("Area");
		area.setName("项目管理讨论");
		
		area=new RoleOfAreaMap();
		area.setId("Area010");
		area.setFlag("Area");
		area.setName("数据问题分析");
		
		area=new RoleOfAreaMap();
		area.setId("Area001");
		area.setFlag("Area");
		area.setName("");
		
		area=new RoleOfAreaMap();
		area.setId("Area011");
		area.setFlag("Area");
		area.setName("团队活动");
		
		area=new RoleOfAreaMap();
		area.setId("Area012");
		area.setFlag("Area");
		area.setName("志愿者招募");
		
		area=new RoleOfAreaMap();
		area.setId("Area013");
		area.setFlag("Area");
		area.setName("悬赏问题或帮助");
		
		area=new RoleOfAreaMap();
		area.setId("Area014");
		area.setFlag("Area");
		area.setName("测试自动化");
		
		area=new RoleOfAreaMap();
		area.setId("Area015");
		area.setFlag("Area");
		area.setName("数据库管理");
		
		area=new RoleOfAreaMap();
		area.setId("Area016");
		area.setFlag("Area");
		area.setName("DevOps");
		
		return true;
	}
}
