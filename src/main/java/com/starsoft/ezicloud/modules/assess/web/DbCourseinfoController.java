/**
 * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
 */
package com.starsoft.ezicloud.modules.assess.web;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.modules.assess.entity.DbCourseinfo;
import com.starsoft.ezicloud.modules.assess.service.DbCourseinfoService;
import com.starsoft.ezicloud.modules.sys.dao.DictDao;
import com.starsoft.ezicloud.modules.sys.entity.Dict;

/**
 * 学科添加Controller
 * @author suxl
 * @version 2017-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbCourseinfo")
public class DbCourseinfoController extends BaseController {

	@Autowired
	private DbCourseinfoService dbCourseinfoService;
	@Autowired
	private DictDao dictDao;
	
	@ModelAttribute
	public DbCourseinfo get(@RequestParam(required=false) String id) {
		DbCourseinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbCourseinfoService.get(id);
		}
		if (entity == null){
			entity = new DbCourseinfo();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbCourseinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbCourseinfo dbCourseinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DbCourseinfo> page = dbCourseinfoService.findPage(new Page<DbCourseinfo>(request, response), dbCourseinfo); 
		model.addAttribute("page", page);
		return "modules/assess/dbCourseinfoList";
	}

	@RequiresPermissions("assess:dbCourseinfo:view")
	@RequestMapping(value = "form")
	public String form(DbCourseinfo dbCourseinfo, Model model) {
		model.addAttribute("dbCourseinfo", dbCourseinfo);
		return "modules/assess/dbCourseinfoForm";
	}

	@RequiresPermissions("assess:dbCourseinfo:view")
	@RequestMapping(value = "detail")
	public String detail(DbCourseinfo dbCourseinfo, Model model) {
		model.addAttribute("dbCourseinfo", dbCourseinfo);
		return "modules/assess/dbCourseinfoDetail";
	}

	@RequiresPermissions("assess:dbCourseinfo:edit")
	@RequestMapping(value = "save")
	public String save(DbCourseinfo dbCourseinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbCourseinfo)){
			return form(dbCourseinfo, model);
		}
		dbCourseinfoService.save(dbCourseinfo);
		addMessage(redirectAttributes, "保存学科添加成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbCourseinfo/?repage";
	}
	
	@RequiresPermissions("assess:dbCourseinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(DbCourseinfo dbCourseinfo, RedirectAttributes redirectAttributes) {
		dbCourseinfoService.delete(dbCourseinfo);
		addMessage(redirectAttributes, "删除学科添加成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbCourseinfo/?repage";
	}
	
	@RequiresPermissions("assess:dbCourseinfo:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbCourseinfo dbCourseinfo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "学科添加" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbCourseinfo> page = dbCourseinfoService.findPage(new Page<DbCourseinfo>(request, response, -1), dbCourseinfo);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("学科添加", DbCourseinfo.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出学科添加失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbCourseinfo/list?repage";
	}
	
	@RequiresPermissions("assess:dbCourseinfo:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbCourseinfo dbCourseinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(dbCourseinfo, request, response, model);
		return "modules/assess/dbCourseinfoReferenceList";
	}

}