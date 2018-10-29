/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.common.utils.Collections3;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.modules.assess.dao.ReTeacherplanDao;
import com.starsoft.ezicloud.modules.assess.entity.DbClassCourse;
import com.starsoft.ezicloud.modules.assess.entity.DbClassCourseChild;
import com.starsoft.ezicloud.modules.assess.entity.DbCourseinfo;
import com.starsoft.ezicloud.modules.assess.entity.ReTeacherplan;
import com.starsoft.ezicloud.modules.assess.service.DbClassCourseService;
import com.starsoft.ezicloud.modules.assess.service.DbCourseinfoService;
import com.starsoft.ezicloud.modules.assess.service.ReTeacherplanService;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.DictUtils;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;

/**
 * 班级课程信息Controller
 * @author suxl
 * @version 2017-10-10
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbClassCourse")
public class DbClassCourseController extends BaseController {

	@Autowired
	private DbClassCourseService dbClassCourseService;
	@Autowired
	private ReTeacherplanDao reTeacherplanDao;
	@Autowired
	private DbCourseinfoService dbCourseinfoService;
	
	@ModelAttribute
	public DbClassCourse get(@RequestParam(required=false) String id) {
		DbClassCourse entity = null;
		
		if (StringUtils.isNotBlank(id)){
			entity = dbClassCourseService.get(id);
			String userid = UserUtils.getUser().getId();
			for (DbClassCourseChild dbClassCourseChild : entity.getDbClassCourseChildList()){
				if (StringUtils.isNotBlank(dbClassCourseChild.getId())) {
					ReTeacherplan plan = new ReTeacherplan();
					plan.setClassCourseChildId(dbClassCourseChild.getId());
				    plan.setTeacherId(userid);
				    
				    List<ReTeacherplan> list = reTeacherplanDao.findList(plan);
				    if (list != null && list.size() >0) {
				    	dbClassCourseChild.setDef1(list.get(0).getFileUrl());
					}
				    
				}
			}
		}
		if (entity == null){
			entity = new DbClassCourse();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbClassCourse:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbClassCourse dbClassCourse, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DbClassCourse> page = dbClassCourseService.findPage(new Page<DbClassCourse>(request, response), dbClassCourse); 
		model.addAttribute("page", page);
		return "modules/assess/dbClassCourseList";
	}

	@RequiresPermissions("assess:dbClassCourse:view")
	@RequestMapping(value = "form")
	public String form(DbClassCourse dbClassCourse, Model model) {
		model.addAttribute("dbClassCourse", dbClassCourse);
		return "modules/assess/dbClassCourseForm";
	}
	@SuppressWarnings("unchecked")
	@RequiresPermissions("assess:dbClassCourse:view")
	@RequestMapping(value = "getById")
	@ResponseBody
	public DbClassCourse getById(String ids, Model model) {
		
		DbClassCourse dbClassCourse=dbClassCourseService.getById(ids);
		
		return dbClassCourse;
	}

	@RequiresPermissions("assess:dbClassCourse:view")
	@RequestMapping(value = "detail")
	public String detail(DbClassCourse dbClassCourse, Model model) {
		model.addAttribute("dbClassCourse", dbClassCourse);
		return "modules/assess/dbClassCourseDetail";
	}

	@RequiresPermissions("assess:dbClassCourse:edit")
	@RequestMapping(value = "save")
	public String save(DbClassCourse dbClassCourse, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbClassCourse)){
			return form(dbClassCourse, model);
		}
		dbClassCourseService.save(dbClassCourse);
		
		addMessage(redirectAttributes, "保存班级课程信息成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbClassCourse/?repage";
	}
	
	@RequiresPermissions("assess:dbClassCourse:edit")
	@RequestMapping(value = "delete")
	public String delete(DbClassCourse dbClassCourse, RedirectAttributes redirectAttributes) {
		dbClassCourseService.delete(dbClassCourse);
		addMessage(redirectAttributes, "删除班级课程信息成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbClassCourse/?repage";
	}
	
	@RequiresPermissions("assess:dbClassCourse:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbClassCourse dbClassCourse, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "班级课程信息" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbClassCourse> page = dbClassCourseService.findPage(new Page<DbClassCourse>(request, response, -1), dbClassCourse);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("班级课程信息", DbClassCourse.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出班级课程信息失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbClassCourse/list?repage";
	}
	
	@RequiresPermissions("assess:dbClassCourse:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbClassCourse dbClassCourse, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<DbCourseinfo> findList = dbCourseinfoService.findList(new DbCourseinfo());
		List extractToList = Collections3.extractToList(findList, "name");
		list(dbClassCourse, request, response, model);
		model.addAttribute("extractToList", extractToList);
		return "modules/assess/dbClassCourseReferenceList";
	}

}