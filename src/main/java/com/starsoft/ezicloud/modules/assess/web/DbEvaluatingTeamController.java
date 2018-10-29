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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.starsoft.ezicloud.common.config.Global;
import com.starsoft.ezicloud.common.persistence.Page;
import com.starsoft.ezicloud.common.web.BaseController;
import com.starsoft.ezicloud.common.utils.DateUtils;
import com.starsoft.ezicloud.common.utils.StringUtils;
import com.starsoft.ezicloud.common.utils.excel.ExportExcel;
import com.starsoft.ezicloud.modules.assess.entity.DbEvaluatingTeam;
import com.starsoft.ezicloud.modules.assess.service.DbEvaluatingTeamService;
import com.starsoft.ezicloud.modules.sys.dao.UserDao;
import com.starsoft.ezicloud.modules.sys.entity.User;
import com.starsoft.ezicloud.modules.sys.utils.UserUtils;

/**
 * 评价小组Controller
 * @author suxl
 * @version 2017-09-19
 */
@Controller
@RequestMapping(value = "${adminPath}/assess/dbEvaluatingTeam")
public class DbEvaluatingTeamController extends BaseController {

	@Autowired
	private DbEvaluatingTeamService dbEvaluatingTeamService;
	
	@ModelAttribute
	public DbEvaluatingTeam get(@RequestParam(required=false) String id) {
		DbEvaluatingTeam entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = dbEvaluatingTeamService.get(id);
		}
		if (entity == null){
			entity = new DbEvaluatingTeam();
		}
		return entity;
	}
	
	@RequiresPermissions("assess:dbEvaluatingTeam:view")
	@RequestMapping(value = {"list", ""})
	public String list(DbEvaluatingTeam dbEvaluatingTeam, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<DbEvaluatingTeam> page = dbEvaluatingTeamService.findPage(new Page<DbEvaluatingTeam>(request, response), dbEvaluatingTeam); 
		model.addAttribute("page", page);
		return "modules/assess/dbEvaluatingTeamList";
	}

	@RequiresPermissions("assess:dbEvaluatingTeam:view")
	@RequestMapping(value = "form")
	public String form(DbEvaluatingTeam dbEvaluatingTeam, Model model) {
		model.addAttribute("dbEvaluatingTeam", dbEvaluatingTeam);
		return "modules/assess/dbEvaluatingTeamForm";
	}

	@RequiresPermissions("assess:dbEvaluatingTeam:view")
	@RequestMapping(value = "detail")
	public String detail(DbEvaluatingTeam dbEvaluatingTeam, Model model) {
		model.addAttribute("dbEvaluatingTeam", dbEvaluatingTeam);
		return "modules/assess/dbEvaluatingTeamDetail";
	}
	
	
	

	@RequiresPermissions("assess:dbEvaluatingTeam:edit")
	@RequestMapping(value = "save")
	public String save(DbEvaluatingTeam dbEvaluatingTeam, Model model, RedirectAttributes redirectAttributes) {
		dbEvaluatingTeamService.save(dbEvaluatingTeam);
		addMessage(redirectAttributes, "保存评价小组成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbEvaluatingTeam/?repage";
	}
	
	@RequiresPermissions("assess:dbEvaluatingTeam:edit")
	@RequestMapping(value = "delete")
	public String delete(DbEvaluatingTeam dbEvaluatingTeam, RedirectAttributes redirectAttributes) {
		dbEvaluatingTeamService.delete(dbEvaluatingTeam);
		addMessage(redirectAttributes, "删除评价小组成功");
		return "redirect:"+Global.getAdminPath()+"/assess/dbEvaluatingTeam/?repage";
	}
	
	@RequiresPermissions("assess:dbEvaluatingTeam:view")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(DbEvaluatingTeam dbEvaluatingTeam, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "评价小组" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<DbEvaluatingTeam> page = dbEvaluatingTeamService.findPage(new Page<DbEvaluatingTeam>(request, response, -1), dbEvaluatingTeam);
			// 解决firefox下载中文无法显示的问题
			String UserAgent = request.getHeader("USER-AGENT").toLowerCase();
			new ExportExcel("评价小组", DbEvaluatingTeam.class).setDataList(page.getList()).write(response, fileName, !UserAgent.contains("firefox")).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出评价小组失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/assess/dbEvaluatingTeam/list?repage";
	}
	
	@RequiresPermissions("assess:dbEvaluatingTeam:view")
	@RequestMapping(value = "reference", method = RequestMethod.POST)
	public String selectList(DbEvaluatingTeam dbEvaluatingTeam, HttpServletRequest request, HttpServletResponse response, Model model) {
		list(dbEvaluatingTeam, request, response, model);
		return "modules/assess/dbEvaluatingTeamReferenceList";
	}

}