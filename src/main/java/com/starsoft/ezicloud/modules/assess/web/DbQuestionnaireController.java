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
import com.starsoft.ezicloud.modules.assess.dao.DbAssessIndexDao;
import com.starsoft.ezicloud.modules.assess.dao.DbLevelDao;
import com.starsoft.ezicloud.modules.assess.entity.DbAssessIndex;
import com.starsoft.ezicloud.modules.assess.entity.DbLevel;
import com.starsoft.ezicloud.modules.assess.entity.DbQuestionnaire;
import com.starsoft.ezicloud.modules.assess.entity.ReQuestionnaireAssess;
import com.starsoft.ezicloud.modules.assess.service.DbQuestionnaireService;

/**
 * 评价工具Controller
 * @author zsd
 * @version 2017-09-19
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbQuestionnaire")
public class DbQuestionnaireController extends BaseController {

	@Autowired
	private DbQuestionnaireService dbQuestionnaireService;
	@Autowired
	private DbLevelDao dbLevelDao;
	@Autowired
	private DbAssessIndexDao dbAssessIndexDao;
	
	@ModelAttribute
	public DbQuestionnaire get(@RequestParam(required=false) String id) {
		DbQuestionnaire entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbQuestionnaireService.get(id);
		}
		if (entity == null){
			entity = new DbQuestionnaire();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbQuestionnaire:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbQuestionnaire dbQuestionnaire, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DbQuestionnaire> page = dbQuestionnaireService.findPage(new Page<DbQuestionnaire>(request, response), dbQuestionnaire); 
		model.addAttribute("page", page);
		return "modules/assess/dbQuestionnaireList";
	}

	@RequiresPermissions("assess:dbQuestionnaire:view")
	@RequestMapping(value = "form")
	public String form(DbQuestionnaire dbQuestionnaire, Model model) {
		if(StringUtils.isNotBlank(dbQuestionnaire.getId())){
			for(ReQuestionnaireAssess reQuestionnaireAssess : dbQuestionnaire.getReQuestionnaireAssessList()){
				if(reQuestionnaireAssess.getAssessId()!=null){
					String assessId = reQuestionnaireAssess.getAssessId().getId();
					
					DbAssessIndex dbAssessIndex = dbAssessIndexDao.get(assessId);
					if(dbAssessIndex != null){
						
					String levelId = dbAssessIndex.getLevelId().getId();
					DbLevel dbLevel = dbLevelDao.get(levelId);
					if (dbLevel != null) {
						
					String parentIds = dbLevel.getParentIds();
					String[] split = parentIds.split(",");
				DbLevel dbLevel1 = dbLevelDao.get(split[1]);
				DbLevel dbLevel2 = dbLevelDao.get(split[2]);
				reQuestionnaireAssess.setAssessId1(dbLevel1.getName());
				reQuestionnaireAssess.setAssessId2(dbLevel2.getName());
				reQuestionnaireAssess.setDef1(dbLevel.getName());
				reQuestionnaireAssess.setDef2(dbAssessIndex.getContent());
					}
					}
				}

			}
		}
		model.addAttribute("dbQuestionnaire", dbQuestionnaire);
		return "modules/assess/dbQuestionnaireForm";
	}

	@RequiresPermissions("assess:dbQuestionnaire:view")
	@RequestMapping(value = "detail")
	public String detail(DbQuestionnaire dbQuestionnaire, Model model) {
		model.addAttribute("dbQuestionnaire", dbQuestionnaire);
		return "modules/assess/dbQuestionnaireDetail";
	}

	@RequiresPermissions("assess:dbQuestionnaire:edit")
	@RequestMapping(value = "save")
	public String save(DbQuestionnaire dbQuestionnaire, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, dbQuestionnaire)){
			return form(dbQuestionnaire, model);
		}
		dbQuestionnaireService.save(dbQuestionnaire);
		addMessage(redirectAttributes, "保存评价工具成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbQuestionnaire/?repage";
	}
	
	@RequiresPermissions("assess:dbQuestionnaire:edit")
	@RequestMapping(value = "delete")
	public String delete(DbQuestionnaire dbQuestionnaire, RedirectAttributes redirectAttributes) {
		dbQuestionnaireService.delete(dbQuestionnaire);
		addMessage(redirectAttributes, "删除评价工具成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbQuestionnaire/?repage";
	}
	
	@RequiresPermissions("assess:dbQuestionnaire:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbQuestionnaire dbQuestionnaire, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "评价工具" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbQuestionnaire> page = dbQuestionnaireService.findPage(new Page<DbQuestionnaire>(request, response, -1), dbQuestionnaire);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("评价工具", DbQuestionnaire.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出评价工具失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbQuestionnaire/list?repage";
	}
	
	@RequiresPermissions("assess:dbQuestionnaire:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbQuestionnaire dbQuestionnaire, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(dbQuestionnaire, request, response, model);
		return "modules/assess/dbQuestionnaireReferenceList";
	}

}