/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

import static org.hamcrest.CoreMatchers.nullValue;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.restlet.util.StringReadingListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.modules.assess.dao.ViewJobDao;
import com.starsoft.ezicloud.modules.assess.entity.ViewJob;
import com.starsoft.ezicloud.modules.assess.service.ViewJobService;
import com.starsoft.ezicloud.modules.assess.utilts.SimplePoolDemo;
import com.starsoft.ezicloud.modules.assess.utilts.SqlObject;

/**
 * 任务统计Controller
 * @author tcf
 * @version 2017-09-27
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/viewJob")
public class ViewJobController extends BaseController {

	@Autowired
	private ViewJobService viewJobService;
	@Autowired
	private ViewJobDao viewJobDao;
	
	
	
	@ModelAttribute
	public ViewJob get(@RequestParam(required=false) String id) {
		ViewJob entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = viewJobService.get(id);
		}
		if (entity == null){
			entity = new ViewJob();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:viewJob:view")
	@RequestMapping(value = "list1")
	public String list1(ViewJob viewJob, HttpServletRequest request, HttpServletResponse response, Model model) {
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> list1 = new ArrayList<String>();
		SimplePoolDemo simplePoolDemo = new SimplePoolDemo();
		Connection connection = simplePoolDemo.getConnectionFromPool();
		
		try {
			Statement statement = connection.createStatement();
			ResultSet set = statement.executeQuery("show full columns from view_job"); 
			 while (set.next()) {     
	                System.out.println(set.getString("Field"));  
	                if (!"job".equals(set.getString("Field")) && !"start_date".equals(set.getString("Field")) && !"end_date".equals(set.getString("Field")) && !"score".equals(set.getString("Field"))) {
	                	list.add(set.getString("Field"));
					}
	            }
			 set.close();
			 statement.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			SimplePoolDemo.release(connection);
		}
		 Map<String, String> attributeControl = attributeControl();
		for (String string : list) {
			if(attributeControl.containsKey(string)){
				list1.add(attributeControl.get(string));
			}
			
		}
		
		
//		Page<ViewJob> page = viewJobService.findPage(new Page<ViewJob>(request, response), viewJob); 
		model.addAttribute("list", list1);
		return "modules/assess/viewJobList1";
	}
	
	
	@RequestMapping(value = "list")
	public String list(ViewJob viewJob, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws Exception{
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> list1 = new ArrayList<String>();
		HashMap<String, String> map = new HashMap<String,String>();
		String course = viewJob.getDef1();
		StringBuilder sqlString = null;
		Page<ViewJob> page=null;
		
		
		if (StringUtils.isNotBlank(course)) {
			String substring = course.substring(1);
			Map<String, String> attributeControl = attributeControl1();
			if (StringUtils.isNotBlank(substring)) {
				String[] split = substring.split(",");
				sqlString = new StringBuilder();
//				sqlString.append("a.job AS job,");
				
				for (String string : split) {
					if(attributeControl.containsKey(string)){
						String e = attributeControl.get(string);
						list.add(e);
						sqlString.append("ANY_VALUE(a."+e+") AS "+e+",");
						list1.add(string);
						map.put(e, string);
					}else{
						System.err.println(string);
					}
				}
				sqlString.append("ANY_VALUE(a.start_date) AS startDate,ANY_VALUE(a.end_date) AS endDate,avg(a.score) AS score");
				System.out.println(sqlString);
			}
			
			
			String teacher = viewJob.getDef2();
			StringBuilder group = null;
			if (StringUtils.isNotBlank(teacher)) {
				String substring1 = teacher.substring(1);
				if (StringUtils.isNotBlank(substring1)) {
					String[] split = substring1.split(",");
					 group = new StringBuilder();
					for (String string : split) {
						if(attributeControl.containsKey(string)){
							String e = attributeControl.get(string);
							group.append("a."+e+",");
						}else{
							System.err.println(string);
						}
					}
					System.out.println(group.deleteCharAt(group.length()-1));
				}
			}
			if (sqlString!=null) {
				viewJob.getSqlMap().put("dsf", sqlString.toString());
			}
			if (group !=null) {
				viewJob.getSqlMap().put("group", group.toString());
			}
			page = viewJobService.findPage(new Page<ViewJob>(request, response), viewJob);
			List<ViewJob> list2 = page.getList();
			for (ViewJob viewJob2 : list2) {
				for (String string : list) {
					String name = string.substring(0, 1).toUpperCase() + string.substring(1); // 将属性的首字符大写，方便构造get，set方法
					List<String> viewJobL = viewJob2.getViewJobL();
					Method m = viewJob2.getClass().getMethod("get" + name);
	                String value = (String) m.invoke(viewJob2); // 调用getter方法获取属性值
	                System.out.println("输出:"+value);
	                viewJobL.add(value);
				}
			}
		}else {
			addMessage(redirectAttributes, "你没选择显示列表");
			return "redirect:"+Global.getAdminPath()+"/assess/viewJob/list1";
		}
		
		model.addAttribute("page", page);
		model.addAttribute("list", list);
		model.addAttribute("list1", list1);
		model.addAttribute("map", map);
		return "modules/assess/viewJobList";
	}
	@RequiresPermissions("assess:viewJob:view")
	@RequestMapping(value = {"findListgroup", ""})
	public String findListgroup(SqlObject sqlobject, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<ViewJob> list = new ArrayList<ViewJob>();
		if(StringUtils.isNotBlank(sqlobject.getCloums())){
			 list = viewJobDao.findListgroup(sqlobject);
		}else{
			sqlobject.setCloums("a.job AS job,a.course AS course,a.teacher AS teacher,a.area AS area,a.school AS school");
			sqlobject.setGroup("a.teacher");
			list = viewJobDao.findListgroup(sqlobject);
		}
		model.addAttribute("list", list);
		return "modules/assess/viewJobTotal";
	}

	@RequiresPermissions("assess:viewJob:view")
	@RequestMapping(value = "form")
	public String form(ViewJob viewJob, Model model) {
		model.addAttribute("viewJob", viewJob);
		return "modules/assess/viewJobForm";
	}

	@RequiresPermissions("assess:viewJob:view")
	@RequestMapping(value = "detail")
	public String detail(ViewJob viewJob, Model model) {
		model.addAttribute("viewJob", viewJob);
		return "modules/assess/viewJobDetail";
	}

	@RequiresPermissions("assess:viewJob:edit")
	@RequestMapping(value = "save")
	public String save(ViewJob viewJob, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, viewJob)){
			return form(viewJob, model);
		}
		viewJobService.save(viewJob);
		addMessage(redirectAttributes, "保存任务统计成功");
		return "redirect:"+Global.getAdminPath()+"/assess/viewJob/?repage";
	}
	
	@RequiresPermissions("assess:viewJob:edit")
	@RequestMapping(value = "delete")
	public String delete(ViewJob viewJob, RedirectAttributes redirectAttributes) {
		viewJobService.delete(viewJob);
		addMessage(redirectAttributes, "删除任务统计成功");
		return "redirect:"+Global.getAdminPath()+"/assess/viewJob/?repage";
	}
	
	@RequiresPermissions("assess:viewJob:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(ViewJob viewJob, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "任务统计" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<ViewJob> page = viewJobService.findPage(new Page<ViewJob>(request, response, -1), viewJob);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("任务统计", ViewJob.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出任务统计失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/viewJob/list?repage";
	}
	
	@RequiresPermissions("assess:viewJob:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(ViewJob viewJob, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws Exception{
		list(viewJob, request, response, model,redirectAttributes);
		return "modules/assess/viewJobReferenceList";
	}

	/**
	 * 字段中英文对照1
	 * */
	 private static Map<String,String> attributeControl(){
		 Map<String, String> map = new HashMap<String, String>();
		 map.put("course","学科");		
		 map.put("teacher","教师");		
		 map.put("area","区域");		
		 map.put("school","学校");		
		 map.put("version","版本");		
		 map.put("grade","年级");		
		 map.put("ce","上下册");
		 map.put("bookunit","单元");		
		 map.put("chapter","章节");	
			return map;
	 }
	    /**
		 * 字段中英文对照2
		 * */
	 private static Map<String,String> attributeControl1(){
		 Map<String, String> map = new HashMap<String, String>();
		 Map<String, String> attributeControl = attributeControl();
		 for(String key :attributeControl.keySet()){
			 map.put(attributeControl.get(key), key);
		 }
		 return map;
	 }
}