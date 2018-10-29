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
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.modules.assess.dao.DbQuestionnaireSurveyDao;
import com.starsoft.ezicloud.modules.assess.entity.DbQuestionnaireSurvey;
import com.starsoft.ezicloud.modules.assess.service.DbQuestionnaireSurveyService;
import com.starsoft.ezicloud.modules.sys.entity.User;

/**
 * 问卷调查Controller
 * @author tcf
 * @version 2017-11-08
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbQuestionnaireSurvey")
public class DbQuestionnaireSurveyController extends BaseController {

	@Autowired
	private DbQuestionnaireSurveyService dbQuestionnaireSurveyService;
	@ModelAttribute
	public DbQuestionnaireSurvey get(@RequestParam(required=false) String id) {
		DbQuestionnaireSurvey entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbQuestionnaireSurveyService.get(id);
		}
		if (entity == null){
			entity = new DbQuestionnaireSurvey();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbQuestionnaireSurvey:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbQuestionnaireSurvey dbQuestionnaireSurvey, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DbQuestionnaireSurvey> page = dbQuestionnaireSurveyService.findPage(new Page<DbQuestionnaireSurvey>(request, response), dbQuestionnaireSurvey); 
		model.addAttribute("page", page);
		return "modules/assess/dbQuestionnaireSurveyList";
	}

	@RequiresPermissions("assess:dbQuestionnaireSurvey:view")
	@RequestMapping(value = "form")
	public String form(DbQuestionnaireSurvey dbQuestionnaireSurvey, Model model) {
		model.addAttribute("dbQuestionnaireSurvey", dbQuestionnaireSurvey);
		return "modules/assess/dbQuestionnaireSurveyForm";
	}

	@RequiresPermissions("assess:dbQuestionnaireSurvey:view")
	@RequestMapping(value = "detail")
	public String detail(DbQuestionnaireSurvey dbQuestionnaireSurvey, Model model) {
		model.addAttribute("dbQuestionnaireSurvey", dbQuestionnaireSurvey);
		return "modules/assess/dbQuestionnaireSurveyDetail";
	}
	@RequiresPermissions("assess:dbQuestionnaireSurvey:view")
	@RequestMapping(value = "see")
	public String see(String teacher, Model model) {
		DbQuestionnaireSurvey dbQuestionnaireSurvey = new DbQuestionnaireSurvey();
		dbQuestionnaireSurvey.setCreateBy(new User(teacher));
		DbQuestionnaireSurvey questionnaireSurvey = dbQuestionnaireSurveyService.findList(dbQuestionnaireSurvey).get(0);
		model.addAttribute("dbQuestionnaireSurvey", questionnaireSurvey);
		return "modules/assess/dbQuestionnaireSurveyDetail";
	}

	@RequiresPermissions("assess:dbQuestionnaireSurvey:edit")
	@RequestMapping(value = "save")
	public String save(DbQuestionnaireSurvey dbQuestionnaireSurvey, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbQuestionnaireSurvey)){
			return form(dbQuestionnaireSurvey, model);
		}
		dbQuestionnaireSurveyService.save(dbQuestionnaireSurvey);
		addMessage(redirectAttributes, "保存问卷调查成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbQuestionnaireSurvey/?repage";
	}
	
	@RequiresPermissions("assess:dbQuestionnaireSurvey:edit")
	@RequestMapping(value = "delete")
	public String delete(DbQuestionnaireSurvey dbQuestionnaireSurvey, RedirectAttributes redirectAttributes) {
		dbQuestionnaireSurveyService.delete(dbQuestionnaireSurvey);
		addMessage(redirectAttributes, "删除问卷调查成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbQuestionnaireSurvey/?repage";
	}
	
	@RequiresPermissions("assess:dbQuestionnaireSurvey:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbQuestionnaireSurvey dbQuestionnaireSurvey, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "问卷调查" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbQuestionnaireSurvey> page = dbQuestionnaireSurveyService.findPage(new Page<DbQuestionnaireSurvey>(request, response, -1), dbQuestionnaireSurvey);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("问卷调查", DbQuestionnaireSurvey.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出问卷调查失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbQuestionnaireSurvey/list?repage";
	}
	
	@RequiresPermissions("assess:dbQuestionnaireSurvey:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbQuestionnaireSurvey dbQuestionnaireSurvey, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(dbQuestionnaireSurvey, request, response, model);
		return "modules/assess/dbQuestionnaireSurveyReferenceList";
	}

}